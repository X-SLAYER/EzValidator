import 'package:ez_validator/src/validator/ez_validator_builder.dart';

extension ListValidatorExtensions<T> on EzValidator<T> {
  /// Checks if the value is a list of [type]
  /// [message] is the message to return if the validation fails
  EzValidator<T> listOf(Type type, [String? message]) =>
      addValidation((v, [_]) {
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

  /// Checks if the value is one of [items]
  /// [message] is the message to return if the validation fails
  EzValidator<T> oneOf(List<T> items, [String? message]) =>
      addValidation((v, [_]) => items.contains(v)
          ? null
          : message ?? EzValidator.globalLocale.oneOf(items, '$v', label));

  /// Checks if the value is not one of [items]
  /// [message] is the message to return if the validation fails
  EzValidator<T> notOneOf(List<T> items, [String? message]) =>
      addValidation((v, [_]) => !items.contains(v)
          ? null
          : message ?? EzValidator.globalLocale.notOneOf(items, '$v', label));

  /// Define an array of [itemValidator] to validate each item in the array
  // ignore: avoid_shadowing_type_parameters
  EzValidator<List<T>> arrayOf<T>(EzValidator<T> itemValidator) {
    return EzValidator<List<T>>().addValidation((list, [entireData]) {
      if (list == null) {
        return null;
      }
      List<dynamic> errorsList = [];
      for (var i = 0; i < list.length; i++) {
        var item = list[i];
        var error = itemValidator.validate(item, entireData);

        if (error != null) {
          errorsList.add(error);
        }
      }
      if (errorsList.isNotEmpty) {
        return errorsList;
      }
      return null;
    });
  }
}
