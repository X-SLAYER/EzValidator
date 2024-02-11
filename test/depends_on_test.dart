import 'package:test/test.dart';
import 'package:ez_validator/ez_validator.dart';

import 'common/enums.dart';

void main() {
  group('Schema Validation with dependsOn', () {
    final EzSchema schema = EzSchema.shape({
      "premium": EzValidator<bool>(defaultValue: false).required(),
      "stripe_account": EzValidator<String>().dependsOn(
        condition: (ref) => ref!["premium"]!,
        then: EzValidator<String>().required(),
      ),
    });

    test('Should require stripe_account if premium is true', () {
      final errors = schema.catchErrors({
        "premium": true,
        "stripe_account": "",
      });
      expect(errors.containsKey('stripe_account'), isTrue);
    });

    test('Should not require stripe_account if premium is false', () {
      final errors = schema.catchErrors({
        "premium": false,
      });
      expect(errors.containsKey('stripe_account'), isFalse);
    });

    test(
        'Should pass validation if premium is true and stripe_account is provided',
        () {
      final errors = schema.catchErrors({
        "premium": true,
        "stripe_account": "valid_account",
      });
      expect(errors.isEmpty, isTrue);
    });
  });

  group('Car Validation Schema Tests', () {
    final EzSchema carValidationSchema = EzSchema.shape({
      "car_type": EzValidator<CarType>(defaultValue: CarType.suv).required(),
      "passangers_number": EzValidator<int>().dependsOn(
        condition: (ref) => ref!["car_type"] == CarType.suv,
        then: EzValidator<int>().required().max(6, 'Max 6 passangers'),
        orElse: EzValidator<int>().required().max(4, 'Max 4 passangers'),
      ),
    });
    test('SUV car with valid passengers number', () {
      final errors = carValidationSchema.catchErrors({
        "car_type": CarType.suv,
        "passangers_number": 5,
      });
      expect(errors.isEmpty, isTrue);
    });
    test('SUV car with too many passangers', () {
      final errors = carValidationSchema.catchErrors({
        "car_type": CarType.suv,
        "passangers_number": 7,
      });
      expect(errors['passangers_number'], equals('Max 6 passangers'));
    });
    test('Other car with too many passangers', () {
      final errors = carValidationSchema.catchErrors({
        "car_type": CarType.other,
        "passangers_number": 7,
      });
      expect(errors['passangers_number'], equals('Max 4 passangers'));
    });
    test('Other car with valid passangers', () {
      final errors = carValidationSchema.catchErrors({
        "car_type": CarType.other,
        "passangers_number": 3,
      });
      expect(errors['passangers_number'], isNull);
    });

    test('Other car with exact needed passangers', () {
      final errors = carValidationSchema.catchErrors({
        "car_type": CarType.other,
        "passangers_number": 4,
      });
      expect(errors['passangers_number'], isNull);
    });
  });
}
