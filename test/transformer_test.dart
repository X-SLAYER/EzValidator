import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Transform Method Tests', () {
    test('Trimming whitespace before validation', () {
      final validator = EzValidator<String>()
          .transform((value) => value.trim())
          .minLength(
              5, "Input must be at least 5 characters long after trimming.")
          .build();

      expect(validator("  hello  "), isNull);
      expect(validator("  hi  "),
          "Input must be at least 5 characters long after trimming.");
    });

    test('Transforming string to int before validation', () {
      final validator = EzValidator<dynamic>()
          .transform((value) => int.tryParse(value) ?? 0)
          .addMethod((value) => value > 0, 'Value must be a positive number')
          .build();

      expect(validator("123"), isNull);
      expect(validator("abc"), "Value must be a positive number");
    });

    test('Must be a string empty', () {
      final validator = EzValidator<String>()
          .transform((value) => "")
          .addMethod((str) => str!.isNotEmpty, "Must be a string empty")
          .build();

      expect(validator("XXXXXXX"), "Must be a string empty");
    });

    test('Must Not be a string empty', () {
      final validator = EzValidator<String>()
          .transform((value) => '--$value--')
          .addMethod((str) => str!.contains('--'), 'Must Not be a string empty')
          .build();

      expect(validator("IHEB"), isNull);
    });
  });
}
