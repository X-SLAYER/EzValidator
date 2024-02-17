import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Schema Validation with noUnknown', () {
    final EzSchema schema = EzSchema.shape(
      {
        'email': EzValidator<String>().required().email(),
        'password': EzValidator<String>().required(),
      },
      noUnknown: true,
      fillSchema: false,
    );

    test('Unknown Age data in the schema should fail', () {
      final Map<String, dynamic> formData = {
        'email': 'test@email.com',
        'password': 'password',
        'age': 25,
      };
      final (_, errors) = schema.validateSync(formData);
      expect(errors, isNotEmpty);
      expect(errors.keys, contains("age"));
    });
  });

  group('Schema Validation with noUnknown and fillSchema', () {
    final EzSchema schemaWithUnknownAllowed = EzSchema.shape(
      {
        'email': EzValidator<String>().required().email(),
        'password': EzValidator<String>().required(),
      },
      noUnknown: false,
      fillSchema: true,
    );

    final EzSchema strictSchema = EzSchema.shape(
      {
        'email': EzValidator<String>().required().email(),
        'password': EzValidator<String>().required(),
        'username': EzValidator<String>().required(),
      },
      noUnknown: true, // Disallow unknown fields
      fillSchema: false, // Do not fill missing fields
    );

    test('Valid data without unknown fields should pass', () {
      final Map<String, dynamic> validData = {
        'email': 'valid@email.com',
        'password': 'validPassword',
      };

      final (_, errors) = schemaWithUnknownAllowed.validateSync(validData);

      expect(errors.isEmpty, isTrue);
    });

    test('Unknown data in strict schema should fail', () {
      final Map<String, dynamic> dataWithUnknown = {
        'email': 'test@email.com',
        'password': 'password',
        'age': 30, // Unknown field
      };

      final (_, errors) = strictSchema.validateSync(dataWithUnknown);

      expect(errors, isNotEmpty);
      expect(errors.keys, contains('age'));
    });

    test('Missing default fields should not be filled in strict mode', () {
      final Map<String, dynamic> incompleteData = {
        'email': 'test@email.com',
        'password': 'password',
        // 'username' is missing and should not be filled because fillSchema is false
      };

      final errors = strictSchema.catchErrors(incompleteData);

      expect(errors, isNotEmpty);
      expect(errors.keys, contains('username'));
    });

    test(
        'Data with all known fields and correct defaults should pass in strict mode',
        () {
      final Map<String, dynamic> completeData = {
        'email': 'user@email.com',
        'password': 'securePassword',
        'username': 'customUser',
      };

      final (_, errors) = strictSchema.validateSync(completeData);

      expect(errors.isEmpty, isTrue);
    });
  });
}
