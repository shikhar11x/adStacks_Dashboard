import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Data for a single row in the [AllProjectsCard].
class ProjectItem {
  const ProjectItem({
    required this.title,
    required this.subtitle,
    required this.thumbnailColor,
    this.highlighted = false,
  });

  final String title;
  final String subtitle;
  final Color thumbnailColor;
  final bool highlighted;
}

const List<ProjectItem> kSampleProjects = [
  ProjectItem(
    title: 'Technology behind the Blockchain',
    subtitle: 'Project #1 • See project details',
    thumbnailColor: AppColors.pink,
    highlighted: true,
  ),
  ProjectItem(
    title: 'Technology behind the Blockchain',
    subtitle: 'Project #1 • See project details',
    thumbnailColor: AppColors.blueAccent,
  ),
  ProjectItem(
    title: 'Technology behind the Blockchain',
    subtitle: 'Project #1 • See project details',
    thumbnailColor: AppColors.primaryPurple,
  ),
];

/// "All Projects" card — a header plus a list of [ProjectItem] rows.
class AllProjectsCard extends StatelessWidget {
  const AllProjectsCard({
    super.key,
    this.projects = kSampleProjects,
  });

  final List<ProjectItem> projects;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('All Projects', style: AppTextStyles.h3),
          const SizedBox(height: AppDims.gapMd),
          for (int i = 0; i < projects.length; i++) ...[
            _ProjectRow(item: projects[i]),
            if (i != projects.length - 1) const SizedBox(height: AppDims.gapSm),
          ],
        ],
      ),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  const _ProjectRow({required this.item});

  final ProjectItem item;

  @override
  Widget build(BuildContext context) {
    final highlighted = item.highlighted;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlighted ? AppColors.pink : AppColors.scaffoldBg,
        borderRadius: BorderRadius.circular(AppDims.smallRadius),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: highlighted
                  ? Colors.white.withValues(alpha: 0.25)
                  : item.thumbnailColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.link_rounded,
              color: highlighted ? Colors.white : item.thumbnailColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: highlighted ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: highlighted
                        ? Colors.white.withValues(alpha: 0.85)
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: highlighted
                ? Colors.white.withValues(alpha: 0.2)
                : AppColors.cardBg,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.edit_outlined,
                  size: 16,
                  color: highlighted ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
