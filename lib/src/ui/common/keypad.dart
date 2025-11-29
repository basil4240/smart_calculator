import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_calculator/src/models/calculator_provider.dart';

/// A widget that represents the keypad for the standard calculator.
///
/// This widget displays a grid of buttons for numerical input and basic
/// arithmetic operations. It interacts with the [CalculatorProvider]
/// to process button presses.
class KeyPad extends StatelessWidget {
  /// Creates a [KeyPad] widget.
  const KeyPad({super.key});

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context, listen: false);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double height = constraints.maxHeight;
        final double width = constraints.maxWidth;
        final double childAspectRatio = (width / 4) / (height / 5);

        return GridView.count(
          crossAxisCount: 4,
          childAspectRatio: childAspectRatio,
          children: <Widget>[
            _buildButton('C', calculatorProvider, height, context),
            _buildButton('7', calculatorProvider, height, context),
            _buildButton('8', calculatorProvider, height, context),
            _buildButton('9', calculatorProvider, height, context),
            _buildButton('/', calculatorProvider, height, context),
            _buildButton('4', calculatorProvider, height, context),
            _buildButton('5', calculatorProvider, height, context),
            _buildButton('6', calculatorProvider, height, context),
            _buildButton('*', calculatorProvider, height, context),
            _buildButton('1', calculatorProvider, height, context),
            _buildButton('2', calculatorProvider, height, context),
            _buildButton('3', calculatorProvider, height, context),
            _buildButton('-', calculatorProvider, height, context),
            _buildButton('0', calculatorProvider, height, context),
            _buildButton('.', calculatorProvider, height, context),
            _buildButton('=', calculatorProvider, height, context),
            _buildButton('+', calculatorProvider, height, context),
          ],
        );
      },
    );
  }

  /// Helper method to build a single calculator button.
  ///
  /// [text] is the label displayed on the button.
  /// [provider] is the [CalculatorProvider] to interact with.
  /// [height] is used for responsive font sizing.
  /// [context] is the build context to access the theme.
  Widget _buildButton(String text, CalculatorProvider provider, double height, BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: MaterialButton(
        onPressed: () {
          provider.buttonPressed(text);
        },
        color: theme.colorScheme.surface,
        textColor: theme.colorScheme.onSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: height / 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}