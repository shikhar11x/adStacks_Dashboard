import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // KPI row
        _buildKpiRow(),
        const SizedBox(height: AppDims.gapLg),
        LayoutBuilder(builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 600;
          if (isNarrow) {
            return Column(children: [
              _buildProjectSummary(),
              const SizedBox(height: AppDims.gapLg),
              _buildTeamPerformance(),
            ]);
          }
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 3, child: _buildProjectSummary()),
            const SizedBox(width: AppDims.gapLg),
            Expanded(flex: 2, child: _buildTeamPerformance()),
          ]);
        }),
        const SizedBox(height: AppDims.gapLg),
        _buildRecentActivity(),
      ],
    );
  }

  Widget _buildKpiRow() {
    final kpis = [
      ('Total Projects', '24', Icons.folder_rounded, AppColors.primaryPurple, '+3 this month'),
      ('Completed', '18', Icons.check_circle_rounded, const Color(0xFF22C55E), '75% completion'),
      ('In Progress', '4', Icons.timelapse_rounded, const Color(0xFFF59E0B), '2 due this week'),
      ('Overdue', '2', Icons.warning_rounded, const Color(0xFFEF4444), 'Needs attention'),
    ];
    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < 500;
      final cards = kpis.map((k) => _KpiCard(
        title: k.$1, value: k.$2, icon: k.$3, color: k.$4, subtitle: k.$5,
      )).toList();
      if (isNarrow) {
        return Column(children: [
          Row(children: [Expanded(child: cards[0]), const SizedBox(width: 12), Expanded(child: cards[1])]),
          const SizedBox(height: 12),
          Row(children: [Expanded(child: cards[2]), const SizedBox(width: 12), Expanded(child: cards[3])]),
        ]);
      }
      return Row(
        children: cards.expand((c) => [Expanded(child: c), if (c != cards.last) const SizedBox(width: 12)]).toList(),
      );
    });
  }

  Widget _buildProjectSummary() {
    final projects = [
      ('Adstacks Redesign', 'UI/UX', 85, const Color(0xFF8B5CF6)),
      ('CRM Integration', 'Engineering', 60, const Color(0xFF3B82F6)),
      ('Marketing Campaign', 'Marketing', 45, const Color(0xFFF59E0B)),
      ('Finance Module', 'Finance', 92, const Color(0xFF22C55E)),
      ('HR Portal', 'HR', 30, const Color(0xFFEF4444)),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Project Progress', style: AppTextStyles.h3),
          const SizedBox(height: 16),
          ...projects.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(child: Text(p.$1, style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: p.$4.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppDims.pillRadius),
                    ),
                    child: Text(p.$2, style: AppTextStyles.caption.copyWith(color: p.$4, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 12),
                  Text('${p.$3}%', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700, color: p.$4)),
                ]),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: p.$3 / 100,
                    backgroundColor: p.$4.withValues(alpha: 0.12),
                    valueColor: AlwaysStoppedAnimation<Color>(p.$4),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTeamPerformance() {
    final members = [
      ('Pooja Mishra', 'Admin', 95),
      ('Rahul Sharma', 'Dev', 88),
      ('Anjali Verma', 'Design', 82),
      ('Vikram Singh', 'Sales', 74),
      ('Priya Nair', 'HR', 91),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Team Performance', style: AppTextStyles.h3),
          const SizedBox(height: 16),
          ...members.map((m) {
            final score = m.$3;
            final color = score >= 90 ? const Color(0xFF22C55E)
                : score >= 80 ? AppColors.primaryPurple
                : score >= 70 ? const Color(0xFFF59E0B)
                : const Color(0xFFEF4444);
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.12),
                  child: Text(m.$1[0], style: const TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(m.$1, style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
                    Text(m.$2, style: AppTextStyles.caption),
                  ]),
                ),
                Text('$score%', style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(width: 8),
                SizedBox(
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: score / 100,
                      backgroundColor: color.withValues(alpha: 0.12),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 6,
                    ),
                  ),
                ),
              ]),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    final activities = [
      (Icons.check_circle_rounded, const Color(0xFF22C55E), 'Finance Module marked as complete', '2 hours ago'),
      (Icons.person_add_rounded, AppColors.primaryPurple, 'New employee Rohan Gupta added', '5 hours ago'),
      (Icons.warning_rounded, const Color(0xFFEF4444), 'Marketing Campaign deadline missed', 'Yesterday'),
      (Icons.edit_rounded, const Color(0xFFF59E0B), 'CRM Integration progress updated to 60%', '2 days ago'),
      (Icons.event_rounded, AppColors.primaryPurple, 'Team meeting scheduled for 30 Jun', '3 days ago'),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Activity', style: AppTextStyles.h3),
          const SizedBox(height: 12),
          ...activities.map((a) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(color: a.$2.withValues(alpha: 0.12), shape: BoxShape.circle),
                child: Icon(a.$1, color: a.$2, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(a.$3, style: AppTextStyles.body)),
              Text(a.$4, style: AppTextStyles.caption),
            ]),
          )),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.title, required this.value, required this.icon, required this.color, required this.subtitle});
  final String title, value, subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const Spacer(),
          Icon(Icons.trending_up_rounded, size: 16, color: color),
        ]),
        const SizedBox(height: 10),
        Text(value, style: AppTextStyles.h2.copyWith(color: AppColors.textDark, fontSize: 28)),
        const SizedBox(height: 2),
        Text(title, style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 2),
        Text(subtitle, style: AppTextStyles.caption.copyWith(color: color)),
      ]),
    );
  }
}