import 'package:flutter_test/flutter_test.dart';
import 'package:smart_calculator/enums.dart';
import 'package:smart_calculator/src/models/calculator_provider.dart';

void main() {
  group('CalculatorProvider', () {
    late CalculatorProvider calculatorProvider;

    setUp(() {
      calculatorProvider = CalculatorProvider();
    });

    test('Initial output is 0', () {
      expect(calculatorProvider.output, '0');
    });

    test('Button press updates output', () {
      calculatorProvider.buttonPressed('1');
      expect(calculatorProvider.output, '1');
      calculatorProvider.buttonPressed('2');
      expect(calculatorProvider.output, '12');
    });

    test('Clear button resets output', () {
      calculatorProvider.buttonPressed('1');
      calculatorProvider.buttonPressed('2');
      calculatorProvider.buttonPressed('C');
      expect(calculatorProvider.output, '0');
    });

    test('Addition works correctly', () {
      calculatorProvider.buttonPressed('2');
      calculatorProvider.buttonPressed('+');
      calculatorProvider.buttonPressed('3');
      calculatorProvider.buttonPressed('=');
      expect(calculatorProvider.output, '5.0');
    });

    test('Subtraction works correctly', () {
      calculatorProvider.buttonPressed('5');
      calculatorProvider.buttonPressed('-');
      calculatorProvider.buttonPressed('3');
      calculatorProvider.buttonPressed('=');
      expect(calculatorProvider.output, '2.0');
    });

    test('Multiplication works correctly', () {
      calculatorProvider.buttonPressed('2');
      calculatorProvider.buttonPressed('*');
      calculatorProvider.buttonPressed('3');
      calculatorProvider.buttonPressed('=');
      expect(calculatorProvider.output, '6.0');
    });

    test('Division works correctly', () {
      calculatorProvider.buttonPressed('6');
      calculatorProvider.buttonPressed('/');
      calculatorProvider.buttonPressed('3');
      calculatorProvider.buttonPressed('=');
      expect(calculatorProvider.output, '2.0');
    });

    test('Invalid expression returns Error', () {
      calculatorProvider.buttonPressed('2');
      calculatorProvider.buttonPressed('+');
      calculatorProvider.buttonPressed('/');
      calculatorProvider.buttonPressed('3');
      calculatorProvider.buttonPressed('=');
      expect(calculatorProvider.output, 'Error');
    });

    group('Scientific functions', () {
      test('sin function works correctly', () {
        calculatorProvider.buttonPressed('sin(30)');
        calculatorProvider.buttonPressed('=');
        expect(calculatorProvider.output, '-0.9880316240928618');
      });

      test('cos function works correctly', () {
        calculatorProvider.buttonPressed('cos(60)');
        calculatorProvider.buttonPressed('=');
        expect(calculatorProvider.output, '-0.9524129804151563');
      });

      test('tan function works correctly', () {
        calculatorProvider.buttonPressed('tan(45)');
        calculatorProvider.buttonPressed('=');
        expect(calculatorProvider.output, '1.6197751905438615');
      });

      test('sqrt function works correctly', () {
        calculatorProvider.buttonPressed('sqrt(4)');
        calculatorProvider.buttonPressed('=');
        expect(calculatorProvider.output, '2.0');
      });

      test('Power function works correctly', () {
        calculatorProvider.buttonPressed('2');
        calculatorProvider.buttonPressed('^');
        calculatorProvider.buttonPressed('3');
        calculatorProvider.buttonPressed('=');
        expect(calculatorProvider.output, '8.0');
      });
    });

    group('Currency Converter functions', () {
      test('Initial converted value is 0.0', () {
        expect(calculatorProvider.convertedValue, 0.0);
      });

      test('Setting amount updates amount', () {
        calculatorProvider.setAmount('100');
        expect(calculatorProvider.amount, 100.0);
      });

      test('Setting from currency updates fromCurrency', () {
        calculatorProvider.setFromCurrency('GBP');
        expect(calculatorProvider.fromCurrency, 'GBP');
      });

      test('Setting to currency updates toCurrency', () {
        calculatorProvider.setToCurrency('JPY');
        expect(calculatorProvider.toCurrency, 'JPY');
      });

      test('Setting exchange rate updates exchangeRate', () {
        calculatorProvider.setExchangeRate('1.2');
        expect(calculatorProvider.exchangeRate, 1.2);
      });

      test('Currency conversion works correctly', () {
        calculatorProvider.setAmount('100');
        calculatorProvider.setExchangeRate('0.85'); // 1 USD = 0.85 EUR
        calculatorProvider.convertCurrency();
        expect(calculatorProvider.convertedValue, 85.0);
      });
    });

    group('Weight Converter functions', () {
      test('Setting from unit updates fromWeightUnit', () {
        calculatorProvider.setFromWeightUnit('Kilograms');
        expect(calculatorProvider.fromWeightUnit, 'Kilograms');
      });

      test('Setting to unit updates toWeightUnit', () {
        calculatorProvider.setToWeightUnit('Grams');
        expect(calculatorProvider.toWeightUnit, 'Grams');
      });

      test('Weight conversion works correctly', () {
        calculatorProvider.setAmount('1');
        calculatorProvider.setFromWeightUnit('Kilograms');
        calculatorProvider.setToWeightUnit('Grams');
        calculatorProvider.convertWeight();
        expect(calculatorProvider.convertedValue, 1000.0);
      });
    });

    group('Length Converter functions', () {
      test('Setting from unit updates fromLengthUnit', () {
        calculatorProvider.setFromLengthUnit('Meters');
        expect(calculatorProvider.fromLengthUnit, 'Meters');
      });

      test('Setting to unit updates toLengthUnit', () {
        calculatorProvider.setToLengthUnit('Feet');
        expect(calculatorProvider.toLengthUnit, 'Feet');
      });

      test('Length conversion works correctly', () {
        calculatorProvider.setAmount('1');
        calculatorProvider.setFromLengthUnit('Meters');
        calculatorProvider.setToLengthUnit('Feet');
        calculatorProvider.convertLength();
        expect(calculatorProvider.convertedValue, 3.28084);
      });
    });

    group('Converter State Management', () {
      test('Switching converter mode resets units', () {
        // Start with weight and set non-default units
        calculatorProvider.setConverterMode(ConverterMode.weight);
        calculatorProvider.setFromWeightUnit('Pounds');
        calculatorProvider.setToWeightUnit('Ounces');

        // Switch to length
        calculatorProvider.setConverterMode(ConverterMode.length);

        // Check that length units are reset to their defaults
        expect(calculatorProvider.fromLengthUnit, 'Meters');
        expect(calculatorProvider.toLengthUnit, 'Kilometers');

        // Switch back to weight
        calculatorProvider.setConverterMode(ConverterMode.weight);

        // Check that weight units are also reset to their defaults
        expect(calculatorProvider.fromWeightUnit, 'Kilograms');
        expect(calculatorProvider.toWeightUnit, 'Grams');
      });
    });
  });
}
