import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String _selectedEmployee = 'Shikhar Bajpai';
  final List<String> _employees = [
    'Shikhar Bajpai',
    'Rahul Sharma',
    'Anjali Verma',
    'Vikram Singh',
    'Priya Nair',
    'Amit Patel',
  ];

  // Simulated attendance: day -> status
  final Map<int, String> _attendance = {
    1: 'P',
    2: 'P',
    3: 'P',
    4: 'P',
    5: 'P',
    6: 'WO',
    7: 'WO',
    8: 'P',
    9: 'P',
    10: 'P',
    11: 'A',
    12: 'P',
    13: 'WO',
    14: 'WO',
    15: 'P',
    16: 'P',
    17: 'L',
    18: 'L',
    19: 'P',
    20: 'WO',
    21: 'WO',
    22: 'P',
    23: 'P',
    24: 'P',
    25: 'P',
    26: 'P',
    27: 'WO',
    28: 'WO',
    29: 'P',
    30: 'P',
    31: 'P',
  };

  @override
  Widget build(BuildContext context) {
    final present = _attendance.values.where((v) => v == 'P').length;
    final absent = _attendance.values.where((v) => v == 'A').length;
    final leave = _attendance.values.where((v) => v == 'L').length;
    final wo = _attendance.values.where((v) => v == 'WO').length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top: employee selector + stats
        LayoutBuilder(builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 600;
          final statCards = [
            _MiniStat('Present', '$present', const Color(0xFF22C55E)),
            _MiniStat('Absent', '$absent', const Color(0xFFEF4444)),
            _MiniStat('Leave', '$leave', const Color(0xFFF59E0B)),
            _MiniStat('Week Off', '$wo', AppColors.primaryPurple),
          ];
          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _employeeDropdown(),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: statCards
                      .map((c) => SizedBox(
                          width: (constraints.maxWidth - 12) / 2, child: c))
                      .toList(),
                ),
              ],
            );
          }
          return Row(
            children: [
              SizedBox(width: 220, child: _employeeDropdown()),
              const SizedBox(width: 12),
              ...statCards.expand((c) => [
                    Expanded(child: c),
                    if (c != statCards.last) const SizedBox(width: 12)
                  ]),
            ],
          );
        }),
        const SizedBox(height: AppDims.gapLg),
        // Attendance calendar card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDims.cardRadius),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('June 2026', style: AppTextStyles.h3),
                  const Spacer(),
                  _legend(),
                ],
              ),
              const SizedBox(height: 16),
              _buildCalendar(),
            ],
          ),
        ),
        const SizedBox(height: AppDims.gapLg),
        // Today's log
        _buildTodayLog(),
      ],
    );
  }

  Widget _employeeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedEmployee,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: _employees
              .map((e) => DropdownMenuItem(
                  value: e, child: Text(e, style: AppTextStyles.body)))
              .toList(),
          onChanged: (v) => setState(() => _selectedEmployee = v!),
        ),
      ),
    );
  }

  Widget _legend() {
    final items = [
      ('P', 'Present', const Color(0xFF22C55E)),
      ('A', 'Absent', const Color(0xFFEF4444)),
      ('L', 'Leave', const Color(0xFFF59E0B)),
      ('WO', 'Week Off', AppColors.primaryPurple),
    ];
    return Wrap(
      spacing: 12,
      children: items
          .map((i) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: 10,
                      height: 10,
                      decoration:
                          BoxDecoration(color: i.$3, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text(i.$2, style: AppTextStyles.caption),
                ],
              ))
          .toList(),
    );
  }

  Widget _buildCalendar() {
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    // June 2026 starts on Monday (index 0)
    const startWeekday = 0;
    const totalDays = 30;

    return Column(
      children: [
        // Day headers
        Row(
          children: dayNames
              .map((d) => Expanded(
                    child: Center(
                        child: Text(d,
                            style: AppTextStyles.caption
                                .copyWith(fontWeight: FontWeight.w700))),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        // Days grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.1,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: startWeekday + totalDays,
          itemBuilder: (context, index) {
            if (index < startWeekday) return const SizedBox.shrink();
            final day = index - startWeekday + 1;
            final status = _attendance[day] ?? '';
            Color bg;
            Color fg;
            switch (status) {
              case 'P':
                bg = const Color(0xFF22C55E).withValues(alpha: 0.15);
                fg = const Color(0xFF22C55E);
                break;
              case 'A':
                bg = const Color(0xFFEF4444).withValues(alpha: 0.15);
                fg = const Color(0xFFEF4444);
                break;
              case 'L':
                bg = const Color(0xFFF59E0B).withValues(alpha: 0.15);
                fg = const Color(0xFFF59E0B);
                break;
              case 'WO':
                bg = AppColors.primaryPurple.withValues(alpha: 0.10);
                fg = AppColors.primaryPurple;
                break;
              default:
                bg = AppColors.scaffoldBg;
                fg = AppColors.textSecondary;
            }
            return Container(
              decoration: BoxDecoration(
                  color: bg, borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$day',
                      style: AppTextStyles.caption
                          .copyWith(color: fg, fontWeight: FontWeight.w700)),
                  if (status.isNotEmpty && status != 'WO')
                    Text(status,
                        style: TextStyle(
                            fontSize: 9,
                            color: fg,
                            fontWeight: FontWeight.w600)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTodayLog() {
    final logs = [
      ('Shikhar Bajpai', '09:02 AM', '06:15 PM', 'Present'),
      ('Rahul Sharma', '09:30 AM', '06:45 PM', 'Present'),
      ('Anjali Verma', '—', '—', 'Absent'),
      ('Vikram Singh', '10:00 AM', '—', 'On Leave'),
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Log — 27 Jun 2026",
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: 12),
          const Divider(),
          ...logs.map((l) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor:
                          AppColors.primaryPurple.withValues(alpha: 0.12),
                      child: Text(l.$1[0],
                          style: const TextStyle(
                              color: AppColors.primaryPurple,
                              fontWeight: FontWeight.w700,
                              fontSize: 13)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text(l.$1,
                            style: AppTextStyles.bodyDark
                                .copyWith(fontWeight: FontWeight.w600))),
                    Text('In: ${l.$2}', style: AppTextStyles.caption),
                    const SizedBox(width: 16),
                    Text('Out: ${l.$3}', style: AppTextStyles.caption),
                    const SizedBox(width: 16),
                    _StatusPill(l.$4),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat(this.label, this.value, this.color);
  final String label, value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)
        ],
      ),
      child: Row(
        children: [
          Container(
              width: 10,
              height: 36,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(4))),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value,
                style: AppTextStyles.h2.copyWith(color: color, fontSize: 22)),
            Text(label, style: AppTextStyles.caption),
          ]),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill(this.status);
  final String status;

  @override
  Widget build(BuildContext context) {
    Color c;
    switch (status) {
      case 'Present':
        c = const Color(0xFF22C55E);
        break;
      case 'Absent':
        c = const Color(0xFFEF4444);
        break;
      default:
        c = const Color(0xFFF59E0B);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: c.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppDims.pillRadius)),
      child: Text(status,
          style: AppTextStyles.caption
              .copyWith(color: c, fontWeight: FontWeight.w600)),
    );
  }
}
