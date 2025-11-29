import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_calculator/src/models/calculator_provider.dart';

/// A widget that displays the current output of the calculator.
///
/// This widget listens to changes in the [CalculatorProvider]'s `output`
/// and updates the displayed text accordingly.
class Display extends StatelessWidget {
  /// Creates a [Display] widget.
  const Display({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.bottomRight,
      child: Consumer<CalculatorProvider>(
        builder: (context, provider, child) {
          return Text(
            provider.output,
            style: const TextStyle(fontSize: 48.0),
          );
        },
      ),
    );
  }
}
