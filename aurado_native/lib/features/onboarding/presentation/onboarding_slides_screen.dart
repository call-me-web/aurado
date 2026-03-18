import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/ui_extensions.dart';
import '../providers/onboarding_provider.dart';

class OnboardingSlidesScreen extends ConsumerStatefulWidget {
  const OnboardingSlidesScreen({super.key});

  @override
  ConsumerState<OnboardingSlidesScreen> createState() => _OnboardingSlidesScreenState();
}

class _OnboardingSlidesScreenState extends ConsumerState<OnboardingSlidesScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingSlideData> _slides = [
    _OnboardingSlideData(
      title: 'স্বাগতম, শিক্ষার্থী! 🎉',
      description: 'তুমি এখন বাংলাদেশের সেরা EdTechগুলোতে এক্সেস পেয়েছ। এক অ্যাপেই সব সমাধান।',
      icon: Icons.celebration_rounded,
    ),
    _OnboardingSlideData(
      title: 'সব কিছু এক জায়গায়',
      description: '১০০+ প্ল্যাটফর্ম আর হাজারো কোর্স—সবই এখন তোমার হাতের মুঠোয়।',
      icon: Icons.auto_awesome_motion_rounded,
    ),
    _OnboardingSlideData(
      title: 'পারফেক্ট লার্নিং এক্সপেরিয়েন্স',
      description: 'লাইভ ক্লাস, এক্সাম আর অফলাইন ডাউনলোড—এখন পড়াশোনা হবে আরও সহজ ও নিরাপদ।',
      icon: Icons.security_rounded,
    ),
    _OnboardingSlideData(
      title: 'তোমার জন্য স্পেশাল',
      description: 'তোমার পড়াশোনার ধরন অনুযায়ী আমরা সবকিছু সাজিয়ে দেব। চলো শুরু করি!',
      icon: Icons.personal_video_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _slides.length,
                itemBuilder: (context, index) => _buildSlide(_slides[index]),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      _slides.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index 
                              ? theme.colorScheme.primary 
                              : theme.colorScheme.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _slides.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        // Mark onboarding as completed
                        ref.read(onboardingProvider.notifier).completeOnboarding();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                      minimumSize: const Size(56, 56), // Override global infinite width
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    child: Icon(
                      _currentPage == _slides.length - 1 
                          ? Icons.check 
                          : Icons.chevron_right,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(_OnboardingSlideData slide) {
    final theme = Theme.of(context);
    
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                slide.icon,
                size: 100,
                color: theme.colorScheme.primary,
              ),
              32.heightBox,
              Text(
                slide.title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              16.heightBox,
              Text(
                slide.description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlideData {
  final String title;
  final String description;
  final IconData icon;

  _OnboardingSlideData({
    required this.title,
    required this.description,
    required this.icon,
  });
}
