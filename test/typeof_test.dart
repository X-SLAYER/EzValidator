import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Type of Validation', () {
    final isTypeOfString = EzValidator().isType(String).build();
    final isTypeOfList = EzValidator().isType(List<int>).build();
    final isTypeOfMap = EzValidator().isType(Map).build();
    final isTypeOfInt = EzValidator().isType(int).build();
    final isTypeOfDouble = EzValidator().isType(double).build();
    final isTypeOfNum = EzValidator().isType(num).build();
    final isTypeOfDateTime = EzValidator().isType(DateTime).build();
    final isTypeOfBool = EzValidator().isType(bool).build();
    final isTypeOfNull = EzValidator().isType(Null).build();
    final isTypeOfObject = EzValidator().isType(Object).build();
    final isTypeOfListInt = EzValidator().isType(List<int>).build();
    test('IsTypeOfValidator', () {
      expect(isTypeOfString('Flutter'), isNull, reason: 'valid value');
      expect(isTypeOfString(5), isNotNull, reason: 'Invalid value');

      expect(isTypeOfList([1, 2, 3]), isNull, reason: 'valid value');
      expect(isTypeOfList('Flutter'), isNotNull, reason: 'Invalid value');

      expect(isTypeOfMap({'a': 5, 'b': 2}), isNull, reason: 'valid value');
      expect(isTypeOfMap('Flutter'), isNotNull, reason: 'Invalid value');

      expect(isTypeOfInt(5), isNull, reason: 'valid value');
      expect(isTypeOfInt('Flutter'), isNotNull, reason: 'Invalid value');

      expect(isTypeOfDouble(5.5), isNull, reason: 'valid value');
      expect(isTypeOfDouble('Flutter'), isNotNull, reason: 'Invalid value');

      expect(isTypeOfNum(5), isNull, reason: 'valid value');
      expect(isTypeOfNum('Flutter'), isNotNull, reason: 'Invalid value');

      expect(isTypeOfDateTime(DateTime(2021)), isNull, reason: 'valid value');
      expect(isTypeOfDateTime('Flutter'), isNotNull, reason: 'Invalid value');

      expect(isTypeOfBool(true), isNull, reason: 'valid value');
      expect(isTypeOfBool('Flutter'), isNotNull, reason: 'Invalid value');

      expect(isTypeOfNull(null), isNull, reason: 'valid value');
      expect(isTypeOfNull('Flutter'), isNotNull, reason: 'Invalid value');

      expect(isTypeOfObject(Object()), isNull, reason: 'valid value');
      expect(isTypeOfObject('Flutter'), isNotNull, reason: 'Invalid value');

      expect(isTypeOfListInt([1, 2, 3]), isNull, reason: 'valid value');
      expect(isTypeOfListInt([1, 2, 'Flutter']), isNotNull,
          reason: 'Invalid value');
    });
  });
}
