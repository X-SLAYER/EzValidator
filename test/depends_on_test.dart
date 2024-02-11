import 'package:test/test.dart';
import 'package:ez_validator/ez_validator.dart';

void main() {
  group('Schema Validation with dependsOn', () {
    final EzSchema schema = EzSchema.shape({
      "premium": EzValidator<bool>(defaultValue: false).required(),
      "stripe_account": EzValidator<String>().dependsOn(
        condition: (ref) => ref!["premium"]!,
        then: EzValidator<String>().required(),
        orElse: EzValidator<String>(optional: true),
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
}
