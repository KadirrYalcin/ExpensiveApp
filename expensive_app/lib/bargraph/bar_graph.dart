import 'package:expensive_app/bargraph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  const MyBarGraph(
      {Key? key,
      required this.maxY,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thurAmount,
      required this.friAmount,
      required this.satAmount,
      required this.sunAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thurAmount: thurAmount,
        friAmount: friAmount,
        satAmount: satAmount,
        sunAmount: sunAmount);
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
          maxY: maxY,
          minY: 0,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTitle)),
          ),
          barGroups: myBarData.barData
              .map((data) => BarChartGroupData(
                    x: data.x,
                    barRods: [
                      BarChartRodData(
                        toY: data.y,
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(4),
                        width: 25,
                        backDrawRodData: BackgroundBarChartRodData(
                          color: Colors.white,
                          show: true,
                          toY: maxY,
                        ),
                      ),
                    ],
                  ))
              .toList()),
    );
  }
}

Widget getBottomTitle(double value, TitleMeta meta) {
  const style =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 15);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        "M",
        style: style,
      );
      break;
    case 1:
      text = const Text(
        "T",
        style: style,
      );
      break;
    case 2:
      text = const Text(
        "W",
        style: style,
      );
      break;
    case 3:
      text = const Text(
        "T",
        style: style,
      );
      break;
    case 4:
      text = const Text(
        "F",
        style: style,
      );
      break;
    case 5:
      text = const Text(
        "S",
        style: style,
      );
      break;
    case 6:
      text = const Text(
        "S",
        style: style,
      );
      break;
    default:
      text = const Text("");
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
