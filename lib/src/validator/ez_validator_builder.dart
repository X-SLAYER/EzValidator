import 'package:ez_validator/src/validator/types/validators.dart';
import 'package:ez_validator/src/validator/ez_locale.dart';

import '../common/schema_value.dart';
import 'ez_validator_locale.dart';

typedef ValidationCallback<T> = dynamic Function(
  T? value, [
  Map<dynamic, dynamic>? ref,
]);

class EzValidator<T> extends SchemaValue {
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

  /// Validates and returns the transformed value
  /// Returns the transformed value if validation succeeds, otherwise throws with error message
  T? validateAndTransform(T? value, [Map<dynamic, dynamic>? entireData]) {
    final error = _test(value, entireData);
    if (error != null) {
      throw Exception(error);
    }

    // Apply transformation
    if (transformationFunction != null && value != null) {
      value = transformationFunction!(value);
    }

    if (value == null && defaultValue != null) {
      return defaultValue;
    }

    return value;
  }

  /// Builds a function that validates and returns transformed value or error
  /// Returns transformed value on success, error string on failure
  dynamic Function(T?, [Map<dynamic, dynamic>?]) _buildWithTransform() {
    return (T? value, [Map<dynamic, dynamic>? ref]) {
      final error = _test(value, ref);
      if (error != null) {
        return error;
      }

      // Apply transformation
      if (transformationFunction != null && value != null) {
        value = transformationFunction!(value);
      }

      if (value == null && defaultValue != null) {
        return defaultValue;
      }

      return value;
    };
  }

  ValidationCallback<T> build({bool applyTransform = false}) {
    if (applyTransform) {
      return _buildWithTransform();
    }
    return _test;
  }

  /// Helper method to apply transformation to a value
  /// Returns the transformed value or the original if no transformation is defined
  dynamic applyTransformation(dynamic value) {
    if (transformationFunction != null && value != null) {
      return transformationFunction!(value as T);
    }
    if (value == null && defaultValue != null) {
      return defaultValue;
    }
    return value;
  }

  /// Check if this validator has a transformation function
  bool get hasTransformation => transformationFunction != null;
}
