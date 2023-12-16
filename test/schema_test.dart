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
          .maxDate(DateTime(2025)),
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

  group('Schema Validation', () {
    test('Check schema results', () {
      final errors = ezSchema.validateSync({
        'email': 'example@domain.com',
        'password': '12345678',
        'date': DateTime.now(),
      });

      expect(errors, isA<Map>(), reason: 'Errors should be a Map');
      expect(errors, isEmpty, reason: 'No validation errors expected');
    });
  });

  test('Check schema results for an array', () {
    final errors = arraySchema.validateSync({
      'nodes': ["XXX"]
    });
    print(errors);

    expect(errors, isA<Map>(), reason: 'Errors should be a Map');
    expect(
      errors.containsKey('nodes'),
      isTrue,
      reason: 'nodes validation error expected',
    );
  });

  test('Person Schema Validation', () {
    final errors = personSchema.validateSync({
      'firstName': 'John',
      'nickName': 'Doe',
      'sex': 'F',
      'email': 'iheb@pixelium.tn',
      'birthDate': DateTime(2000),
    });
    expect(errors, isA<Map>(), reason: 'Errors should be a Map');
    expect(errors, isEmpty, reason: 'No errors expected');
  });
}
