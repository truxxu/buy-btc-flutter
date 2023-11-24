import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> chartData = [
      FlSpot(0, 1),
      FlSpot(1, 3),
      FlSpot(2, 10),
      FlSpot(3, 7),
      FlSpot(4, 12),
      FlSpot(5, 13),
      FlSpot(6, 17),
      FlSpot(7, 15),
      FlSpot(8, 20),
    ];
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsetsDirectional.only(end: 20),
          width: double.infinity,
          height: 300,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: chartData,
                  isCurved: true,
                  dotData: const FlDotData(
                    show: false,
                  ),
                  color: Colors.amber,
                ),
              ],
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  axisNameSize: 50,
                  axisNameWidget: ChartLabel(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChartLabel extends StatelessWidget {
  const ChartLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text("A month ago"), Text('Today')],
    );
  }
}
