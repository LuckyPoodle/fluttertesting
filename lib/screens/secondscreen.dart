import 'package:flutter/material.dart';
import 'package:testinggameapp/consts/myicons.dart';
import 'package:testinggameapp/controllers/btcDatacontroller.dart';
import 'package:get/get.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class SecondScreen extends StatefulWidget {
  static const routeName = '/second';
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String keyboardnum = '';
  final BTCController btcController = Get.put(BTCController());

  _onKeyboardTap(String value) {
    setState(() {
      keyboardnum = keyboardnum + value;
    });
  }

  String _calculateNumberOfBitcoinWorth() {
    if (keyboardnum != '') {
      double costperbtc = btcController.currentBtcData.price;
      double numOfBtc = double.parse(keyboardnum) / costperbtc;
      return numOfBtc.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          backgroundColor: Colors.white,
          title: DropdownButton<String>(
            value: 'Buy Bitcoin',
            icon: Icon(MyAppIcons.arrowdown),
            elevation: 16,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            onChanged: (String newValue) {
              //
            },
            items: <String>['Buy Bitcoin', 'Buy Ethereum']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      keyboardnum,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text('SGD')
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_calculateNumberOfBitcoinWorth() == null
                        ? '0'
                        : _calculateNumberOfBitcoinWorth()),
                    SizedBox(
                      width: 2,
                    ),
                    Text('BTC')
                  ],
                ),
              ),
              NumericKeyboard(
                  onKeyboardTap: _onKeyboardTap,
                  textColor: Colors.green[700],
                  rightButtonFn: () {
                    setState(() {
                      keyboardnum =
                          keyboardnum.substring(0, keyboardnum.length - 1);
                    });
                  },
                  rightIcon: Icon(
                    Icons.backspace,
                    color: Colors.green[700],
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly),
              TextButton(
                  key: const Key("BuyButtonKey"),
                  onPressed: () {
                    double temp = double.parse(keyboardnum);
                    Get.find<BTCController>().setNumberOfBtcToPurchase(temp);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Text(
                      'Buy',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ));
  }
}
