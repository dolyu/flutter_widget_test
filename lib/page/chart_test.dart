import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartTest extends StatelessWidget {
  const ChartTest({Key? key}) : super(key: key);

  List<VerticalRangeAnnotation> ttt() {
    List<VerticalRangeAnnotation> rt = [];
    rt.add(VerticalRangeAnnotation(x1: 0, x2: 1, color: Colors.yellow));
    rt.add(VerticalRangeAnnotation(x1: 2, x2: 3, color: Colors.red));
    rt.add(VerticalRangeAnnotation(x1: 4, x2: 7, color: Colors.blue));
    return rt;
  }

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      const Color(0xFF000000),
      const Color(0xff02d39a),
    ];

    // i
    return SizedBox(
      width: 600,
      height: 200,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 10),
                FlSpot(1, 10),
                FlSpot(2, 21),
                FlSpot(3, 31.5),
                FlSpot(4, 41),
                FlSpot(5, 51.4),
                FlSpot(6, 31),
                FlSpot(7, 43.4),
                FlSpot(8, 71),
                FlSpot(9, 82),
                FlSpot(10, 21),
              ],
              isCurved: false,
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!,
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!,
              ],
              barWidth: 1,
              isStrokeCapRound: false,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(show: true, colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ]),
            ),
          ],
          rangeAnnotations: RangeAnnotations(
            verticalRangeAnnotations: ttt(),
          ),
        ),
      ),
    );
  }
}
