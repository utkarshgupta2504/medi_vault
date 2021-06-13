import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medi_vault/models/graph_data_model.dart';
import 'package:medi_vault/utils/app_logger.dart';

import 'add_graph_entry_widget.dart';

List<String> labels = [];
List<double> values = [];

late double totalMin;
late double totalMax;

class LineChartWidget extends StatelessWidget {
  LineChartWidget({
    Key? key,
    required this.title,
    required this.chartData,
    required this.units,
    required this.minValue,
    required this.maxValue,
    required this.onSave,
  }) : super(key: key);

  final String title;
  final GraphDataModel? chartData;
  final String units;
  final double minValue;
  final double maxValue;
  final Function onSave;

  mapChartaData() {
    DateTime now = DateTime.now().subtract(Duration(days: 6));
    DateTime temp = DateTime(now.year, now.month, now.day);

    labels = [];
    values = [];

    for (int i = 0; i < 7; i++) {
      // AppLogger.print(
      // "In for loop mapChartData, tempDate: ${temp.toString()}, map: ${chartData!.data.toString()}");

      labels.add(DateFormat("dd/MM").format(temp));

      if (chartData != null &&
          chartData!.data != null &&
          chartData!.data!.containsKey(temp)) {
        // AppLogger.print("Key $temp matched!");
        double value = chartData!.data![temp]!;
        values.add(value);
        totalMin = min(totalMin, value);
        totalMax = max(totalMax, value);
      } else {
        values.add((minValue + maxValue) / 2);
      }

      temp = temp.add(Duration(days: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    totalMin = minValue;
    totalMax = maxValue;
    mapChartaData();
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AddGraphEntryWidget(
                    units: units,
                    onSave: onSave,
                    chartData: chartData,
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 24, 24, 16),
                  child: SizedBox(
                    height: 250,
                    child: LineChart(
                      LineChartData(
                        axisTitleData: FlAxisTitleData(
                          topTitle: AxisTitle(
                            titleText: title,
                            showTitle: true,
                            margin: 10,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          leftTitle:
                              AxisTitle(titleText: units, showTitle: true),
                          bottomTitle:
                              AxisTitle(titleText: "Date", showTitle: true),
                        ),
                        titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTitles: (value) => labels[value.toInt()],
                            )),
                        lineBarsData: [
                          LineChartBarData(
                              colors: [
                                Colors.red,
                              ],
                              spots: values
                                  .asMap()
                                  .entries
                                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                                  .toList(),
                              isCurved: true,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                gradientColorStops: [0, 1],
                                gradientFrom: Offset(0, 0),
                                gradientTo: Offset(0, 1),
                                colors: [
                                  Colors.redAccent[100]!,
                                  Colors.white,
                                ],
                              ),
                              curveSmoothness: 0.25)
                        ],
                        clipData: FlClipData.all(),
                        gridData: FlGridData(
                          show: false,
                        ),
                        minY: totalMin - 10,
                        maxY: totalMax + 10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
