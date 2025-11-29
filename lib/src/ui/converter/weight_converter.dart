import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_calculator/src/models/calculator_provider.dart';

/// A widget that provides a user interface for weight conversion.
///
/// This converter allows users to input an amount, select 'from' and 'to'
/// weight units, and view the converted result.
class WeightConverter extends StatelessWidget {
  /// Creates a [WeightConverter] widget.
  const WeightConverter({super.key});

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
                  DropdownButton<String>(
                    value: provider.fromWeightUnit,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        provider.setFromWeightUnit(newValue);
                      }
                    },
                    items: provider.weightConversionRates.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    value: provider.toWeightUnit,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        provider.setToWeightUnit(newValue);
                      }
                    },
                    items: provider.weightConversionRates.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      provider.convertWeight();
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
