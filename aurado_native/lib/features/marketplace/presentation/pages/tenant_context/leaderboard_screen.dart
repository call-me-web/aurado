import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';

class LeaderboardScreen extends StatelessWidget {
  final String tenantId;

  const LeaderboardScreen({
    super.key,
    required this.tenantId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Column(
        children: [
          _buildTopRankers(context, colorScheme, textTheme),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 15, // Placeholder
              itemBuilder: (context, index) {
                if (index < 3) return const SizedBox.shrink(); // Top 3 already shown
                return _buildRankListItem(context, index + 1, colorScheme, textTheme);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildMyRank(context, colorScheme, textTheme),
    );
  }

  Widget _buildTopRankers(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      height: 240,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildTopRankItem(context, 2, 'Jane Doe', '1240 XP', colorScheme, textTheme),
          _buildTopRankItem(context, 1, 'John Smith', '1500 XP', colorScheme, textTheme, isFirst: true),
          _buildTopRankItem(context, 3, 'Alex Vance', '1100 XP', colorScheme, textTheme),
        ],
      ),
    );
  }

  Widget _buildTopRankItem(
    BuildContext context,
    int rank,
    String name,
    String score,
    ColorScheme colorScheme,
    TextTheme textTheme, {
    bool isFirst = false,
  }) {
    final height = isFirst ? 140.0 : 120.0;
    final avatarSize = isFirst ? 80.0 : 65.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isFirst ? Colors.amber : colorScheme.outline,
                  width: 3,
                ),
              ),
              child: const ClipOval(
                child: Icon(Icons.person, size: 40),
              ),
            ),
            if (isFirst)
              Positioned(
                top: -5,
                child: Icon(Icons.auto_awesome_rounded, color: Colors.amber, size: 24),
              ),
          ],
        ),
        const Gap(12),
        Text(
          name,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          score,
          style: textTheme.bodySmall?.copyWith(color: colorScheme.primary),
        ),
        const Gap(10),
        Container(
          width: 60,
          height: height - 100,
          decoration: BoxDecoration(
            color: isFirst ? colorScheme.primary : colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Center(
            child: Text(
              '#$rank',
              style: textTheme.titleMedium?.copyWith(
                color: isFirst ? Colors.white : colorScheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRankListItem(
    BuildContext context,
    int rank,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$rank',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          const Gap(12),
          const CircleAvatar(radius: 20, child: Icon(Icons.person, size: 20)),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student Name',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text('Institution Name', style: textTheme.bodySmall),
              ],
            ),
          ),
          Text(
            '980 XP',
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildMyRank(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Text(
              '#42',
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900, color: colorScheme.onPrimaryContainer),
            ),
            const Gap(16),
            const CircleAvatar(radius: 22, child: Icon(Icons.person, size: 24)),
            const Gap(16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You (John Doe)',
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onPrimaryContainer),
                  ),
                  Text('450 XP collected', style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimaryContainer)),
                ],
              ),
            ),
            HugeIcon(
              icon: HugeIcons.strokeRoundedChampion,
              color: colorScheme.onPrimaryContainer,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
