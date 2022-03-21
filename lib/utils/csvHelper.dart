import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'dart:async';
import 'dart:convert';

class CSVHelper {
  Future<List<List>> readCsv() async {
    var listofdates = [];
    var listofprices = [];
    List<List<dynamic>> combinedbtcdate = [];
    var myData = await rootBundle.loadString('assets/btc.csv');
    List<List<dynamic>> rowsAsListOfValues =
        await CsvToListConverter().convert(myData);
    print('LENGTHHH!!!!!!!!!!!!......');
    print(rowsAsListOfValues[0].length - 1);
    print('list of prices type!!!!!!!!!');
    print(rowsAsListOfValues[0][207] == '');

    for (var i = 0; i < rowsAsListOfValues[0].length; i = i + 139) {
      if (rowsAsListOfValues[0][i] == '') {
        print('emptyrow for date');
        listofdates.add('NA');
      } else {
        listofdates.add(rowsAsListOfValues[0][i]);
      }
    }

    for (var i = 68; i < rowsAsListOfValues[0].length; i = i + 139) {
      if (rowsAsListOfValues[0][i] == '') {
        print('empty row for price');
        listofprices.add(0.0);
      } else {
        listofprices.add(rowsAsListOfValues[0][i]);
      }
    }

    var cleandates = [];
    for (var date in listofdates) {
      if (date.toString().length > 10) {
        cleandates.add(date
            .toString()
            .substring(date.toString().length - 10, date.toString().length));
      } else {
        cleandates.add(date.toString());
      }
    }
    cleandates.remove('date');
    cleandates.removeLast();
    listofprices.remove('PriceUSD');
    combinedbtcdate = [cleandates, listofprices];
    print('RESULT');
    print(combinedbtcdate);
    return combinedbtcdate;
    // loadAsset('assets/btc.csv').then((dynamic output) {
    //   List<List<dynamic>> rowsAsListOfValues =
    //       const CsvToListConverter().convert(output);
    //   // for (var i in rowsAsListOfValues[0]) {
    //   //   print(">>>>>>>>>> i");
    //   //   print(i);
    //   // }
    //   print('LENGTHHH......');
    //   print(rowsAsListOfValues[0].length - 1);

    //   for (var i = 0; i < rowsAsListOfValues[0].length; i = i + 139) {
    //     listofdates.add(rowsAsListOfValues[0][i]);
    //   }

    //   for (var i = 68; i < rowsAsListOfValues[0].length; i = i + 139) {
    //     listofprices.add(rowsAsListOfValues[0][i]);
    //   }

    //   var cleandates = [];
    //   for (var date in listofdates) {
    //     if (date.toString().length > 10) {
    //       cleandates.add(date
    //           .toString()
    //           .substring(date.toString().length - 10, date.toString().length));
    //     } else {
    //       cleandates.add(date.toString());
    //     }
    //   }
    //   cleandates.remove('date');
    //   combinedbtcdate = [cleandates, listofprices];
    //   print('RESULT');
    //   print(combinedbtcdate);
    //   return combinedbtcdate;
    // });
  }
}
