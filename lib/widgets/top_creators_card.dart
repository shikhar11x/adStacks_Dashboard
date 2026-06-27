import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Data for a single row in the [TopCreatorsCard].
class CreatorItem {
  const CreatorItem({
    required this.handle,
    required this.artworks,
    required this.rating, // 0.0 - 1.0, drives the little rating bar
  });

  final String handle;
  final int artworks;
  final double rating;
}

const List<CreatorItem> kSampleCreators = [
  CreatorItem(handle: '@maddison_c21', artworks: 9821, rating: 0.9),
  CreatorItem(handle: '@karlw8902', artworks: 7032, rating: 0.65),
  CreatorItem(handle: '@maddison_c21', artworks: 9821, rating: 0.8),
  CreatorItem(handle: '@maddison_c21', artworks: 9821, rating: 0.75),
];

/// Dark navy "Top Creators" card — header row + a list of [CreatorItem]s.
class TopCreatorsCard extends StatelessWidget {
  const TopCreatorsCard({
    super.key,
    this.creators = kSampleCreators,
  });

  final List<CreatorItem> creators;

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
          Text(
            'Top Creators',
            style: AppTextStyles.h3.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppDims.gapMd),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('Name', style: AppTextStyles.onDarkMuted),
              ),
              Expanded(
                flex: 2,
                child: Text('Artworks', style: AppTextStyles.onDarkMuted),
              ),
              Expanded(
                flex: 2,
                child: Text('Rating', style: AppTextStyles.onDarkMuted),
              ),
            ],
          ),
          const SizedBox(height: AppDims.gapSm),
          Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
          for (final creator in creators) _CreatorRow(item: creator),
        ],
      ),
    );
  }
}

class _CreatorRow extends StatelessWidget {
  const _CreatorRow({required this.item});

  final CreatorItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor:
                      AppColors.primaryPurple.withValues(alpha: 0.25),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.handle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.onDarkBody,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item.artworks.toString(),
              style: AppTextStyles.onDarkMuted,
            ),
          ),
          Expanded(
            flex: 2,
            child: _RatingBar(value: item.rating),
          ),
        ],
      ),
    );
  }
}

/// Small horizontal pill that fills proportionally to [value] (0.0 - 1.0).
class _RatingBar extends StatelessWidget {
  const _RatingBar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDims.pillRadius),
      child: SizedBox(
        height: 6,
        child: Stack(
          children: [
            Container(color: Colors.white.withValues(alpha: 0.08)),
            FractionallySizedBox(
              widthFactor: value.clamp(0.0, 1.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppGradients.purpleButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
