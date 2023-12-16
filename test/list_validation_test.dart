import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('List Validators', () {
    final requiredValidator = EzValidator<List?>().required().build();
    final optionalValidator =
        EzValidator<List?>(optional: true).required().build();
    final minListValidator = EzValidator<List>().minLength(3).build();
    final maxListValidator = EzValidator<List>().maxLength(5).build();
    final betweenListValidator =
        EzValidator<List>().minLength(3).maxLength(10).build();

    test('Required', () {
      expect(requiredValidator(null), isNotNull, reason: 'null value');
      expect(requiredValidator([]), isNotNull, reason: 'empty value');
      expect(requiredValidator([1]), isNull, reason: 'not null value');
    });
    test('Optional', () {
      expect(optionalValidator(null), isNull, reason: 'null value');
      expect(optionalValidator([]), isNull, reason: 'empty value');
      expect(optionalValidator([1]), isNull, reason: 'not null value');
    });

    test('minLength Validator', () {
      expect(minListValidator([1, 2]), isNotNull, reason: 'List too short');
      expect(minListValidator([1, 2, 3]), isNull, reason: 'List long enough');
      expect(
        minListValidator([1, 2, 3, 4]),
        isNull,
        reason: 'List long enough',
      );
      expect(
        minListValidator([1, 2, 3, 4, 5]),
        isNull,
        reason: 'List long enough',
      );
      expect(
        minListValidator([1, 2, 3, 4, 5, 6]),
        isNull,
        reason: 'List long enough',
      );
    });

    test('maxLength Validator', () {
      expect(
        maxListValidator([1, 2, 3, 4, 5, 6]),
        isNotNull,
        reason: 'List too long',
      );
      expect(
        maxListValidator([1, 2, 3, 4, 5]),
        isNull,
        reason: 'List is perfect',
      );
      expect(
        maxListValidator([1, 2, 3, 4]),
        isNull,
        reason: 'List short enough',
      );
      expect(maxListValidator([1, 2, 3]), isNull, reason: 'List short enough');
      expect(maxListValidator([1, 2]), isNull, reason: 'List short enough');
      expect(maxListValidator([1]), isNull, reason: 'List short enough');
      expect(maxListValidator([]), isNull, reason: 'List short enough');
    });

    test('betweenLength Validator', () {
      expect(
        betweenListValidator([1, 2]),
        isNotNull,
        reason: 'List too short',
      );
      expect(
        betweenListValidator([1, 2, 3]),
        isNull,
        reason: 'List long enough',
      );
      expect(
        betweenListValidator([1, 2, 3, 4]),
        isNull,
        reason: 'List long enough',
      );
      expect(
        betweenListValidator([1, 2, 3, 4, 5]),
        isNull,
        reason: 'List long enough',
      );
      expect(
        betweenListValidator([1, 2, 3, 4, 5, 6]),
        isNull,
        reason: 'List long enough',
      );
      expect(
        betweenListValidator([[], [], []]),
        isNull,
        reason: 'List is enought',
      );
      expect(
        betweenListValidator([{}, {}, {}]),
        isNull,
        reason: 'List is enought',
      );
      expect(
        betweenListValidator(
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]),
        isNotNull,
        reason: 'List too long',
      );
    });

    test('listOfType Validator', () {
      final listOfInt = EzValidator<List>().listOf(int).build();
      final listOfDouble = EzValidator<List>().listOf(double).build();
      final listOfString = EzValidator<List>().listOf(String).build();
      final listOfBool = EzValidator<List>().listOf(bool).build();
      final listOfList = EzValidator<List>().listOf(List).build();
      final listOfMap = EzValidator<List>().listOf(Map).build();

      expect(
        listOfInt([1, 2, 3, 4, 5, 6]),
        isNull,
        reason: 'List of int',
      );
      expect(
        listOfDouble([1.1, 2.2, 3.3, 4.4, 5.5, 6.6]),
        isNull,
        reason: 'List of double',
      );
      expect(
        listOfString(["1", "2", "3", "4", "5", "6", 'X']),
        isNull,
        reason: 'List of String',
      );
      expect(
        listOfBool([true, false, true, false, true, false]),
        isNull,
        reason: 'List of bool',
      );
      expect(
        listOfList([[], [], []]),
        isNull,
        reason: 'List of List',
      );
      expect(
        listOfMap([
          {},
          {},
          {'X': 'X'}
        ]),
        isNull,
        reason: 'List of Map',
      );
      expect(
        listOfInt([1, 2, 3, 4, 5, "6"]),
        isNotNull,
        reason: 'List of int',
      );
      expect(
        listOfDouble([1.1, 2.2, 3.3, 4.4, 5.5, "6.6"]),
        isNotNull,
        reason: 'List of double',
      );
      expect(
        listOfString(["1", "2", "3", "4", "5", 6]),
        isNotNull,
        reason: 'List of String',
      );
      expect(
        listOfBool([true, false, true, false, true, "false"]),
        isNotNull,
        reason: 'List of bool',
      );
      expect(
        listOfList([[], [], 6]),
        isNotNull,
        reason: 'List of List',
      );
      expect(
        listOfMap(['X-SLAYER', {}, {}, 6]),
        isNotNull,
        reason: 'List of Map',
      );
    });
  });
}
