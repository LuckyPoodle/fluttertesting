import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:testinggameapp/controllers/btcDatacontroller.dart';
import 'package:testinggameapp/models/btcData.dart';
import 'package:testinggameapp/utils/csvHelper.dart';

class MockCSVHelper extends Mock implements CSVHelper {}

void main() {
  CSVHelper mockCSVHelper = MockCSVHelper();
  BTCController btcController = BTCController();

  setUp(() {
    btcController.csvHelper = mockCSVHelper;
  });
  test('Test that when data is fetched, data should be entered into btclist',
      () async {
    var mockdata = [
      ['2021-10-10'],
      [100000.00]
    ];
    when(mockCSVHelper.readCsv())
        .thenAnswer((realInvocation) => Future.value(mockdata));

    BtcData temp = BtcData(
        date: DateTime.parse('2021-10-10'), price: double.parse('100000'));
    var result = await btcController.loadBTCDataFromCSV();
    expect(result[0].date, temp.date);
    expect(result[0].price, temp.price);
  });
}
