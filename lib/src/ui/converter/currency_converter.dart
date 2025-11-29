import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_calculator/src/models/calculator_provider.dart';

/// A widget that provides a user interface for currency conversion.
///
/// This converter allows users to input an amount, select 'from' and 'to'
/// currencies, specify an exchange rate, and view the converted result.
class CurrencyConverter extends StatelessWidget {
  /// Creates a [CurrencyConverter] widget.
  const CurrencyConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  'Result: ${provider.convertedValue.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: provider.setAmount,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'From Currency (e.g., USD)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: provider.setFromCurrency,
                    controller: TextEditingController(text: provider.fromCurrency),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'To Currency (e.g., EUR)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: provider.setToCurrency,
                    controller: TextEditingController(text: provider.toCurrency),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Exchange Rate (From to To)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: provider.setExchangeRate,
                    controller: TextEditingController(text: provider.exchangeRate.toString()),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      provider.convertCurrency();
                    },
                    child: const Text('Convert'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
