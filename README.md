# Smart Calculator

A professional Flutter calculator widget with a customizable design that can be easily integrated into any Flutter application. Inspired by the Windows 10 calculator, this package provides a modern, feature-rich, and responsive calculator and unit converter.

## Features

- **Calculator Modes:**
  - Standard Calculator
  - Scientific Calculator
- **Converter Modes:**
  - Currency Converter
  - Weight Converter
  - Length Converter
- **Customizable:**
  - Choose which calculator and converter modes to display.
  - Light and dark themes.
- **Responsive:**
  - Adapts to different screen sizes and orientations.

## Getting started

To use this package, add `smart_calculator` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  smart_calculator: ^1.0.0
```

Then, import the package in your Dart code:

```dart
import 'package:smart_calculator/smart_calculator.dart';
```

## Usage

Here's a simple example of how to use the `SmartCalculator` widget:

```dart
import 'package:flutter/material.dart';
import 'package:smart_calculator/smart_calculator.dart';
import 'package:smart_calculator/src/models/calculator_mode.dart';
import 'package:smart_calculator/src/models/converter_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SmartCalculator(
        // You can customize the allowed modes
        allowedModes: [
          CalculatorMode.standard,
          CalculatorMode.scientific,
          ConverterMode.currency,
          ConverterMode.weight,
          ConverterMode.length,
        ],
      ),
    );
  }
}
```

To customize the available modes, pass a list of `CalculatorMode` and `ConverterMode` enums to the `allowedModes` parameter. For example, to only show the standard calculator and the currency converter:

```dart
SmartCalculator(
  allowedModes: [
    CalculatorMode.standard,
    ConverterMode.currency,
  ],
)
```

## Additional information

For more information, feel free to check out the [GitHub repository](https://github.com/basil4240/smart_calculator).

If you encounter any issues or have suggestions for improvement, please file an issue on the [issue tracker](https://github.com/basil4240/smart_calculator/issues).