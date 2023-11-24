import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
    required this.data,
  });

  final List<FlSpot> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsetsDirectional.only(end: 20, start: 20),
          width: double.infinity,
          height: 300,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: data,
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
                leftTitles: AxisTitles(
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
