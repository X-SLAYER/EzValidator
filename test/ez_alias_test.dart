import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Ez<T> API Alias Tests', () {
    test('Ez<String> with required validation', () {
      final validator = Ez<String?>().required().build();
      expect(validator(null), isNotNull, reason: 'null should fail');
      expect(validator(''), isNotNull, reason: 'empty string should fail');
      expect(validator('hello'), isNull, reason: 'valid string should pass');
    });

    test('Ez<String> with email validation', () {
      final emailValidator = Ez<String>().email().build();

      expect(emailValidator('test@example.com'), isNull, reason: 'valid email');
      expect(emailValidator('invalid-email'), isNotNull,
          reason: 'invalid email');
      expect(emailValidator('user@domain.co.uk'), isNull,
          reason: 'valid email with subdomain');
    });

    test('Ez<String> with length validations', () {
      final lengthValidator = Ez<String>().minLength(3).maxLength(10).build();

      expect(lengthValidator('ab'), isNotNull, reason: 'too short');
      expect(lengthValidator('abc'), isNull, reason: 'minimum length');
      expect(lengthValidator('hello'), isNull, reason: 'valid length');
      expect(lengthValidator('1234567890'), isNull, reason: 'maximum length');
      expect(lengthValidator('12345678901'), isNotNull, reason: 'too long');
    });

    test('Ez<int> with numeric validations', () {
      final numValidator = Ez<int>().min(10).max(100).build();

      expect(numValidator(5), isNotNull, reason: 'below minimum');
      expect(numValidator(10), isNull, reason: 'at minimum');
      expect(numValidator(50), isNull, reason: 'in range');
      expect(numValidator(100), isNull, reason: 'at maximum');
      expect(numValidator(150), isNotNull, reason: 'above maximum');
    });

    test('Ez with optional parameter', () {
      final optionalValidator =
          Ez<String?>(optional: true).minLength(5).build();

      expect(optionalValidator(null), isNull,
          reason: 'null should pass when optional');
      expect(optionalValidator(''), isNull,
          reason: 'empty should pass when optional');
      expect(optionalValidator('hi'), isNotNull,
          reason: 'short string should fail validation');
      expect(optionalValidator('hello'), isNull,
          reason: 'valid string should pass');
    });

    test('Ez with default value', () {
      final validatorWithDefault =
          Ez<String>(defaultValue: 'default').minLength(3).build();

      expect(validatorWithDefault(null), isNull,
          reason: 'null should use default value');
      expect(validatorWithDefault('ab'), isNotNull,
          reason: 'provided value should still be validated');
      expect(validatorWithDefault('hello'), isNull,
          reason: 'valid value should pass');
    });

    test('Ez with label', () {
      final labeledValidator =
          Ez<String>(label: 'Username').required().minLength(3).build();

      final result = labeledValidator('ab');
      expect(result, isNotNull, reason: 'should fail validation');
    });

    test('Ez with URL validation', () {
      final urlValidator = Ez<String>().url().build();

      expect(
        urlValidator('https://example.com'),
        isNull,
        reason: 'valid HTTPS URL',
      );
      expect(
        urlValidator('http://example.com/path'),
        isNull,
        reason: 'valid HTTP URL with path',
      );
      expect(
        urlValidator('not-a-url'),
        isNotNull,
        reason: 'invalid URL',
      );
      expect(
        urlValidator('https://pub.dev/packages/ez_validator'),
        isNull,
        reason: 'valid URL with path',
      );
    });

    test('Ez with UUID validation', () {
      final uuidValidator = Ez<String>().uuid().build();

      expect(uuidValidator('8e5285ea-9c09-11ee-8c90-0242ac120002'), isNull,
          reason: 'valid UUID v1');
      expect(uuidValidator('979d58e7-16c3-44c7-b219-618af4a83b73'), isNull,
          reason: 'valid UUID v4');
      expect(uuidValidator('not-a-uuid'), isNotNull, reason: 'invalid UUID');
    });

    test('Ez with IP validation', () {
      final ipv4Validator = Ez<String>().ip().build();
      final ipv6Validator = Ez<String>().ipv6().build();

      expect(ipv4Validator('192.168.1.1'), isNull, reason: 'valid IPv4');
      expect(ipv4Validator('invalid-ip'), isNotNull, reason: 'invalid IPv4');

      expect(ipv6Validator('::1'), isNull, reason: 'valid IPv6');
      expect(ipv6Validator('2001:db8:85a3::8a2e:370:7334'), isNull,
          reason: 'valid IPv6 with compression');
    });

    test('Ez with case validation', () {
      final lowerCaseValidator = Ez<String>().lowerCase().build();
      final upperCaseValidator = Ez<String>().upperCase().build();

      expect(lowerCaseValidator('hello'), isNull, reason: 'lowercase string');
      expect(lowerCaseValidator('HELLO'), isNotNull,
          reason: 'uppercase string should fail');

      expect(upperCaseValidator('HELLO'), isNull, reason: 'uppercase string');
      expect(upperCaseValidator('hello'), isNotNull,
          reason: 'lowercase string should fail');
    });

    test('Ez with regex matches', () {
      final matchValidator =
          Ez<String>().matches(RegExp(r'^\d{3}-\d{3}-\d{4}$')).build();

      expect(matchValidator('123-456-7890'), isNull,
          reason: 'valid phone format');
      expect(matchValidator('1234567890'), isNotNull, reason: 'invalid format');
      expect(matchValidator('abc-def-ghij'), isNotNull, reason: 'non-numeric');
    });

    test('Ez with type validation', () {
      final stringTypeValidator = Ez().isType(String).build();
      final intTypeValidator = Ez().isType(int).build();
      final listTypeValidator = Ez().isType(List<int>).build();

      expect(stringTypeValidator('hello'), isNull, reason: 'valid string type');
      expect(stringTypeValidator(123), isNotNull, reason: 'invalid type');

      expect(intTypeValidator(123), isNull, reason: 'valid int type');
      expect(intTypeValidator('123'), isNotNull, reason: 'invalid type');

      expect(listTypeValidator([1, 2, 3]), isNull, reason: 'valid list type');
      expect(listTypeValidator('not a list'), isNotNull,
          reason: 'invalid type');
    });

    test('Ez chaining multiple validators', () {
      final complexValidator = Ez<String>()
          .required()
          .minLength(8)
          .maxLength(20)
          .matches(RegExp(r'[A-Z]')) // Must contain uppercase
          .matches(RegExp(r'[0-9]')) // Must contain number
          .build();

      expect(complexValidator(null), isNotNull, reason: 'null should fail');
      expect(complexValidator('short'), isNotNull, reason: 'too short');
      expect(complexValidator('nouppercase1'), isNotNull,
          reason: 'missing uppercase');
      expect(complexValidator('NoNumbers'), isNotNull,
          reason: 'missing number');
      expect(complexValidator('ValidPass123'), isNull,
          reason: 'valid password');
    });

    test('Ez API is identical to EzValidator API', () {
      // Both should work exactly the same way
      final ezValidator = Ez<String>().email().build();
      final ezValidatorLong = EzValidator<String>().email().build();

      const testEmail = 'test@example.com';
      const invalidEmail = 'not-an-email';

      expect(ezValidator(testEmail), ezValidatorLong(testEmail),
          reason: 'Ez and EzValidator should produce same result');
      expect(ezValidator(invalidEmail), ezValidatorLong(invalidEmail),
          reason: 'Ez and EzValidator should produce same result');
    });
  });
}
