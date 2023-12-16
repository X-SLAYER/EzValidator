import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Not one Of Validator', () {
    final notOneOfInt = EzValidator<int>().notOneOf([1, 2, 3]).build();
    final notOneOfString =
        EzValidator<String>().notOneOf(['a', 'b', 'c']).build();
    final notOneOfDouble =
        EzValidator<double>().notOneOf([1.1, 2.2, 3.3]).build();
    final notOneOfDate = EzValidator<DateTime>()
        .notOneOf([DateTime(2000), DateTime(2023), DateTime(2024)]).build();

    test('notOneOf Int Validator', () {
      expect(notOneOfInt(1), isNotNull, reason: 'Invalid value');
      expect(notOneOfInt(2), isNotNull, reason: 'Invalid value');
      expect(notOneOfInt(3), isNotNull, reason: 'Invalid value');
      expect(notOneOfInt(4), isNull, reason: 'valid value');
    });

    test('notOneOf String Validator', () {
      expect(notOneOfString('a'), isNotNull, reason: 'Invalid value');
      expect(notOneOfString('b'), isNotNull, reason: 'Invalid value');
      expect(notOneOfString('c'), isNotNull, reason: 'Invalid value');
      expect(notOneOfString('d'), isNull, reason: 'valid value');
    });

    test('notOneOf Double Validator', () {
      expect(notOneOfDouble(1.1), isNotNull, reason: 'Invalid value');
      expect(notOneOfDouble(2.2), isNotNull, reason: 'Invalid value');
      expect(notOneOfDouble(3.3), isNotNull, reason: 'Invalid value');
      expect(notOneOfDouble(4.4), isNull, reason: 'valid value');
    });

    test('notOneOf Date Validator', () {
      expect(notOneOfDate(DateTime(2000)), isNotNull, reason: 'Invalid value');
      expect(notOneOfDate(DateTime(2023)), isNotNull, reason: 'Invalid value');
      expect(notOneOfDate(DateTime(2024)), isNotNull, reason: 'Invalid value');
      expect(notOneOfDate(DateTime(2025)), isNull, reason: 'valid value');
    });
  });
}
