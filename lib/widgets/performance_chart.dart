import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// "Over All Performance The Years" card — a dual-line chart comparing
/// "Pending" vs "Project Done" across a range of years.
class PerformanceChartCard extends StatefulWidget {
  const PerformanceChartCard({super.key});

  @override
  State<PerformanceChartCard> createState() => _PerformanceChartCardState();
}

class _PerformanceChartCardState extends State<PerformanceChartCard> {
  // x = index (0..5) mapped to years 2015..2020 in titlesData.
  static const List<double> _pending = [22, 35, 28, 40, 30, 38];
  static const List<double> _done = [10, 18, 30, 55, 25, 32];
  static const List<String> _years = [
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
  ];

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
          Wrap(
            spacing: 16,
            runSpacing: 8,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Over All Performance\nThe Years',
                style: AppTextStyles.h3,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LegendDot(color: AppColors.chartPending, label: 'Pending'),
                  const SizedBox(width: 16),
                  _LegendDot(color: AppColors.chartDone, label: 'Project Done'),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppDims.gapLg),
          SizedBox(
            height: 220,
            child: LineChart(_buildChartData()),
          ),
        ],
      ),
    );
  }

  LineChartData _buildChartData() {
    return LineChartData(
      minY: 0,
      maxY: 60,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 10,
        getDrawingHorizontalLine: (value) => FlLine(
          color: AppColors.divider,
          strokeWidth: 1,
        ),
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 10,
            reservedSize: 32,
            getTitlesWidget: (value, meta) => Text(
              value.toInt().toString(),
              style: AppTextStyles.caption,
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= _years.length) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(_years[index], style: AppTextStyles.caption),
              );
            },
          ),
        ),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => AppColors.primaryPurple,
          tooltipBorderRadius: BorderRadius.circular(12),
          tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          getTooltipItems: (spots) {
            return spots.map((spot) {
              final year = _years[spot.x.toInt()];
              return LineTooltipItem(
                '$year\n${spot.y.toInt()}',
                AppTextStyles.onDarkBody.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              );
            }).toList();
          },
        ),
      ),
      lineBarsData: [
        _line(_pending, AppColors.chartPending),
        _line(_done, AppColors.chartDone),
      ],
    );
  }

  LineChartBarData _line(List<double> values, Color color) {
    return LineChartBarData(
      spots: [
        for (int i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i]),
      ],
      isCurved: true,
      curveSmoothness: 0.35,
      color: color,
      barWidth: 3,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.bodyMuted),
      ],
    );
  }
}