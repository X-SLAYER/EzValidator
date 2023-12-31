import 'package:ez_validator/src/validator/ez_validator_builder.dart';
import 'package:ez_validator/src/validator/types/validators.dart';
import 'package:test/test.dart';

void main() {
  group('Array Validator Tests', () {
    final validator = EzValidator().arrayOf<dynamic>(
      EzValidator<num>().required().positive(),
    );

    final numString = EzValidator().arrayOf<dynamic>(
      EzValidator<String>().required().positive(),
    );

    test('Valid array should pass validation', () {
      var result = validator.validate([1, 2, 3, 4, 5]);
      expect(result, isNull);
    });

    test('Array with negative numbers should fail validation', () {
      var result = validator.validate([1, -2, 3, 4, -5]);
      expect(result, contains('The field must be a positive number'));
    });

    test('Empty array should pass validation', () {
      var result = validator.validate([]);
      expect(result, isNull);
    });

    test('Null array should pass validation', () {
      var result = validator.validate(null);
      expect(result, isNull);
    });

    test('Num String array should pass validation', () {
      var result = numString.validate(['1', '2', '3', '4', '5']);
      expect(result, isNull);
    });

    test('Array with non-numeric values should fail validation', () {
      var result = validator.validate([1, 'two', 3, 4.5]);
      expect(result, isNotNull);
    });
  });
}
