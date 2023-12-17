import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Boolean Validation', () {
    final checkBooleanValidator = EzValidator<bool>().boolean().build();

    test('checkBooleanValidator', () {
      expect(checkBooleanValidator(true), isNull, reason: 'valid value');
      expect(checkBooleanValidator(false), isNull, reason: 'valid value');
      expect(
        checkBooleanValidator(null),
        isNotNull,
        reason: 'Invalid value',
      );
      expect(
        checkBooleanValidator(1 + 1 == 2),
        isNull,
        reason: 'Invalid value',
      );
    });
  });
}
