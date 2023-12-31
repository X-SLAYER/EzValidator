import 'package:ez_validator/src/validator/types/validators.dart';
import 'package:ez_validator/src/validator/ez_locale.dart';

import 'ez_validator_locale.dart';

typedef ValidationCallback<T> = dynamic Function(
  T? value, [
  Map<dynamic, dynamic>? ref,
]);

class EzValidator<T> {
  EzValidator({
    this.optional = false,
    this.defaultValue,
    this.label,
  });

  /// optional by default is `False`
  /// if optional `True` the required validation will be ignored
  final bool optional;

  /// default is used when casting produces a `null` output value
  final T? defaultValue;

  /// Overrides the key name which is used in error messages.
  final String? label;

  /// transformation function
  /// this function will be called before any validation
  /// it can be used to transform the value before validation
  /// for example: `trim` a string
  /// or `parse` a string to a `DateTime`
  /// or `cast` a `String` to `int` ....
  T Function(T)? transformationFunction;

  final List<ValidationCallback<T>> validations = [];
  static EzLocale globalLocale = const DefaultLocale();

  EzValidator<T> addValidation(ValidationCallback<T> validator) {
    validations.add(validator);
    return this;
  }

  /// set custom locale
  static void setLocale(EzLocale locale) {
    globalLocale = locale;
  }

  /// Global validators
  dynamic validate(T? value, [Map<dynamic, dynamic>? entireData]) =>
      _test(value, entireData);

  dynamic _test(T? value, [Map<dynamic, dynamic>? ref]) {
    try {
      if (transformationFunction != null && value != null) {
        value = transformationFunction!(value);
      }

      if (value == null && defaultValue != null) {
        value = defaultValue;
      }

      for (var validate in validations) {
        if (optional && value.isNullOrEmpty) {
          return null;
        }

        final result = validate(value, ref);
        if (result != null) {
          return result;
        }
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  ValidationCallback<T> build() => _test;
}
