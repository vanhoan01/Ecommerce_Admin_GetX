// ignore_for_file: file_names

import 'package:ecommerce_admin_getx/models/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key, required this.orderStats});

  final List<OrderStats> orderStats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 42, left: 8, right: 8, bottom: 8),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: BarChart(
          BarChartData(
            barTouchData: barTouchData,
            titlesData: titlesData,
            borderData: borderData,
            barGroups: barGroups,
            gridData: FlGridData(show: false),

            alignment: BarChartAlignment.spaceAround,
            // maxY: 20,
          ),
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black38,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(value.round().toString(), style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        border: const Border(bottom: BorderSide(width: 0.5)),
        show: true,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.black,
          Colors.black,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => orderStats
      .map(
        (stat) => BarChartGroupData(
          x: int.parse(DateFormat.d().format(stat.dateTime)),
          barRods: [
            BarChartRodData(
              toY: double.parse(stat.orders.toString()),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      )
      .toList();
}
