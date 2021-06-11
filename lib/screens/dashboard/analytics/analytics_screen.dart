import 'package:flutter/material.dart';
import 'package:medi_vault/providers/graph_data_provider.dart';
import 'package:medi_vault/utils/global.dart';
import 'package:medi_vault/widgets/loader.dart';
import 'package:provider/provider.dart';

import 'line_chart_widget.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GraphDataProvider>(context, listen: false)
        .loadAllGraphs(notify: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[100],
              child: SizedBox(
                height: 10,
              ),
            ),
            LineChartWidget(
              title: "Blood Pressure",
              units: "mm/Hg",
              minValue: 90,
              maxValue: 120,
              chartData:
                  Provider.of<GraphDataProvider>(context).bloodPressureData,
              onSave: (data) {
                Provider.of<GraphDataProvider>(context, listen: false).setData(
                    preferenceKey: Global.bloodPressureData, data: data);
                Provider.of<GraphDataProvider>(context, listen: false)
                    .loadBloodPressureData();

                setState(() {});
              },
            ),
            LineChartWidget(
              title: "Pulse Rate",
              units: "bpm",
              minValue: 60,
              maxValue: 100,
              chartData: Provider.of<GraphDataProvider>(context).pulseData,
              onSave: (data) {
                Provider.of<GraphDataProvider>(context, listen: false)
                    .setData(preferenceKey: Global.pulseData, data: data);
                Provider.of<GraphDataProvider>(context, listen: false)
                    .loadPulseData();
              },
            ),
            LineChartWidget(
              title: "Oxygen Level",
              units: "mm/Hg",
              minValue: 80,
              maxValue: 100,
              chartData:
                  Provider.of<GraphDataProvider>(context).oxygenLevelData,
              onSave: (data) {
                Provider.of<GraphDataProvider>(context, listen: false)
                    .setData(preferenceKey: Global.oxygenLevelData, data: data);
                Provider.of<GraphDataProvider>(context, listen: false)
                    .loadOxygenLevelData();
              },
            ),
            LineChartWidget(
              title: "Blood Sugar",
              units: "mg/dl",
              minValue: 90,
              maxValue: 110,
              chartData: Provider.of<GraphDataProvider>(context).bloodSugarData,
              onSave: (data) {
                Provider.of<GraphDataProvider>(context, listen: false)
                    .setData(preferenceKey: Global.bloodSugarData, data: data);
                Provider.of<GraphDataProvider>(context, listen: false)
                    .loadBloodSugarData();
              },
            ),
            LineChartWidget(
              title: "Temperature",
              units: "°F",
              minValue: 97,
              maxValue: 100,
              chartData:
                  Provider.of<GraphDataProvider>(context).temperatureData,
              onSave: (data) {
                Provider.of<GraphDataProvider>(context, listen: false)
                    .setData(preferenceKey: Global.temperatureData, data: data);
                Provider.of<GraphDataProvider>(context, listen: false)
                    .loadTemperatureData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
