import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Transform Method Tests', () {
    test('Trimming whitespace before validation', () {
      final validator = Ez<String>()
          .transform((value) => value.trim())
          .minLength(
              5, "Input must be at least 5 characters long after trimming.")
          .build();

      expect(validator("  hello  "), isNull);
      expect(validator("  hi  "),
          "Input must be at least 5 characters long after trimming.");
    });

    test('Transforming string to int before validation', () {
      final validator = Ez<dynamic>()
          .transform((value) => int.tryParse(value) ?? 0)
          .addMethod((value) => value > 0, 'Value must be a positive number')
          .build();

      expect(validator("123"), isNull);
      expect(validator("abc"), "Value must be a positive number");
    });

    test('Must be a string empty', () {
      final validator = Ez<String>()
          .transform((value) => "")
          .addMethod((str) => str!.isNotEmpty, "Must be a string empty")
          .build();

      expect(validator("XXXXXXX"), "Must be a string empty");
    });

    test('Must Not be a string empty', () {
      final validator = Ez<String>()
          .transform((value) => '--$value--')
          .addMethod((str) => str!.contains('--'), 'Must Not be a string empty')
          .build();

      expect(validator("IHEB"), isNull);
    });
  });

  group('Transform with Value Return Tests', () {
    test('Transform returns string length as string', () {
      final validator = Ez<String>()
          .transform((value) => value.length.toString())
          .build(applyTransform: true);
      expect(validator("hello"), "5");
      expect(validator("test"), "4");
    });

    test('Transform trims and returns trimmed value', () {
      final validator = Ez<String>()
          .transform((value) => value.trim())
          .minLength(3)
          .build(applyTransform: true);

      expect(validator("  hello  "), "hello");
      expect(validator("  hi  "), isA<String>()); // Returns error message
    });

    test('Transform returns uppercase string', () {
      final validator = Ez<String>()
          .transform((value) => value.toUpperCase())
          .build(applyTransform: true);

      expect(validator("hello"), "HELLO");
      expect(validator("world"), "WORLD");
    });

    test('Transform with multiple operations', () {
      final validator = Ez<String>()
          .transform((value) => value.trim().toUpperCase())
          .minLength(2)
          .build(applyTransform: true);

      expect(validator("  hello  "), "HELLO");
      expect(validator(" a "), isA<String>()); // Returns error
    });
  });
}
