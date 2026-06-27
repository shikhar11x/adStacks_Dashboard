import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.title,
    this.onMenuTap,
  });

  final String title;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Row(
      children: [
        if (onMenuTap != null)
          IconButton(
            onPressed: onMenuTap,
            icon: const Icon(Icons.menu_rounded),
            color: AppColors.textPrimary,
          ),
        Text(
          title,
          style: AppTextStyles.h1.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(width: AppDims.gapLg),
        if (!isMobile) Expanded(child: Center(child: _SearchField())),
        const SizedBox(width: AppDims.gapMd),
        if (isMobile)
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
            color: AppColors.textPrimary,
          )
        else ...[
          _IconButton(icon: Icons.mail_outline_rounded, onTap: () {}),
          const SizedBox(width: AppDims.gapSm),
          _IconButton(icon: Icons.notifications_none_rounded, onTap: () {}),
          const SizedBox(width: AppDims.gapSm),
          _IconButton(icon: Icons.power_settings_new_rounded, onTap: () {}),
          const SizedBox(width: AppDims.gapMd),
        ],
        const _Avatar(),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 44,
        constraints: const BoxConstraints(maxWidth: 420),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppDims.pillRadius),
          border: Border.all(color: AppColors.divider),
        ),
        alignment: Alignment.center,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: AppTextStyles.bodyMuted,
            border: InputBorder.none,
            isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  gradient: AppGradients.purpleButton,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.search_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          style: AppTextStyles.body,
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBg,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.divider),
          ),
          child: Icon(icon, size: 19, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.15),
      child: const Icon(
        Icons.person_rounded,
        size: 22,
        color: AppColors.primaryPurple,
      ),
    );
  }
}