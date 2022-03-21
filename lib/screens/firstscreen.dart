import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testinggameapp/consts/myicons.dart';
import 'package:testinggameapp/controllers/btcDatacontroller.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:testinggameapp/screens/secondscreen.dart';

import '../components/chartdiagram.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final BTCController btcController = Get.put(BTCController());
  int _selectedIndex = 0;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("INIT STATE");
    btcController.loadBTCDataFromCSV().then((value) {
      print('POST CONTROLLERRR');
      print(value);
      setState(() {
        loading = false;
      });
    }).catchError((err) {});
  }

  Widget timeFrame() {
    List<String> timeframes = ["1H", "1D", "1W", "1M", "1Y", "All"];
    List<TextButton> timeframebuttons = [];
    for (var i = 0; i < timeframes.length; i++) {
      timeframebuttons
          .add(TextButton(onPressed: () {}, child: Text(timeframes[i])));
    }
    return new Row(children: timeframebuttons);
  }

  void _onItemTapped(int index) {
    if (index != 1) {
      setState(() {
        _selectedIndex = index;
      });
    }
    if (index == 1) {
      Navigator.pushNamed(context, SecondScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped, //New
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MyAppIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(MyAppIcons.buy),
              label: 'Buy',
            ),
            BottomNavigationBarItem(
              icon: Icon(MyAppIcons.wallet),
              label: 'Wallet',
            ),
          ],
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              MyAppIcons.arrowback,
              color: Colors.black54,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.grey[800]),
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(MyAppIcons.btc),
                        Text(
                          'Bitcoin',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        loading
                            ? Text("N.A")
                            : Text(
                                btcController.currentBtcData.price
                                    .toStringAsFixed(2),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                        // Text(btcController.currentBtcData != null
                        //     ? btcController.currentBtcData.price
                        //         .toStringAsFixed(2)
                        //     : 'NA'),
                        Text('SGD'),
                        Text(
                          '+2.96%',
                          style: TextStyle(color: Colors.green, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            loading ? CircularProgressIndicator() : ChartDiagram(),
            // btcController.timeSeries != null
            //     ? Card(
            //         child: Container(
            //           height: MediaQuery.of(context).size.height * 0.5,
            //           padding: const EdgeInsets.all(10),
            //           child: charts.TimeSeriesChart(
            //             btcController.timeSeries,
            //           ),
            //         ),
            //       )
            //     : CircularProgressIndicator(),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: timeFrame(),
            ),
            Card(
                child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Available'), Text('=1.0043222 BTC')],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          key: Key('BuyButton'),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SecondScreen.routeName);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Text(
                              'Buy',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SecondScreen.routeName);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Text(
                              'Sell',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ))
          ],
        ))));
  }
}
