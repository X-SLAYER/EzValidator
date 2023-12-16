import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Number Validators', () {
    final requiredValidator = EzValidator<num?>().required().build();
    final optionalValidator =
        EzValidator<num?>(optional: true).required().build();
    final minValidator = EzValidator<num>().min(10).build();
    final maxValidator = EzValidator<num>().max(20).build();
    final betweenValidator = EzValidator<num>().min(10).max(20).build();
    final positiveValidator = EzValidator<num>().positive().build();
    final negativeValidator = EzValidator<num>().negative().build();
    final numberValidator = EzValidator().number().build();
    final notNumberValidator = EzValidator().notNumber().build();
    final isIntValidator = EzValidator().isInt().build();
    final isDoubleValidator = EzValidator().isDouble().build();

    test('optional Validator', () {
      expect(optionalValidator(null), isNull, reason: 'null value');
      expect(optionalValidator(15), isNull, reason: 'not null value');
    });
    test('required Validator', () {
      expect(requiredValidator(null), isNotNull, reason: 'null value');
      expect(requiredValidator(15), isNull, reason: 'not null value');
    });
    test('min Validator', () {
      expect(minValidator(5), isNotNull, reason: 'Number less than min');
      expect(minValidator(15), isNull, reason: 'Number greater than min');
    });
    test('max Validator', () {
      expect(maxValidator(25), isNotNull, reason: 'Number greater than max');
      expect(maxValidator(15), isNull, reason: 'Number less than max');
    });

    test('between Validator', () {
      expect(betweenValidator(5), isNotNull, reason: 'Number less than min');
      expect(betweenValidator(25), isNotNull,
          reason: 'Number greater than max');
      expect(betweenValidator(15), isNull,
          reason: 'Number between min and max');
    });

    test('positive Validator', () {
      expect(positiveValidator(-15), isNotNull, reason: 'Negative int');
      expect(positiveValidator(-1.5), isNotNull, reason: 'Negative double');
      expect(positiveValidator(15), isNull, reason: 'Positive int');
      expect(positiveValidator(1.5), isNull, reason: 'Positive double');
    });
    test('negative Validator', () {
      expect(negativeValidator(15), isNotNull, reason: 'Positive int');
      expect(negativeValidator(1.5), isNotNull, reason: 'Positive double');
      expect(negativeValidator(-15), isNull, reason: 'Negative int');
      expect(negativeValidator(-1.5), isNull, reason: 'Negative double');
    });
    test('number Validator', () {
      expect(numberValidator(15), isNull, reason: 'Number as int');
      expect(numberValidator(15.5), isNull, reason: 'Number as double');
      expect(numberValidator(-15), isNull, reason: 'Number as N int');
      expect(numberValidator(-1.1), isNull, reason: 'Number as N double');
      expect(numberValidator("10"), isNull, reason: 'String as number int');
      expect(numberValidator("1.1"), isNull, reason: 'String as P double');
      expect(numberValidator("-1.1"), isNull, reason: 'String as N double');
      expect(numberValidator("0"), isNull, reason: 'String as number');
      expect(numberValidator("X"), isNotNull, reason: 'String as N double');
    });
    test('notNumber Validator', () {
      expect(notNumberValidator(15), isNotNull, reason: 'Number as int');
      expect(notNumberValidator(15.5), isNotNull, reason: 'Number as double');
      expect(notNumberValidator(-15), isNotNull, reason: 'Number as N int');
      expect(notNumberValidator(-1.1), isNotNull, reason: 'Number as N double');
      expect(notNumberValidator("10"), isNotNull,
          reason: 'String as number int');
      expect(notNumberValidator("1.1"), isNotNull,
          reason: 'String as P double');
      expect(notNumberValidator("-1.1"), isNotNull,
          reason: 'String as N double');
      expect(notNumberValidator("0"), isNotNull, reason: 'String as number');
      expect(notNumberValidator("X"), isNull, reason: 'String as N double');
    });

    test('isInt Validator', () {
      expect(isIntValidator(15), isNull, reason: 'Number as int');
      expect(isIntValidator(15.5), isNotNull, reason: 'Number as double');
      expect(isIntValidator(-15), isNull, reason: 'Number as N int');
      expect(isIntValidator(-1.1), isNotNull, reason: 'Number as N double');
      expect(isIntValidator("10"), isNull, reason: 'String as number int');
      expect(isIntValidator("1.1"), isNotNull, reason: 'String as P double');
      expect(isIntValidator("-1.1"), isNotNull, reason: 'String as N double');
      expect(isIntValidator("0"), isNull, reason: 'String as number');
      expect(isIntValidator("X"), isNotNull, reason: 'String as N double');
    });

    test('isDouble Validator', () {
      expect(isDoubleValidator(15), isNotNull, reason: 'Number as int');
      expect(isDoubleValidator(15.5), isNull, reason: 'Number as double');
      expect(isDoubleValidator(-15), isNotNull, reason: 'Number as N int');
      expect(isDoubleValidator(-1.1), isNull, reason: 'Number as N double');
      expect(
        isDoubleValidator("10"),
        isNotNull,
        reason: 'String as number int',
      );
      expect(isDoubleValidator("1.1"), isNull, reason: 'String as P double');
      expect(isDoubleValidator("-1.1"), isNull, reason: 'String as N double');
      expect(isDoubleValidator("0"), isNotNull, reason: 'String as number');
      expect(isDoubleValidator("X"), isNotNull, reason: 'String as N double');
    });
  });
}
