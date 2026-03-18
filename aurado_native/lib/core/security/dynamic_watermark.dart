import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/// A widget that overlays a shifting watermark on top of sensitive content
/// to deter external camera recording.
///
/// Features a visible layer (name/phone) and a bare-minimum invisible forensic layer.
class DynamicWatermark extends StatefulWidget {
  const DynamicWatermark({
    required this.child,
    required this.userName,
    required this.userPhone,
    required this.userId,
    super.key,
  });

  /// The underlying sensitive content (e.g., video player).
  final Widget child;

  /// Visible identifier (name).
  final String userName;

  /// Visible identifier (phone or email).
  final String userPhone;

  /// Invisible/Low-opacity tracking ID for forensic recovery.
  final String userId;

  @override
  State<DynamicWatermark> createState() => _DynamicWatermarkState();
}

class _DynamicWatermarkState extends State<DynamicWatermark> {
  final Random _random = Random();
  Timer? _timer;

  // Alignments range from -1.0 to 1.0
  Alignment _visibleAlignment = Alignment.center;
  Alignment _forensicAlignment = Alignment.topLeft;

  @override
  void initState() {
    super.initState();
    _startWatermarkMovement();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startWatermarkMovement() {
    // Jump position every 6 seconds to defeat static masking
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      setState(() {
        _visibleAlignment = Alignment(
          _random.nextDouble() * 2 - 1, // Range x: -1 to 1
          _random.nextDouble() * 2 - 1, // Range y: -1 to 1
        );
        _forensicAlignment = Alignment(
          _random.nextDouble() * 2 - 1,
          _random.nextDouble() * 2 - 1,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        // ── Visible Watermark ──────────────────────────────────────
        // Low opacity but readable by eye.
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              alignment: _visibleAlignment,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.userName,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.35),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.userPhone,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.35),
                        fontSize: 12,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ── Forensic Watermark ──────────────────────────────────────
        // 1-2% opacity. Nearly invisible to eye, recoverable via image processing (high contrast filters).
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedAlign(
              duration: const Duration(seconds: 1),
              curve: Curves.linear,
              alignment: _forensicAlignment,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.userId,
                  style: TextStyle(
                    color: Colors.grey.shade400.withValues(alpha: 0.015), // Light grey against dark background
                    fontSize: 10,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
