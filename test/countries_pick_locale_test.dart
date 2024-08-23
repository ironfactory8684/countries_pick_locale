import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:countries_pick_locale/countries_pick_locale.dart';

void main() {
  testWidgets('CountriesPickLocale shows selected country flag and dial code', (WidgetTester tester) async {
    // Define a mock callback function
    void mockCallBackFunction(String dialCode, String flag) {
      // Do nothing in this mock
    }

    // Create the CountriesPickLocale widget with English locale
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CountriesPickLocale(
          callBackFunction: mockCallBackFunction,
          locale: 'en',
        ),
      ),
    ));

    // Verify that the initial flag and dial code are displayed
    expect(find.text('+93'), findsOneWidget); // Afghanistan's dial code
    expect(find.text('🇦🇫'), findsOneWidget); // Afghanistan's flag

    // Tap on the widget to open the country picker dialog
    await tester.tap(find.byType(InkResponse));
    await tester.pumpAndSettle(); // Wait for the dialog to open

    // Verify that the dialog shows a list of countries
    expect(find.text('Afghanistan'), findsOneWidget);
    expect(find.text('Zimbabwe'), findsOneWidget);

    // Tap on a country in the list (e.g., Zimbabwe)
    await tester.tap(find.text('Zimbabwe'));
    await tester.pumpAndSettle(); // Wait for the dialog to close

    // Verify that the selected country's flag and dial code are updated
    expect(find.text('+263'), findsOneWidget); // Zimbabwe's dial code
    expect(find.text('🇿🇼'), findsOneWidget); // Zimbabwe's flag
  });

  testWidgets('CountriesPickLocale shows translated country names in Korean', (WidgetTester tester) async {
    // Define a mock callback function
    void mockCallBackFunction(String dialCode, String flag) {
      // Do nothing in this mock
    }

    // Create the CountriesPickLocale widget with Korean locale
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CountriesPickLocale(
          callBackFunction: mockCallBackFunction,
          locale: 'kr',
        ),
      ),
    ));

    // Tap on the widget to open the country picker dialog
    await tester.tap(find.byType(InkResponse));
    await tester.pumpAndSettle(); // Wait for the dialog to open

    // Verify that the dialog shows country names in Korean
    expect(find.text('아프가니스탄'), findsOneWidget); // Afghanistan in Korean
    expect(find.text('짐바브웨'), findsOneWidget); // Zimbabwe in Korean
  });
}