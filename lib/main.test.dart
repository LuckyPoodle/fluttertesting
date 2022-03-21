import 'package:flutter/material.dart';
import 'package:testinggameapp/screens/secondscreen.dart';
import 'package:testinggameapp/screens/firstscreen.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        SecondScreen.routeName: (ctx) => SecondScreen(),
      },
      home: FirstScreen()));
}
