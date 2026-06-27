import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A dark-navy "celebration" card (used for both Birthdays and
/// Anniversaries) — sparkle-flanked title, a row of overlapping avatars,
/// a total count, and a pill-shaped CTA button.
class CelebrationCard extends StatelessWidget {
  const CelebrationCard({
    super.key,
    required this.title,
    required this.total,
    required this.buttonLabel,
    required this.badgeIcon,
    this.avatarCount = 3,
  });

  final String title;
  final int total;
  final String buttonLabel;
  final IconData badgeIcon;
  final int avatarCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppGradients.navyPanelGradient,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_rounded, size: 16, color: AppColors.warning),
              const SizedBox(width: 6),
              Text(
                title,
                style: AppTextStyles.h3.copyWith(color: Colors.white),
              ),
              const Spacer(),
              const Icon(Icons.auto_awesome_rounded, size: 16, color: AppColors.warning),
            ],
          ),
          const SizedBox(height: AppDims.gapLg),
          _AvatarStack(count: avatarCount, badgeIcon: badgeIcon),
          const SizedBox(height: AppDims.gapLg),
          Row(
            children: [
              Text('Total', style: AppTextStyles.onDarkMuted),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppDims.pillRadius),
                ),
                child: Text(
                  total.toString(),
                  style: AppTextStyles.onDarkBody.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDims.gapMd),
          SizedBox(
            width: double.infinity,
            child: Material(
              color: AppColors.primaryPurple,
              borderRadius: BorderRadius.circular(AppDims.pillRadius),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppDims.pillRadius),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.send_rounded, size: 15, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        buttonLabel,
                        style: AppTextStyles.onDarkBody.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack({required this.count, required this.badgeIcon});

  final int count;
  final IconData badgeIcon;

  static const List<Color> _palette = [
    AppColors.primaryPurple,
    AppColors.pink,
    AppColors.blueAccent,
    AppColors.success,
  ];

  @override
  Widget build(BuildContext context) {
    const double size = 48;
    const double overlap = 16;

    return SizedBox(
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < count; i++)
            Positioned(
              left: i * (size - overlap),
              child: _Avatar(
                color: _palette[i % _palette.length],
                badgeIcon: i == 0 ? badgeIcon : null,
              ),
            ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.color, this.badgeIcon});

  final Color color;
  final IconData? badgeIcon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.3),
            border: Border.all(color: AppColors.navyPanel, width: 3),
          ),
          child: const Icon(Icons.person_rounded, color: Colors.white, size: 22),
        ),
        if (badgeIcon != null)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.warning,
                shape: BoxShape.circle,
              ),
              child: Icon(badgeIcon, size: 11, color: Colors.white),
            ),
          ),
      ],
    );
  }
}