import 'package:get/get.dart';
import '../models/btcData.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../utils/csvHelper.dart';

class BTCController extends GetxController {
  BtcData currentBtcData;
  List<BtcData> btclist = [];
  double numberOfBtcToPurchase = 0;

  var timeSeries;
  CSVHelper csvHelper = CSVHelper();

  void setNumberOfBtcToPurchase(double num) {
    numberOfBtcToPurchase = num;
    print('NUMBER OF BTC TO PURCHSE');
    print(numberOfBtcToPurchase);
    update();
  }

  void setCurrentBtcData(BtcData current) {
    currentBtcData = current;
    update();
  }

  Future<List<BtcData>> loadBTCDataFromCSV() async {
    try {
      var listofdateandprice = await csvHelper.readCsv();
      print('in controlllerrr');
      print(btclist);
      btclist = [];
      var pricelist = [];
      var datelist = [];
      pricelist = listofdateandprice[1];
      datelist = listofdateandprice[0];
      print("===========");
      print(pricelist);
      print(datelist);

      List<BtcData> tempbtclist = [];

      //set current btc
      currentBtcData = BtcData(
          date: DateTime.parse(datelist.last.toString()),
          price: pricelist.last);

      //prepare btc list

      for (var index = 0; index < pricelist.length; index++) {
        BtcData temp = BtcData();
        temp.date = DateTime.parse(datelist[index].toString());
        temp.price = double.parse(pricelist[index].toString());
        tempbtclist.add(temp);
      }
      if (tempbtclist.length > 200) {
        btclist.addAll(tempbtclist.sublist(
            tempbtclist.length - 100, tempbtclist.length - 1));
      } else {
        btclist.addAll(tempbtclist);
      }

      for (var btc in btclist) {
        print(btc.date);
      }

      update();
      setCurrentBtcData(btclist[btclist.length - 1]);
      buildGraphBTC();
      return btclist;
    } catch (err) {
      print('Caught error: $err');
      return btclist;
    }

    // print(csvdata.length);
    // for (var line in csvdata) {
    //   print('line');
    //   print(line[50000]);
    // }
  }

  Future buildGraphBTC() {
    timeSeries = [
      charts.Series<BtcData, DateTime>(
          id: 'timeSeriesChart',
          domainFn: (BtcData data, _) => data.date,
          measureFn: (BtcData data, _) => data.price,
          data: btclist)
    ];

    update();
  }
}
