import '../../../ez_validator.dart';

extension CommonValidatorExtensions<T> on EzValidator<T> {
  /// add a validation to check if the value is null or empty
  /// [message] is the message to return if the validation fails
  EzValidator<T> required([String? message]) => addValidation(
        (v, [_]) => v == null || v.isNullOrEmpty
            ? message ?? EzValidator.globalLocale.required(label)
            : null,
      );

  /// add a validation to check if the value is of type [type]
  /// [message] is the message to return if the validation fails
  EzValidator<T> isType(Type type, [String? message]) => addValidation(
        (v, [_]) {
          if (type == Map && v is Map) {
            return null;
          }
          if (v.runtimeType == double || v.runtimeType == int && type == num) {
            return null;
          }
          return v.runtimeType == type
              ? null
              : message ?? EzValidator.globalLocale.isTypeOf(type, label);
        },
      );

  /// add a validation to check if the value is less than [minLength]
  /// [message] is the message to return if the validation fails
  EzValidator<T> minLength(int minLength, [String? message]) => addValidation(
        (v, [_]) {
          if (v is String) {
            return v.length < minLength
                ? message ??
                    EzValidator.globalLocale.minLength(v, minLength, label)
                : null;
          }
          if (v is List) {
            return v.length < minLength
                ? message ??
                    EzValidator.globalLocale
                        .minLength(v.toString(), minLength, label)
                : null;
          }
          if (v is Map) {
            return v.length < minLength
                ? message ??
                    EzValidator.globalLocale
                        .minLength(v.toString(), minLength, label)
                : null;
          }
          return null;
        },
      );

  /// add a validation to check if the value is less than [maxLength]
  /// [message] is the message to return if the validation fails
  EzValidator<T> maxLength(int maxLength, [String? message]) =>
      addValidation((v, [_]) {
        if (v is String) {
          return v.length > maxLength
              ? message ??
                  EzValidator.globalLocale.maxLength(v, maxLength, label)
              : null;
        }
        if (v is List) {
          return v.length > maxLength
              ? message ??
                  EzValidator.globalLocale
                      .maxLength(v.toString(), maxLength, label)
              : null;
        }
        if (v is Map) {
          return v.length > maxLength
              ? message ??
                  EzValidator.globalLocale
                      .maxLength(v.toString(), maxLength, label)
              : null;
        }
        return null;
      });

  /// add a custom validation
  EzValidator<T> addMethod(bool Function(T? v) validWhen, [String? message]) =>
      addValidation(
          (v, [_]) => validWhen(v) ? null : message ?? 'Invalid Condition');

  /// adjust the validation based on the value of another field
  /// [key] is the name of the field to compare against
  ///
  /// [validator] is the validation to run if the condition is met
  EzValidator<T> when(ValidationCallback<T> validator) {
    return addValidation((currentFieldValue, [ref]) {
      return validator(currentFieldValue, ref);
    });
  }

  /// Transform the value before running the validation
  /// [transformFunction] is the function to run on the value
  EzValidator<T> transform(T Function(T) transformFunction) {
    transformationFunction = transformFunction;
    return this;
  }
}

extension OptionalValidation<T> on T? {
  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    }
    if (this is String) {
      return (this as String).isEmpty || (this as String).trim().isEmpty;
    }
    if (this is List) {
      return (this as List).isEmpty;
    }
    if (this is Map) {
      return (this as Map).isEmpty;
    }
    return false;
  }
}
