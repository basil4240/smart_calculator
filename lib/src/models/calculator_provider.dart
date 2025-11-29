import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:smart_calculator/src/models/app_mode.dart';
import 'package:smart_calculator/src/models/calculator_mode.dart';
import 'package:smart_calculator/src/models/converter_mode.dart';

/// Manages the state for the calculator and various converters.
///
/// This provider handles the display output, selected modes (calculator, converter),
/// input for conversions, and performs calculations or conversions.
class CalculatorProvider with ChangeNotifier {
  /// The current display output of the calculator.
  String _output = '0';

  /// Returns the current display output.
  String get output => _output;

  /// The currently selected calculator mode (standard or scientific).
  CalculatorMode _calculatorMode = CalculatorMode.standard;

  /// Returns the current calculator mode.
  CalculatorMode get calculatorMode => _calculatorMode;

  /// The current application mode (calculator or converter).
  AppMode _appMode = AppMode.calculator;

  /// Returns the current application mode.
  AppMode get appMode => _appMode;

  /// The currently selected converter mode (currency, weight, or length).
  ConverterMode _converterMode = ConverterMode.currency;

  /// Returns the current converter mode.
  ConverterMode get converterMode => _converterMode;

  /// The amount entered for conversion.
  double _amount = 0.0;
  /// The calculated converted value.
  double _convertedValue = 0.0;

  /// Returns the amount entered for conversion.
  double get amount => _amount;

  /// Returns the calculated converted value.
  double get convertedValue => _convertedValue;


  // --- Currency Conversion State ---
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _exchangeRate = 0.9; // 1 USD = 0.9 EUR (example rate)

  String get fromCurrency => _fromCurrency;
  String get toCurrency => _toCurrency;
  double get exchangeRate => _exchangeRate;

  // --- Weight Conversion State ---
  String _fromWeightUnit = 'Kilograms';
  String _toWeightUnit = 'Grams';
  String get fromWeightUnit => _fromWeightUnit;
  String get toWeightUnit => _toWeightUnit;
  final Map<String, double> _weightConversionRates = {
    'Grams': 1000.0,
    'Kilograms': 1.0,
    'Pounds': 2.20462,
    'Ounces': 35.274,
  };
  Map<String, double> get weightConversionRates => _weightConversionRates;


  // --- Length Conversion State ---
  String _fromLengthUnit = 'Meters';
  String _toLengthUnit = 'Kilometers';
  String get fromLengthUnit => _fromLengthUnit;
  String get toLengthUnit => _toLengthUnit;
  final Map<String, double> _lengthConversionRates = {
    'Meters': 1.0,
    'Kilometers': 0.001,
    'Feet': 3.28084,
    'Miles': 0.000621371,
  };
  Map<String, double> get lengthConversionRates => _lengthConversionRates;


  final List<dynamic> _allModes = [
    CalculatorMode.standard,
    CalculatorMode.scientific,
    ConverterMode.currency,
    ConverterMode.weight,
    ConverterMode.length,
  ];

  /// List of calculator modes available based on `allowedModes`.
  late List<dynamic> availableCalculatorModes;

  /// List of converter modes available based on `allowedModes`.
  late List<dynamic> availableConverterModes;

  /// Initializes the [CalculatorProvider] with optional `allowedModes`.
  ///
  /// If `allowedModes` is provided, only those modes will be available.
  /// Otherwise, all default modes will be available.
  CalculatorProvider({List<dynamic>? allowedModes}) {
    if (allowedModes != null && allowedModes.isNotEmpty) {
      availableCalculatorModes =
          allowedModes.whereType<CalculatorMode>().toList();
      availableConverterModes =
          allowedModes.whereType<ConverterMode>().toList();
    } else {
      availableCalculatorModes =
          _allModes.whereType<CalculatorMode>().toList();
      availableConverterModes =
          _allModes.whereType<ConverterMode>().toList();
    }
    // Set initial modes if available
    if(availableCalculatorModes.isNotEmpty) {
      _calculatorMode = availableCalculatorModes.first;
    }
    if(availableConverterModes.isNotEmpty) {
      _converterMode = availableConverterModes.first;
      _resetConverterState();
    }
  }

  /// Sets the current calculator mode.
  void setCalculatorMode(CalculatorMode mode) {
    _calculatorMode = mode;
    notifyListeners();
  }

  /// Sets the current application mode (calculator or converter).
  void setAppMode(AppMode mode) {
    _appMode = mode;
    notifyListeners();
  }

  void _resetConverterState() {
    _amount = 0.0;
    _convertedValue = 0.0;
    switch (_converterMode) {
      case ConverterMode.currency:
        _fromCurrency = 'USD';
        _toCurrency = 'EUR';
        break;
      case ConverterMode.weight:
        _fromWeightUnit = 'Kilograms';
        _toWeightUnit = 'Grams';
        break;
      case ConverterMode.length:
        _fromLengthUnit = 'Meters';
        _toLengthUnit = 'Kilometers';
        break;
    }
  }


  /// Sets the current converter mode and resets state.
  void setConverterMode(ConverterMode mode) {
    _converterMode = mode;
    _resetConverterState();
    notifyListeners();
  }

  /// Sets the amount for conversion.
  void setAmount(String value) {
    try {
      _amount = double.parse(value);
    } catch (e) {
      _amount = 0.0;
    }
    notifyListeners();
  }

  // --- Currency Methods ---
  void setFromCurrency(String currency) {
    _fromCurrency = currency;
    notifyListeners();
  }

  void setToCurrency(String currency) {
    _toCurrency = currency;
    notifyListeners();
  }

  void setExchangeRate(String rate) {
    try {
      _exchangeRate = double.parse(rate);
    } catch (e) {
      _exchangeRate = 0.0;
    }
    notifyListeners();
  }

  void convertCurrency() {
    _convertedValue = _amount * _exchangeRate; // Simple conversion for now
    notifyListeners();
  }


  // --- Weight Methods ---
  void setFromWeightUnit(String unit) {
    _fromWeightUnit = unit;
    notifyListeners();
  }

  void setToWeightUnit(String unit) {
    _toWeightUnit = unit;
    notifyListeners();
  }

  void convertWeight() {
    double? fromRate = _weightConversionRates[_fromWeightUnit];
    double? toRate = _weightConversionRates[_toWeightUnit];
    if (fromRate != null && toRate != null) {
      _convertedValue = _amount * (toRate / fromRate);
    } else {
      _convertedValue = 0.0;
    }
    notifyListeners();
  }

  // --- Length Methods ---
  void setFromLengthUnit(String unit) {
    _fromLengthUnit = unit;
    notifyListeners();
  }

  void setToLengthUnit(String unit) {
    _toLengthUnit = unit;
    notifyListeners();
  }

  void convertLength() {
    double? fromRate = _lengthConversionRates[_fromLengthUnit];
    double? toRate = _lengthConversionRates[_toLengthUnit];
    if (fromRate != null && toRate != null) {
      _convertedValue = _amount * (toRate / fromRate);
    } else {
      _convertedValue = 0.0;
    }
    notifyListeners();
  }


  /// Handles button presses for the calculator.
  ///
  /// Processes numerical input, operators, and the equals and clear buttons.
  void buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _output = '0';
    } else if (buttonText == '=') {
      try {
        Parser p = ShuntingYardParser();
        Expression exp = p.parse(_output);
        ContextModel cm = ContextModel();
        _output = exp.evaluate(EvaluationType.REAL, cm).toString();
      } catch (e) {
        _output = 'Error';
      }
    } else {
      if (_output == '0') {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }
    notifyListeners();
  }
}