import 'package:ez_validator/src/validator/ez_validator_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Date Validators', () {
    final requiredValidator = EzValidator<DateTime?>().required().build();
    final optionalValidator =
        EzValidator<DateTime?>(optional: true).required().build();
    final dateValidator = EzValidator<DateTime>().date().build();
    final minDateValidator =
        EzValidator<DateTime>().minDate(DateTime(2000)).build();
    final maxDateValidator =
        EzValidator<DateTime>().maxDate(DateTime(2023)).build();
    final stringDateValidator = EzValidator<String>().date().build();

    test('optional Validator', () {
      expect(optionalValidator(null), isNull, reason: 'null value');
      expect(optionalValidator(DateTime.now()), isNull,
          reason: 'not null value');
    });

    test('required Validator', () {
      expect(requiredValidator(null), isNotNull, reason: 'null value');
      expect(
        requiredValidator(DateTime.now()),
        isNull,
        reason: 'not null value',
      );
    });

    test('date Validator', () {
      expect(dateValidator(DateTime.now()), isNull, reason: 'valid date');
      expect(dateValidator(DateTime(2000)), isNull, reason: 'valid date');
      expect(dateValidator(DateTime(2023).add(Duration.zero)), isNull,
          reason: 'valid date');
      expect(
        dateValidator(DateTime.tryParse('XXXX')),
        isNotNull,
        reason: 'Invalid date',
      );
    });

    test('Min Date Validator', () {
      expect(minDateValidator(DateTime(2000)), isNull, reason: 'valid date');
      expect(minDateValidator(DateTime(2023).add(Duration.zero)), isNull,
          reason: 'valid date');
      expect(minDateValidator(DateTime(1999)), isNotNull,
          reason: 'Invalid date');
    });
    test('Max Date Validator', () {
      expect(maxDateValidator(DateTime(2000)), isNull, reason: 'valid date');
      expect(maxDateValidator(DateTime(2023).add(Duration.zero)), isNull,
          reason: 'valid date');
      expect(maxDateValidator(DateTime(2024)), isNotNull,
          reason: 'Invalid date');
    });

    test('String Text validator', () {
      expect(stringDateValidator('2021'), isNotNull, reason: 'Invalid date');
      expect(stringDateValidator('XXXXXX'), isNotNull, reason: 'Invalid date');
      expect(stringDateValidator('2021-10-10 10:10:10'), isNull,
          reason: 'valid date');
      expect(stringDateValidator('2021-10-10 10:10:10.10'), isNull,
          reason: 'valid date');
      expect(stringDateValidator('2021-10-10 10:10:10.10Z'), isNull,
          reason: 'valid date');
      expect(stringDateValidator('2021-10-10 10:10:10.10+01:00'), isNull,
          reason: 'valid date');
      expect(stringDateValidator('2021-10-10 10:10:10.10-01:00'), isNull,
          reason: 'valid date');
      expect(stringDateValidator('2021-10-10 10:10:10.10+0100'), isNull,
          reason: 'valid date');
      expect(stringDateValidator('2021-10-10 10:10:10.10-0100'), isNull,
          reason: 'valid date');
      expect(stringDateValidator('2021-10-10 10:10:10.10+01'), isNull,
          reason: 'valid date');
    });
  });
}
