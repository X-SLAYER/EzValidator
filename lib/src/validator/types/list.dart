import 'package:ez_validator/src/validator/ez_validator_builder.dart';

extension ListValidatorExtensions<T> on EzValidator<T> {
  EzValidator<T> listOf(Type type, [String? message]) => addValidation((v) {
        if (v is List) {
          for (var item in v) {
            if (type == Map && item is Map) {
              continue;
            }
            if (item.runtimeType != type) {
              return message ?? EzValidator.globalLocale.listOf(type, label);
            }
          }
          return null;
        }
        return 'Invalid type for list validation';
      });

  EzValidator<T> oneOf(List<T> items, [String? message]) =>
      addValidation((v) => items.contains(v)
          ? null
          : message ?? EzValidator.globalLocale.oneOf(items, '$v', label));

  EzValidator<T> notOneOf(List<T> items, [String? message]) =>
      addValidation((v) => !items.contains(v)
          ? null
          : message ?? EzValidator.globalLocale.notOneOf(items, '$v', label));
}
