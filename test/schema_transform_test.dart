import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Schema Transform Tests', () {
    test('Schema without transform returns original data', () {
      final schema = EzSchema.shape({
        'name': Ez<String>().transform((v) => v.trim()).minLength(3),
        'age': Ez<int>().required(),
      });

      final (data, errors) = schema.validateSync({
        'name': '  John  ',
        'age': 25,
      });
      expect(errors, isEmpty);
      expect(data['name'], '  John  '); // Original value
      expect(data['age'], 25);
    });

    test('Schema with applyTransform=true returns transformed data', () {
      final schema = EzSchema.shape(
        {
          'name': Ez<String>().transform((v) => v.trim()).minLength(3),
          'age': Ez<int>().required(),
        },
        applyTransform: true,
      );

      final (data, errors) = schema.validateSync({
        'name': '  John  ',
        'age': 25,
      });
      expect(errors, isEmpty);
      expect(data['name'], 'John'); // Transformed value (trimmed)
      expect(data['age'], 25);
    });

    test('Schema transform with multiple transformations', () {
      final schema = EzSchema.shape(
        {
          'username': Ez<String>().transform((v) => v.trim().toLowerCase()),
          'email': Ez<String>().transform((v) => v.trim()),
          'bio': Ez<String>().transform((v) => v.trim()).maxLength(100),
        },
        applyTransform: true,
      );

      final (data, errors) = schema.validateSync({
        'username': '  JohnDoe  ',
        'email': '  john@example.com  ',
        'bio': '  Software developer  ',
      });

      expect(errors, isEmpty);
      expect(data['username'], 'johndoe');
      expect(data['email'], 'john@example.com');
      expect(data['bio'], 'Software developer');
    });

    test('Schema transform with validation errors', () {
      final schema = EzSchema.shape(
        {
          'name': Ez<String>().transform((v) => v.trim()).minLength(5),
          'age': Ez<int>().required(),
        },
        applyTransform: true,
      );

      final (data, errors) = schema.validateSync({
        'name': '  Jo  ', // Will be 'Jo' after trim, which is < 5 chars
        'age': 25,
      });

      expect(errors, isNotEmpty);
      expect(errors['name'], isA<String>()); // Error message
      expect(data['age'], 25);
    });

    test('Schema transform with string length transformation', () {
      final schema = EzSchema.shape(
        {
          'password':
              Ez<String>().transform((v) => v.length.toString()).required(),
          'username': Ez<String>().required(),
        },
        applyTransform: true,
      );

      final (data, errors) = schema.validateSync({
        'password': 'secret123',
        'username': 'john',
      });
      expect(errors, isEmpty);
      expect(data['password'], '9');
      expect(data['username'], 'john');
    });

    test('Schema transform with default values', () {
      final schema = EzSchema.shape(
        {
          'name': Ez<String>(defaultValue: 'Anonymous')
              .transform((v) => v.toUpperCase()),
          'status':
              Ez<String>(defaultValue: 'active').transform((v) => v.trim()),
        },
        applyTransform: true,
      );

      final (data, errors) = schema.validateSync({});

      expect(errors, isEmpty);
      expect(data['name'], 'ANONYMOUS');
      expect(data['status'], 'active');
    });

    test('Schema transform with nested schemas', () {
      final addressSchema = EzSchema.shape(
        {
          'street': Ez<String>().transform((v) => v.trim()),
          'city': Ez<String>().transform((v) => v.trim()),
        },
        applyTransform: true,
      );

      final userSchema = EzSchema.shape(
        {
          'name': Ez<String>().transform((v) => v.trim()),
          'address': addressSchema,
        },
        applyTransform: true,
      );

      final (data, errors) = userSchema.validateSync({
        'name': '  John Doe  ',
        'address': {
          'street': '  123 Main St  ',
          'city': '  New York  ',
        },
      });

      expect(errors, isEmpty);
      expect(data['name'], 'John Doe');
      expect(data['address']['street'], '123 Main St');
      expect(data['address']['city'], 'New York');
    });

    test('Schema transform preserves non-transformed fields', () {
      final schema = EzSchema.shape(
        {
          'name': Ez<String>().transform((v) => v.trim()),
          'age': Ez<int>().required(),
          'active': Ez<bool>().required(),
        },
        applyTransform: true,
      );

      final (data, errors) = schema.validateSync({
        'name': '  John  ',
        'age': 25,
        'active': true,
      });

      expect(errors, isEmpty);
      expect(data['name'], 'John');
      expect(data['age'], 25);
      expect(data['active'], true);
    });
  });
}
