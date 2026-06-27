import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../theme/app_theme.dart';

/// "GENERAL 10:00 AM TO 7:00 PM" calendar card — a styled [TableCalendar]
/// with a custom month header (dropdown-style chevrons instead of the
/// default header) to match the screenshot.
class CalendarCard extends StatefulWidget {
  const CalendarCard({super.key});

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

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
          Text(
            'GENERAL 10:00 AM TO 7:00 PM',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: AppDims.gapMd),
          _buildMonthHeader(),
          const SizedBox(height: AppDims.gapSm),
          TableCalendar(
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2040, 12, 31),
            focusedDay: _focusedDay,
            headerVisible: false,
            daysOfWeekHeight: 28,
            rowHeight: 36,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            onPageChanged: (focused) {
              setState(() => _focusedDay = focused);
            },
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: AppTextStyles.caption,
              weekendStyle: AppTextStyles.caption,
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: true,
              defaultTextStyle: AppTextStyles.body,
              weekendTextStyle: AppTextStyles.body,
              outsideTextStyle: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.primaryPurple.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              todayTextStyle: AppTextStyles.body.copyWith(
                color: AppColors.primaryPurple,
                fontWeight: FontWeight.w700,
              ),
              selectedDecoration: const BoxDecoration(
                gradient: AppGradients.purpleButton,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    return Row(
      children: [
        _HeaderPill(
          label: months[_focusedDay.month - 1],
          onTap: () => _shiftMonth(-1),
        ),
        const SizedBox(width: 10),
        _HeaderPill(
          label: _focusedDay.year.toString(),
          onTap: () => _shiftMonth(1),
        ),
        const Spacer(),
        _NavArrow(
          icon: Icons.chevron_left_rounded,
          onTap: () => _shiftMonth(-1),
        ),
        const SizedBox(width: 6),
        _NavArrow(
          icon: Icons.chevron_right_rounded,
          onTap: () => _shiftMonth(1),
        ),
      ],
    );
  }

  void _shiftMonth(int delta) {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + delta, 1);
    });
  }
}

class _HeaderPill extends StatelessWidget {
  const _HeaderPill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scaffoldBg,
      borderRadius: BorderRadius.circular(AppDims.pillRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDims.pillRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: AppTextStyles.bodyMuted),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 14,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavArrow extends StatelessWidget {
  const _NavArrow({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scaffoldBg,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: 18, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}