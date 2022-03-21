import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testinggameapp/screens/firstscreen.dart';
import 'package:testinggameapp/screens/secondscreen.dart';
import '../lib/main.test.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test click on buy to go to second screen ',
      (WidgetTester tester) async {
    app.main();
    await tester.pump();

    expect(find.byType(FirstScreen), findsOneWidget);

    //await tester.pumpAndSettle(const Duration(seconds: 3));

    final buyButton = find.byKey(Key('BuyButton'));

    expect(buyButton, findsOneWidget);

    await tester.tap(buyButton);

    await tester.pumpAndSettle();

    expect(find.byType(SecondScreen), findsOneWidget);

    // await app.main();
    // await tester.pumpAndSettle();
    // await tester.pump();

    // expect(find.byType(FirstScreen), findsOneWidget);

    //   await tester.pumpAndSettle();

    // final buyButton = find.text("Buy Now");
    // await tester.tap(buyButton);
    // await tester.pumpAndSettle();
    // expect(find.byType(SecondScreen), findsOneWidget);
  });
}
