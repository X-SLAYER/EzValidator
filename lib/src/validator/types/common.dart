import 'package:ez_validator/src/validator/ez_validator_builder.dart';

extension CommonValidatorExtensions<T> on EzValidator<T> {
  EzValidator<T> required([String? message]) => addValidation(
        (v) => v == null || v.isNullOrEmpty
            ? message ?? EzValidator.globalLocale.required(label)
            : null,
      );

  EzValidator<T> isType(Type type, [String? message]) => addValidation(
        (v) {
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

  EzValidator<T> minLength(int minLength, [String? message]) => addValidation(
        (v) {
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

  EzValidator<T> maxLength(int maxLength, [String? message]) =>
      addValidation((v) {
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

  EzValidator<T> addMethod(bool Function(T? v) validWhen, [String? message]) =>
      addValidation(
          (v) => validWhen(v) ? null : message ?? 'Invalid Condition');
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
