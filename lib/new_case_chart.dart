import 'package:covid/model/new_case.dart';
import 'package:covid/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class NewCaseChart extends StatefulWidget {
  @override
  State<NewCaseChart> createState() => _NewCaseChartState();
}

class _NewCaseChartState extends State<NewCaseChart> {
  late TooltipBehavior _tooltipBehavior;
  late List<NewCase> _chartData;
  List<NewCase> getData() {
    final List<NewCase> chartData =
        Provider.of<MyProvider>(context, listen: false).newCases!;
    return chartData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    // print(Provider.of<MyProvider>(context, listen: false).newCases!);
    _chartData = getData();

    print(_chartData[0].number_of_cases);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green[900],
              title: Center(
                  child: Text(
                'New Case Chart',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
            body: Consumer<MyProvider>(builder: (context, provider, g) {
              return SfCartesianChart(
                title: ChartTitle(text: 'New Case Chart'),
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries<NewCase, String>>[
                  LineSeries<NewCase, String>(
                      name: 'New case',
                      dataSource: _chartData,
                      xValueMapper: (NewCase data, _) => data.date_case,
                      yValueMapper: (NewCase data, _) => data.number_of_cases,
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

   // Provider.of<MyProvider>(context, listen: false).getAllNewCases();
    // newcases = Provider.of<MyProvider>(context, listen: false).newCases;

     // primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
        // primaryYAxis: NumericAxis(
        //     numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),