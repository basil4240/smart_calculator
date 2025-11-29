import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_calculator/enums.dart';
import 'package:smart_calculator/smart_calculator.dart';
import 'package:smart_calculator/src/smart_calculator_view.dart';
import 'package:smart_calculator/src/ui/common/display.dart'; // Import Display widget

void main() {
  group('SmartCalculator Widget Tests', () {
    testWidgets('SmartCalculator renders in standard mode by default', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SmartCalculator()));

      expect(find.text('Calculator'), findsOneWidget); // AppBar title
      expect(find.descendant(of: find.byType(Display), matching: find.text('0')), findsOneWidget); // Display output
      expect(find.text('C'), findsOneWidget); // KeyPad C button
      expect(find.text('7'), findsOneWidget); // KeyPad 7 button
    });

    testWidgets('SmartCalculator switches to scientific mode', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SmartCalculator()));

      // Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Tap Scientific Calculator
      await tester.tap(find.text('Scientific Calculator'));
      await tester.pumpAndSettle();

      expect(find.text('Calculator'), findsOneWidget); // AppBar title
      expect(find.text('sin'), findsOneWidget); // Scientific KeyPad sin button
      expect(find.text('cos'), findsOneWidget); // Scientific KeyPad cos button
    });

    testWidgets('SmartCalculator switches to currency converter', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SmartCalculator()));

      // Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Tap Currency Converter
      await tester.tap(find.text('Currency Converter'));
      await tester.pumpAndSettle();

      expect(find.text('Converter'), findsOneWidget); // AppBar title
      expect(find.text('Amount'), findsOneWidget); // Currency Converter Amount field
      expect(find.text('Convert'), findsOneWidget); // Currency Converter Convert button
    });

    testWidgets('SmartCalculator respects allowedModes for standard calculator and currency converter', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SmartCalculator(
            allowedModes: [
              CalculatorMode.standard,
              ConverterMode.currency,
            ],
          ),
        ),
      );

      // Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.text('Standard Calculator'), findsOneWidget);
      expect(find.text('Currency Converter'), findsOneWidget);
      expect(find.text('Scientific Calculator'), findsNothing); // Should not be present
      expect(find.text('Weight Converter'), findsNothing); // Should not be present
    });

    testWidgets('SmartCalculator applies custom dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SmartCalculator(
            customTheme: Themes.darkTheme,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the Scaffold within SmartCalculatorView and check the brightness of its theme.
      final BuildContext scaffoldContext = tester.element(
          find.descendant(of: find.byType(SmartCalculatorView), matching: find.byType(Scaffold)));
      final ThemeData theme = Theme.of(scaffoldContext);

      expect(theme.brightness, Brightness.dark);
      expect(theme.primaryColor, Themes.darkTheme.primaryColor);
      expect(theme.colorScheme.surface, Themes.darkTheme.colorScheme.surface);
      expect(theme.appBarTheme.backgroundColor, Themes.darkTheme.appBarTheme.backgroundColor);
    });
  });
}
