import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_calculator/src/models/calculator_provider.dart';
import 'package:smart_calculator/src/smart_calculator_view.dart';

export 'package:smart_calculator/enums.dart';
export 'package:smart_calculator/src/ui/theme/themes.dart';

/// A customizable Flutter calculator and converter widget.
///
/// The [SmartCalculator] provides a modern and responsive user interface
/// for performing calculations and unit conversions. Developers can customize
/// the available modes and theme of the calculator.
class SmartCalculator extends StatefulWidget {
  /// An optional custom theme for the calculator.
  ///
  /// If `null`, the calculator will use the ambient [Theme] from the context.
  final ThemeData? customTheme;

  /// A list of allowed modes to be displayed in the calculator.
  ///
  /// This list can contain [CalculatorMode] and [ConverterMode] enums.
  /// If `null` or empty, all modes will be available by default.
  final List<dynamic>? allowedModes;

  /// Creates a [SmartCalculator] widget.
  const SmartCalculator({
    super.key,
    this.customTheme,
    this.allowedModes,
  });

  @override
  State<SmartCalculator> createState() => _SmartCalculatorState();
}

class _SmartCalculatorState extends State<SmartCalculator> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorProvider(allowedModes: widget.allowedModes),
      child: Theme(
        data: widget.customTheme ?? Theme.of(context),
        child: SmartCalculatorView(allowedModes: widget.allowedModes),
      ),
    );
  }
}