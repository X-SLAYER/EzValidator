import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  final EzSchema ezSchema = EzSchema.shape(
    {
      "email": EzValidator<String>(label: "l'email").required().email(),
      "password":
          EzValidator<String>(label: 'le mot de passe').required().minLength(8),
      'date': EzValidator<DateTime>()
          .required()
          .date()
          .minDate(DateTime(2019))
          .maxDate(DateTime(2070)),
    },
  );

  final EzSchema arraySchema = EzSchema.shape(
      {"nodes": EzValidator<List>().required().listOf(int).minLength(2)});

  final EzSchema personSchema = EzSchema.shape(
    {
      "firstName": EzValidator<String>().required(),
      "nickName": EzValidator<String>().required(),
      "sex": EzValidator<String>().required().oneOf(['M', 'F']),
      "email": EzValidator<String>().required().email(),
      "age": EzValidator<int>(defaultValue: 25).required().min(18).max(150),
      "birthDate": EzValidator<DateTime>()
          .required()
          .date()
          .minDate(DateTime(1900))
          .maxDate(DateTime(2005)),
    },
  );

  final EzSchema nestedSchema = EzSchema.shape(
    {
      "firstName": EzValidator<String>().required(),
      "nickName": EzValidator<String>().required(),
      "sex": EzValidator<String>().required().oneOf(['M', 'F']),
      "email": EzValidator<String>().required().email(),
      "age": EzValidator<int>(defaultValue: 25).required().min(18).max(150),
      'address': EzSchema.shape({
        'street': EzValidator<String?>(optional: true).required(),
        'city': EzValidator<String?>(optional: true).required(),
        'zipCode': EzValidator<num?>(defaultValue: 5000).required(),
      }),
    },
  );

  final EzSchema userProfileSchema = EzSchema.shape({
    "firstName": EzValidator<String>().required(),
    "lastName": EzValidator<String>().required(),
    "email": EzValidator<String>().required().email(),
    "age": EzValidator<int>().min(18).max(100),
    'contactDetails': EzSchema.shape({
      'mobile': EzValidator<String>()
          .required()
          .matches(RegExp(r'^\+\d{10,15}$'), 'Invalid phone number'),
      'landline': EzValidator<String?>(optional: true),
    }),
    'level': EzValidator<String>(defaultValue: 'Beginner').required().oneOf([
      'Beginner',
      'Intermediate',
      'Advanced',
      'Expert',
    ]),
    'address': EzSchema.shape({
      'street': EzValidator<String>().required(),
      'city': EzValidator<String>().required(),
      'state': EzValidator<String>().required(),
      'zipCode': EzValidator<num>().required(),
      'country': EzSchema.shape({
        'name': EzValidator<String>(defaultValue: 'TUNISIA').required(),
        'code': EzValidator<String>().required(),
        'continent': EzSchema.shape({
          'name': EzValidator<String>().required(),
          'code': EzValidator<String>().required(),
        })
      }),
    }),
    'employment': EzSchema.shape({
      'current': EzValidator<String?>(optional: true),
      'previous': EzSchema.shape({
        'companyName': EzValidator<String>().required(),
        'position': EzValidator<String>().required(),
        'years': EzValidator<int>().min(1).max(50),
      }),
    }),
  });

  final EzSchema schoolSchema = EzSchema.shape(
    {
      "subject": EzValidator<String>().required(),
      "description": EzValidator<String>().required(),
      "daysOfWeek": EzValidator<List<String>>(defaultValue: ['Monday'])
          .required()
          .arrayOf<String>(
            EzValidator<String>().oneOf(['Monday', 'Tuesday']),
          ),
    },
  );

  group('Schema Validation', () {
    test('Check schema results', () {
      final errors = ezSchema.catchErrors({
        'email': 'example@domain.com',
        'password': '12345678',
        'date': DateTime.now(),
      });

      expect(errors, isA<Map>(), reason: 'Errors should be a Map');
      expect(errors, isEmpty, reason: 'No validation errors expected');
    });
  });

  test('Check schema results for an array', () {
    final (_, errors) = arraySchema.validateSync({
      'nodes': ["XXX"]
    });
    expect(errors, isA<Map>(), reason: 'Errors should be a Map');
    expect(
      errors.containsKey('nodes'),
      isTrue,
      reason: 'nodes validation error expected',
    );
  });

  test('Person Schema Validation', () {
    final (data, errors) = personSchema.validateSync({
      'firstName': 'John',
      'nickName': 'Doe',
      'sex': 'F',
      'email': 'iheb@pixelium.tn',
      'birthDate': DateTime(2000),
      'address': {
        'street': 'Rue de la paix',
        'city': 'Paris',
        'zipCode': 75000,
      }
    });

    expect(errors, isA<Map>(), reason: 'Errors should be a Map');
    expect(errors, isEmpty, reason: 'No errors expected');
    expect(data, isA<Map>(), reason: 'Data should be a Map');
  });

  test('Nested Schema Validation', () {
    final (data, errors) = nestedSchema.validateSync({
      'firstName': 'John',
      'nickName': 'Doe',
      'sex': 'F',
      'email': 'iheb@pixelium.tn',
    });

    expect(errors, isA<Map>(), reason: 'Errors should be a Map');
    expect(errors, isEmpty, reason: 'No errors expected');
    expect(data['address'], isA<Map>(), reason: 'Data should be a Map');
  });

  test('Validates user profile data correctly', () {
    final (data, errors) = userProfileSchema.validateSync({
      'firstName': 'John',
      'lastName': 'Doe',
      'email': 'john.doe@example.com',
      'age': 30,
      'contactDetails': {
        'mobile': '+12345678901',
      },
      'address': {
        'street': '123 Main St',
        'city': 'Anytown',
        'state': 'Anystate',
        'zipCode': 12345,
        'country': {
          'name': 'Countryland',
          'code': 'CL',
          'continent': {
            'name': 'Continentia',
            'code': 'CT',
          },
        },
      },
      'employment': {
        'current': 'Current Company',
        'previous': {
          'companyName': 'Previous Company',
          'position': 'Previous Position',
          'years': 5,
        },
      },
    });
    expect(errors, isEmpty, reason: 'No validation errors expected');
    expect(
      data['address']['country']['continent']['name'],
      equals('Continentia'),
    );
  });

  test('Schema with a list Validation', () {
    final (_, errors) = schoolSchema.validateSync({
      'subject': 'Math',
      'description': 'Math description',
      'daysOfWeek': ['Monday', 'Tuesday'],
    });

    expect(errors, isEmpty, reason: 'No validation errors expected');
  });

  test('List validation error', () {
    final errors = schoolSchema.catchErrors({
      'subject': 'Math',
      'description': 'Math description',
      'daysOfWeek': ['Monday', 'Tuesday', 'Wednesday'],
    });
    expect(errors, isNotEmpty, reason: 'Validation errors expected');
  });
}
