import 'package:flutter/material.dart';
import 'package:smart_calculator/smart_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic>? _allowedModes;
  bool _appIsDark = false;
  int _calculatorThemeMode = 0; // 0: inherit, 1: light, 2: dark

  ThemeData? get _calculatorTheme {
    if (_calculatorThemeMode == 1) return Themes.lightTheme;
    if (_calculatorThemeMode == 2) return Themes.darkTheme;
    return null; // Inherit
  }

  IconData get _themeIcon {
    if (_calculatorThemeMode == 1) return Icons.light_mode;
    if (_calculatorThemeMode == 2) return Icons.dark_mode;
    return Icons.brightness_auto;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
      ),
      themeMode: _appIsDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Smart Calculator Example'),
          actions: [
            // Toggle App Theme (Light/Dark)
            IconButton(
              icon: Icon(_appIsDark ? Icons.wb_sunny : Icons.nightlight_round),
              tooltip: 'Toggle App Theme',
              onPressed: () {
                setState(() {
                  _appIsDark = !_appIsDark;
                });
              },
            ),
            // Cycle Calculator Theme (Inherit/Light/Dark)
            IconButton(
              icon: Icon(_themeIcon),
              tooltip: 'Cycle Calculator Theme',
              onPressed: () {
                setState(() {
                  _calculatorThemeMode = (_calculatorThemeMode + 1) % 3;
                });
              },
            ),
            // Filter Calculator Modes
            PopupMenuButton<String>(
              onSelected: (String result) {
                setState(() {
                  if (result == 'all') {
                    _allowedModes = null;
                  } else if (result == 'standard_currency') {
                    _allowedModes = [
                      CalculatorMode.standard,
                      ConverterMode.currency,
                    ];
                  } else if (result == 'scientific_weight') {
                    _allowedModes = [
                      CalculatorMode.scientific,
                      ConverterMode.weight,
                    ];
                  }
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'all',
                  child: Text('All Modes'),
                ),
                const PopupMenuItem<String>(
                  value: 'standard_currency',
                  child: Text('Standard Calc & Currency Conv'),
                ),
                const PopupMenuItem<String>(
                  value: 'scientific_weight',
                  child: Text('Scientific Calc & Weight Conv'),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 800),
              child: SmartCalculator(
                key: ValueKey(_allowedModes.toString()),
                customTheme: _calculatorTheme,
                allowedModes: _allowedModes,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
