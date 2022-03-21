import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:testinggameapp/main.dart';
import 'package:testinggameapp/screens/firstscreen.dart';
import 'package:testinggameapp/screens/secondscreen.dart';

void main() {
  testWidgets('Verifiy buy button is visible', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: SecondScreen()));

    // Verify that our counter starts at 0.
    expect(find.byKey(Key("BuyButtonKey")), findsOneWidget);
  });
}
