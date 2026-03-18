import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/theme_config.dart';
import '../../../core/theme/ui_extensions.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Choose Your Role'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ThemeConfig.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to Aurado',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              8.heightBox,
              Text(
                'Select how you will use the platform.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                textAlign: TextAlign.center,
              ),
              48.heightBox,
              
              // Student / Learner Card
              _RoleCard(
                title: 'I am a Student',
                subtitle: 'Access courses, take exams, and track progress.',
                icon: Icons.person_outline_rounded,
                onTap: () => context.go(AppRoutes.auth),
              ),
              
              24.heightBox,

              // Teacher / Tenant Info Card
              _RoleCard(
                title: 'I am a Teacher',
                subtitle: 'Manage content and view dashboard (Web Only).',
                icon: Icons.admin_panel_settings_outlined,
                onTap: () {
                  _showTeacherDialog(context);
                },
                isSecondary: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTeacherDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Instructors & Admins'),
        content: const Text(
          'The mobile application is optimized for learners. '
          'To manage your academy, upload courses, and view detailed analytics, '
          'please log in to the Aurado Web Dashboard from your computer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isSecondary = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cardColor = isSecondary ? colorScheme.surface : colorScheme.primary.withValues(alpha: 0.1);
    final borderColor = isSecondary ? Theme.of(context).dividerColor : colorScheme.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ThemeConfig.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(ThemeConfig.spacingLg),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(ThemeConfig.radiusLg),
          border: Border.all(
            color: borderColor,
            width: isSecondary ? ThemeConfig.strokeWidthThin : ThemeConfig.strokeWidthThick,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(ThemeConfig.spacingMd),
              decoration: BoxDecoration(
                color: isSecondary ? colorScheme.surface : colorScheme.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSecondary ? Theme.of(context).textTheme.bodySmall?.color : colorScheme.primary,
              ),
            ),
            16.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: isSecondary ? colorScheme.onSurface : colorScheme.primary,
                        ),
                  ),
                  4.heightBox,
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            16.widthBox,
            Icon(
              Icons.chevron_right_rounded,
              color: isSecondary ? Theme.of(context).textTheme.bodySmall?.color : colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
