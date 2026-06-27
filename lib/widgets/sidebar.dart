import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Data for a single sidebar navigation entry.
class SidebarNavItem {
  const SidebarNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

const List<SidebarNavItem> kSidebarNavItems = [
  SidebarNavItem(icon: Icons.home_rounded, label: 'Home'),
  SidebarNavItem(icon: Icons.groups_rounded, label: 'Employees'),
  SidebarNavItem(icon: Icons.fact_check_outlined, label: 'Attendance'),
  SidebarNavItem(icon: Icons.calendar_today_outlined, label: 'Summary'),
  SidebarNavItem(icon: Icons.info_outline_rounded, label: 'Information'),
];

/// The full left-hand sidebar: logo, profile card, primary nav, workspaces,
/// and a settings/logout footer.
///
/// [selectedIndex] / [onItemSelected] drive which primary nav item is
/// highlighted. [onClose] is optional — pass it when the sidebar is shown
/// inside a [Drawer] on mobile so a close button can be shown.
class AppSidebar extends StatefulWidget {
  const AppSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    this.onClose,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback? onClose;

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  bool _adstacksExpanded = true;
  bool _financeExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sidebarBg,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: AppDims.gapLg),
            _buildProfileCard(),
            const SizedBox(height: AppDims.gapLg),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < kSidebarNavItems.length; i++)
                      _NavTile(
                        item: kSidebarNavItems[i],
                        selected: widget.selectedIndex == i,
                        onTap: () => widget.onItemSelected(i),
                      ),
                    const SizedBox(height: AppDims.gapLg),
                    _buildWorkspacesHeader(),
                    const SizedBox(height: AppDims.gapSm),
                    _WorkspaceTile(
                      label: 'Adstacks',
                      expanded: _adstacksExpanded,
                      onTap: () => setState(
                        () => _adstacksExpanded = !_adstacksExpanded,
                      ),
                    ),
                    _WorkspaceTile(
                      label: 'Finance',
                      expanded: _financeExpanded,
                      onTap: () => setState(
                        () => _financeExpanded = !_financeExpanded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _NavTile(
                    item: const SidebarNavItem(
                      icon: Icons.settings_outlined,
                      label: 'Setting',
                    ),
                    selected: false,
                    onTap: () => widget.onItemSelected(5),
                  ),
                  _NavTile(
                    item: const SidebarNavItem(
                      icon: Icons.logout_rounded,
                      label: 'Logout',
                    ),
                    selected: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 12, 0),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: AppGradients.purpleButton,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                const Icon(Icons.bolt_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Text('Adstacks', style: AppTextStyles.h3),
          const Spacer(),
          if (widget.onClose != null)
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: widget.onClose,
            ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.15),
            child: const Icon(
              Icons.person_rounded,
              size: 36,
              color: AppColors.primaryPurple,
            ),
          ),
          const SizedBox(height: AppDims.gapSm),
          Text('Pooja Mishra', style: AppTextStyles.h3),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDims.pillRadius),
            ),
            child: Text(
              'Admin',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primaryPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkspacesHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Text(
            'WORKSPACES',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.add_rounded,
              size: 16,
              color: AppColors.primaryPurple,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final SidebarNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Material(
        color: selected ? AppColors.primaryPurple : Colors.transparent,
        borderRadius: BorderRadius.circular(AppDims.smallRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDims.smallRadius),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 20,
                  color: selected ? Colors.white : AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Text(
                  item.label,
                  style: selected
                      ? AppTextStyles.navLabelActive
                      : AppTextStyles.navLabel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkspaceTile extends StatelessWidget {
  const _WorkspaceTile({
    required this.label,
    required this.expanded,
    required this.onTap,
  });

  final String label;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppDims.smallRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDims.smallRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(
                Icons.folder_outlined,
                size: 18,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(label, style: AppTextStyles.navLabel)),
              Icon(
                expanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
