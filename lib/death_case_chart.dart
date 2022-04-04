import 'package:covid/model/new_case.dart';
import 'package:covid/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'model/death_case.dart';

class DeathCaseChart extends StatefulWidget {
  @override
  State<DeathCaseChart> createState() => _DeathCaseChartState();
}

class _DeathCaseChartState extends State<DeathCaseChart> {
  late TooltipBehavior _tooltipBehavior;
  late List<DeathCase> _chartData;

  List<DeathCase> getData() {
    final List<DeathCase> chartData =
        Provider.of<MyProvider>(context, listen: false).deathCases!;
    return chartData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _chartData = getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green[900],
              title: Center(
                  child: Text(
                'Death Case Chart',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
            body: Consumer<MyProvider>(builder: (context, provider, g) {
              return SfCartesianChart(
                title: ChartTitle(text: 'Death Case Chart'),
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries<DeathCase, String>>[
                  LineSeries<DeathCase, String>(
                      name: 'Death case',
                      dataSource: _chartData,
                      xValueMapper: (DeathCase data, _) => data.death_date,
                      yValueMapper: (DeathCase data, _) => data.number_of_death,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      enableTooltip: true),
                ],
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
              );
            })));
  }
}
