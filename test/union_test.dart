import 'package:ez_validator/src/validator/types/union.dart';
import 'package:test/test.dart';
import 'package:ez_validator/ez_validator.dart';

void main() {
  group('UnionValidator Tests', () {
    test('should validate basic string or number union', () {
      final validator = Ez().union([
        Ez<String>().isType(String),
        Ez<num>().isType(num),
      ]);

      expect(validator.validate('test'), isNull);
      expect(validator.validate(123), isNull);
      expect(validator.validate(123.45), isNull);
      expect(validator.validate(true), isNotNull);
      expect(validator.validate([]), isNotNull);
    });

    test('should work with complex string validations', () {
      final validator = Ez().union([
        Ez<String>().isType(String).minLength(3).maxLength(10),
        Ez<num>().isType(num)
      ]);

      expect(validator.validate('test'), isNull);
      expect(validator.validate('ab'), isNotNull);
      expect(validator.validate('verylongstring'), isNotNull);
      expect(validator.validate(123), isNull);
    });

    test('should validate with additional constraints after union', () {
      final validator = Ez().union(
          [Ez<String>().isType(String), Ez<num>().isType(num)]).required();

      expect(validator.validate(null), isNotNull);
      expect(validator.validate(''), isNotNull);
      expect(validator.validate('test'), isNull);
      expect(validator.validate(123), isNull);
    });

    test('should work within EzSchema', () {
      final schema = EzSchema.shape({
        'mixedField':
            Ez().union([Ez<String>().isType(String), Ez<num>().isType(num)])
      });

      expect(schema.catchErrors({'mixedField': 'test'}), isEmpty);
      expect(schema.catchErrors({'mixedField': 123}), isEmpty);
      expect(schema.catchErrors({'mixedField': true}), isNotEmpty);
    });

    test('should validate nested unions', () {
      final validator = Ez().union([
        Ez().union([Ez<String>().isType(String), Ez<num>().isType(num)]),
        Ez<bool>().isType(bool)
      ]);

      expect(validator.validate('test'), isNull);
      expect(validator.validate(123), isNull);
      expect(validator.validate(true), isNull);
      expect(validator.validate([]), isNotNull);
    });

    test('should validate with type-specific validations', () {
      final validator = Ez().union([
        Ez<String>().isType(String).email(),
        Ez<num>()
            .isType(num)
            .addMethod((v) => (v as num) > 0, 'Must be positive')
      ]);

      expect(validator.validate('test@example.com'), isNull);
      expect(validator.validate('invalid-email'), isNotNull);
      expect(validator.validate(42), isNull);
      expect(validator.validate(-1), isNotNull);
    });

    test('should handle empty validator list', () {
      expect(
        () => Ez().union([]),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should validate with custom transform functions', () {
      final validator = Ez().union([
        Ez<String>().isType(String).transform((v) => v.toLowerCase()),
        Ez<num>().isType(num)
      ]);

      expect(validator.validate('TEST'), isNull);
      expect(validator.validate(123), isNull);
    });

    test('should work with dependsOn validation', () {
      final schema = EzSchema.shape({
        'type': Ez<String>().required(),
        'value': Ez().union([
          Ez<String>().isType(String),
          Ez<num>().isType(num),
          Ez<List<String>>().isType(List<String>)
        ])
      });

      expect(
        schema.catchErrors({'type': 'text', 'value': 'ab'}),
        isEmpty,
      );

      expect(
        schema.catchErrors({'type': 'text', 'value': 25}),
        isEmpty,
      );

      expect(
        schema.catchErrors({'type': 'number', 'value': -1}),
        isEmpty,
      );

      expect(
        schema.catchErrors({
          'type': 'number',
          'value': ['lines', 'test']
        }),
        isEmpty,
      );
    });
  });
}
