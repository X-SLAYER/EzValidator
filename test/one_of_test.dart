import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('One Of Validator', () {
    final oneOfInt = EzValidator<int>().oneOf([1, 2, 3]).build();
    final oneOfString = EzValidator<String>().oneOf(['a', 'b', 'c']).build();
    final oneOfDouble = EzValidator<double>().oneOf([1.1, 2.2, 3.3]).build();
    final oneOfDate = EzValidator<DateTime>()
        .oneOf([DateTime(2000), DateTime(2023), DateTime(2024)]).build();

    test('oneOf Int Validator', () {
      expect(oneOfInt(1), isNull, reason: 'valid value');
      expect(oneOfInt(2), isNull, reason: 'valid value');
      expect(oneOfInt(3), isNull, reason: 'valid value');
      expect(oneOfInt(4), isNotNull, reason: 'Invalid value');
    });

    test('oneOf String Validator', () {
      expect(oneOfString('a'), isNull, reason: 'valid value');
      expect(oneOfString('b'), isNull, reason: 'valid value');
      expect(oneOfString('c'), isNull, reason: 'valid value');
      expect(oneOfString('d'), isNotNull, reason: 'Invalid value');
    });

    test('oneOf Double Validator', () {
      expect(oneOfDouble(1.1), isNull, reason: 'valid value');
      expect(oneOfDouble(2.2), isNull, reason: 'valid value');
      expect(oneOfDouble(3.3), isNull, reason: 'valid value');
      expect(oneOfDouble(4.4), isNotNull, reason: 'Invalid value');
    });

    test('oneOf Date Validator', () {
      expect(oneOfDate(DateTime(2000)), isNull, reason: 'valid value');
      expect(oneOfDate(DateTime(2023)), isNull, reason: 'valid value');
      expect(oneOfDate(DateTime(2024)), isNull, reason: 'valid value');
      expect(oneOfDate(DateTime(2025)), isNotNull, reason: 'Invalid value');
    });
  });
}
