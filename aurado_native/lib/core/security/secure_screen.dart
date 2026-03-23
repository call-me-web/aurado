import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../performance/performance_provider.dart';
import '../../shared/widgets/performance_blur.dart';
import 'dynamic_watermark.dart';

/// Applies native screen-capture prevention, lifecycle blur in App Switcher,
/// and dynamic watermarks to a sensitive widget subtree.
class SecureScreen extends ConsumerStatefulWidget {
  const SecureScreen({
    required this.child,
    this.userName = 'Demo User', // Will be fetched from Auth state in future
    this.userPhone = '+880170000000',
    this.userId = 'UID-0000-0000',
    super.key,
  });

  final Widget child;
  final String userName;
  final String userPhone;
  final String userId;

  @override
  ConsumerState<SecureScreen> createState() => _SecureScreenState();
}

class _SecureScreenState extends ConsumerState<SecureScreen>
    with WidgetsBindingObserver {
  static const _channel = MethodChannel('com.aurado/security');

  bool _isSecure = false;
  bool _isAppBackgrounded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _enableSecureMode();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disableSecureMode();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the app is inactive (App Switcher) or paused, blur the screen.
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      if (!_isAppBackgrounded) {
        setState(() => _isAppBackgrounded = true);
      }
    } else if (state == AppLifecycleState.resumed) {
      if (_isAppBackgrounded) {
        setState(() => _isAppBackgrounded = false);
      }
    }
  }

  Future<void> _enableSecureMode() async {
    try {
      if (_isSecure) return;
      await _channel.invokeMethod<void>('enableSecureMode');
      _isSecure = true;
    } catch (_) {
      // Platform doesn't support secure mode or channel not implemented yet.
    }
  }

  Future<void> _disableSecureMode() async {
    try {
      if (!_isSecure) return;
      await _channel.invokeMethod<void>('disableSecureMode');
      _isSecure = false;
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    // Wrap the child in the dynamic watermark
    Widget content = DynamicWatermark(
      userName: widget.userName,
      userPhone: widget.userPhone,
      userId: widget.userId,
      child: widget.child,
    );

    final performance = ref.watch(performanceProvider);

    // Apply strict blur if app is sent to background (App Switcher view protection)
    return Stack(
      fit: StackFit.passthrough,
      children: [
        content,
        if (_isAppBackgrounded)
          Positioned.fill(
            child: PerformanceBlur(
              blur: 20,
              child: Container(
                color: performance.enableGlassmorphism
                    ? Colors.black.withValues(alpha: 0.5)
                    : Colors.black, // Solid black if we can't blur
                alignment: Alignment.center,
                child: const Icon(
                  Icons.security,
                  color: Colors.white,
                  size: 64,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
