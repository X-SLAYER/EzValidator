import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Siblings Tests', () {
    final EzSchema schema = EzSchema.shape({
      "password": EzValidator<String>().required().minLength(8),
      "confirmPassword": EzValidator<String>().required().when(
          "password",
          (confirmValue, [ref]) => confirmValue == ref?["password"]
              ? null
              : "Passwords do not match"),
    });

    test('Matching passwords should pass validation', () {
      var (_, errors) = schema.validateSync({
        "password": "password123",
        "confirmPassword": "password123",
      });
      expect(errors.isEmpty, isTrue);
    });

    test('Non-matching passwords should fail validation', () {
      var (_, errors) = schema.validateSync({
        "password": "password123",
        "confirmPassword": "different",
      });
      expect(errors.containsKey('confirmPassword'), isTrue);
      expect(errors['confirmPassword'], equals("Passwords do not match"));
    });

    test('Missing confirmPassword should fail validation', () {
      var (_, errors) = schema.validateSync({
        "password": "password123",
      });
      expect(errors.containsKey('confirmPassword'), isTrue);
      expect(errors['confirmPassword'], isNotNull);
    });

    test('Password shorter than 8 characters should fail validation', () {
      var (data, _) = schema.validateSync({
        "password": "short",
        "confirmPassword": "short",
      });
      expect(data.containsKey('password'), isTrue);
    });

    test('Missing password should fail validation', () {
      var (_, errors) = schema.validateSync({
        "confirmPassword": "password123",
      });
      expect(errors.containsKey('password'), isTrue);
    });

    test('Optional confirmPassword should pass when missing', () {
      final optionalSchema = EzSchema.shape({
        "password": EzValidator<String>().required().minLength(8),
        "confirmPassword": EzValidator<String?>(optional: true).when(
            "password",
            (confirmValue, [ref]) => confirmValue == ref?["password"]
                ? null
                : "Passwords do not match"),
      });

      var (_, errors) = optionalSchema.validateSync({
        "password": "password123",
      });
      expect(errors.isEmpty, isTrue);
    });

    test('Nested schema validation', () {
      final nestedSchema = EzSchema.shape({
        "user": EzSchema.shape({
          "password": EzValidator<String>().required().minLength(8),
          "confirmPassword": EzValidator<String>().required().when(
              "password",
              (confirmValue, [ref]) => confirmValue == ref?["password"]
                  ? null
                  : "Passwords do not match"),
        })
      });

      var (_, errors) = nestedSchema.validateSync({
        "user": {
          "password": "password123",
          "confirmPassword": "password123",
        }
      });
      expect(errors.isEmpty, isTrue);
    });
  });
}
