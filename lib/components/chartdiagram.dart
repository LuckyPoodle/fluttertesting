import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testinggameapp/controllers/btcDatacontroller.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartDiagram extends StatelessWidget {
  final BTCController btcController = Get.put(BTCController());
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(10),
        child: charts.TimeSeriesChart(
          btcController.timeSeries,
        ),
      ),
    );
  }
}
