import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_calculator/src/models/app_mode.dart';
import 'package:smart_calculator/src/models/calculator_mode.dart';
import 'package:smart_calculator/src/models/converter_mode.dart';
import 'package:smart_calculator/src/models/calculator_provider.dart';
import 'package:smart_calculator/src/ui/calculator/scientific_calculator.dart';
import 'package:smart_calculator/src/ui/common/display.dart';
import 'package:smart_calculator/src/ui/common/keypad.dart';
import 'package:smart_calculator/src/ui/converter/currency_converter.dart';
import 'package:smart_calculator/src/ui/converter/length_converter.dart';
import 'package:smart_calculator/src/ui/converter/weight_converter.dart';

/// The main view widget for the Smart Calculator package.
///
/// This widget displays the calculator or converter UI based on the current
/// application mode and the modes allowed by the developer.
class SmartCalculatorView extends StatelessWidget {
  /// A list of allowed modes for display.
  ///
  /// This property is used to filter the modes available in the drawer.
  final List<dynamic>? allowedModes;

  /// Creates a [SmartCalculatorView].
  const SmartCalculatorView({super.key, this.allowedModes});

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);

    List<Widget> drawerItems = [];
    drawerItems.add(const DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text(
        'Modes',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    ));

    for (var mode in calculatorProvider.availableCalculatorModes) {
      if (mode == CalculatorMode.standard) {
        drawerItems.add(ListTile(
          leading: const Icon(Icons.calculate),
          title: const Text('Standard Calculator'),
          onTap: () {
            calculatorProvider.setAppMode(AppMode.calculator);
            calculatorProvider.setCalculatorMode(CalculatorMode.standard);
            Navigator.pop(context);
          },
        ));
      } else if (mode == CalculatorMode.scientific) {
        drawerItems.add(ListTile(
          leading: const Icon(Icons.science),
          title: const Text('Scientific Calculator'),
          onTap: () {
            calculatorProvider.setAppMode(AppMode.calculator);
            calculatorProvider.setCalculatorMode(CalculatorMode.scientific);
            Navigator.pop(context);
          },
        ));
      }
    }

    for (var mode in calculatorProvider.availableConverterModes) {
      if (mode == ConverterMode.currency) {
        drawerItems.add(ListTile(
          leading: const Icon(Icons.money),
          title: const Text('Currency Converter'),
          onTap: () {
            calculatorProvider.setAppMode(AppMode.converter);
            calculatorProvider.setConverterMode(ConverterMode.currency);
            Navigator.pop(context);
          },
        ));
      } else if (mode == ConverterMode.weight) {
        drawerItems.add(ListTile(
          leading: const Icon(Icons.scale),
          title: const Text('Weight Converter'),
          onTap: () {
            calculatorProvider.setAppMode(AppMode.converter);
            calculatorProvider.setConverterMode(ConverterMode.weight);
            Navigator.pop(context);
          },
        ));
      } else if (mode == ConverterMode.length) {
        drawerItems.add(ListTile(
          leading: const Icon(Icons.straighten),
          title: const Text('Length Converter'),
          onTap: () {
            calculatorProvider.setAppMode(AppMode.converter);
            calculatorProvider.setConverterMode(ConverterMode.length);
            Navigator.pop(context);
          },
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          calculatorProvider.appMode == AppMode.calculator
              ? 'Calculator'
              : 'Converter',
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: drawerItems,
        ),
      ),
      body: _buildBody(calculatorProvider),
    );
  }

  /// Builds the main body of the view based on the current application mode.
  ///
  /// Displays the calculator UI if [AppMode.calculator] is active,
  /// otherwise displays the appropriate converter UI.
  Widget _buildBody(CalculatorProvider provider) {
    if (provider.appMode == AppMode.calculator) {
      if (provider.availableCalculatorModes.contains(provider.calculatorMode)) {
        return Column(
          children: <Widget>[
            const Expanded(
              flex: 2,
              child: Display(),
            ),
            Expanded(
              flex: 3,
              child:
                  provider.calculatorMode == CalculatorMode.standard
                      ? const KeyPad()
                      : const ScientificCalculatorKeyPad(),
            ),
          ],
        );
      } else {
        return const Center(
          child: Text('This calculator mode is not available.'),
        );
      }
    } else {
      if (provider.availableConverterModes.contains(provider.converterMode)) {
        return _buildConverter(provider.converterMode);
      } else {
        return const Center(
          child: Text('This converter mode is not available.'),
        );
      }
    }
  }

  /// Renders the appropriate converter widget based on the given [ConverterMode].
  Widget _buildConverter(ConverterMode mode) {
    switch (mode) {
      case ConverterMode.currency:
        return const CurrencyConverter();
      case ConverterMode.weight:
        return const WeightConverter();
      case ConverterMode.length:
        return const LengthConverter();
    }
  }
}
