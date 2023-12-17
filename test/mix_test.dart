import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Mixt Validation', () {
    final checkDashValidator = EzValidator<String>()
        .addMethod((v) => v!.contains('-'), 'Invalid String')
        .build();
    final checkResultValidator =
        EzValidator<num>().addMethod((v) => v! + 10 == 15).build();
    final checkDateValidator =
        EzValidator<DateTime>().addMethod((v) => v!.year == 2021).build();
    final checkListValidator =
        EzValidator<List<int>>().addMethod((v) => v![1] == 5).build();
    final checkMapValidator =
        EzValidator<Map<String, int>>().addMethod((v) => v!['a'] == 5).build();
    final checkJson = EzValidator<Map<String, dynamic>>()
        .addMethod((v) => v?['foo'] == 'bar')
        .addMethod((v) => v?['bar'] == "Flutter")
        .addMethod((v) => v?['items'][0] == 'a')
        .build();

    test('checkDashValidator', () {
      expect(checkDashValidator('2021-10-10'), isNull, reason: 'valid value');
      expect(checkDashValidator('20211010'), isNotNull,
          reason: 'Invalid value');
    });

    test('checkResultValidator', () {
      expect(checkResultValidator(5), isNull, reason: 'valid value');
      expect(checkResultValidator(4), isNotNull, reason: 'Invalid value');
    });

    test('checkDateValidator', () {
      expect(checkDateValidator(DateTime(2021)), isNull, reason: 'valid value');
      expect(checkDateValidator(DateTime(2020)), isNotNull,
          reason: 'Invalid value');
    });

    test('checkListValidator', () {
      expect(checkListValidator([1, 5, 3]), isNull, reason: 'valid value');
      expect(checkListValidator([1, 2, 3]), isNotNull, reason: 'Invalid value');
    });

    test('checkMapValidator', () {
      expect(
        checkMapValidator({'a': 5, 'b': 2}),
        isNull,
        reason: 'valid value',
      );
      expect(
        checkMapValidator({'a': 2, 'b': 2}),
        isNotNull,
        reason: 'Invalid value',
      );
    });

    test('checkMixValidator', () {
      expect(
        checkJson({
          'foo': 'bar',
          'bar': 'Flutter',
          'items': ["a", "b", "c"]
        }),
        isNull,
        reason: 'valid JSON',
      );
      expect(
        checkJson({
          'foo': 'bar',
          'bar': 'Dart',
          'items': ["a", "b", "c"]
        }),
        isNotNull,
        reason: 'Invalid JSON',
      );
    });
  });
}
