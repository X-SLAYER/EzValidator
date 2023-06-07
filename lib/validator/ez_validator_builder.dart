import 'package:ez_validator/validator/ez_locale.dart';
import 'package:ez_validator/validator/regex_list.dart';

import 'ez_validator_locale.dart';

typedef StringValidationCallback = String? Function(String? value);

class EzValidator {
  EzValidator({
    this.optional = false,
    this.defaultValue,
    this.label,
  });

  /// optional by default is `False`
  /// if optional `True` the required validation will be ignored
  final bool optional;

  /// default is used when casting produces a `null` output value
  final dynamic defaultValue;

  /// Overrides the key name which is used in error messages.
  final String? label;

  final List<StringValidationCallback> validations = [];
  static EzLocale globalLocale = const DefaultLocale();

  EzValidator _add(StringValidationCallback validator) {
    validations.add(validator);
    return this;
  }

  /// set custom locale
  static void setLocale(EzLocale locale) {
    globalLocale = locale;
  }

  String? _test(String? value) {
    if (value == null && defaultValue != null) {
      value = defaultValue.toString();
    }

    for (var validate in validations) {
      if (optional && (value == null || value.isEmpty)) {
        return null;
      }

      final result = validate(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  StringValidationCallback build() => _test;

  EzValidator required([String? message]) =>
      _add((v) => v == null || v.trim().isEmpty
          ? message ?? globalLocale.required(label)
          : null);

  EzValidator minLength(int minLength, [String? message]) =>
      _add((v) => v!.length < minLength
          ? message ?? globalLocale.minLength(v, minLength, label)
          : null);

  EzValidator min(int min, [String? message]) =>
      _add((v) => int.parse('$v') < min
          ? message ?? globalLocale.min('$v', min, label)
          : null);

  EzValidator max(int min, [String? message]) =>
      _add((v) => int.parse('$v') > min
          ? message ?? globalLocale.max('$v', min, label)
          : null);

  EzValidator positive([String? message]) => _add((v) =>
      int.parse('$v') < 0 ? message ?? globalLocale.positive(v!, label) : null);

  EzValidator negative([String? message]) => _add((v) =>
      int.parse('$v') > 0 ? message ?? globalLocale.negative(v!, label) : null);

  EzValidator maxLength(int maxLength, [String? message]) =>
      _add((v) => v!.length > maxLength
          ? message ?? globalLocale.maxLength(v, maxLength, label)
          : null);

  EzValidator matches(String pattern, [String? message]) =>
      _add((v) => RegExp(pattern).hasMatch(v!)
          ? null
          : message ?? globalLocale.matches(pattern, v, label));

  EzValidator email([String? message]) => _add((v) =>
      emailRegExp.hasMatch(v!) ? null : message ?? globalLocale.email(v));

  EzValidator phone([String? message]) =>
      _add((v) => !anyLetterExp.hasMatch(v!) &&
              phoneRegExp.hasMatch(v.replaceAll(nonDigitsExp, ''))
          ? null
          : message ?? globalLocale.phoneNumber(v, label));

  EzValidator ip([String? message]) => _add((v) =>
      ipv4RegExp.hasMatch(v!) ? null : message ?? globalLocale.ip(v, label));

  EzValidator ipv6([String? message]) => _add((v) =>
      ipv6RegExp.hasMatch(v!) ? null : message ?? globalLocale.ipv6(v, label));

  EzValidator url([String? message]) => _add((v) =>
      urlRegExp.hasMatch(v!) ? null : message ?? globalLocale.url(v, label));

  EzValidator number([String? message]) => _add((v) =>
      digitsExp.hasMatch(v!) ? null : message ?? globalLocale.number(v, label));

  EzValidator notNumber([String? message]) =>
      _add((v) => nonDigitsExp.hasMatch(v!)
          ? null
          : message ?? globalLocale.notNumber(v, label));

  EzValidator boolean([String? message]) => _add((v) => booleanExp.hasMatch(v!)
      ? null
      : message ?? globalLocale.boolean(v, label));

  EzValidator uuid([String? message]) => _add((v) =>
      uuidExp.hasMatch(v!) ? null : message ?? globalLocale.uuid(v, label));

  EzValidator lowerCase([String? message]) => _add((v) => v == v!.toLowerCase()
      ? null
      : message ?? globalLocale.lowerCase(v, label));

  EzValidator upperCase([String? message]) => _add((v) => v == v!.toUpperCase()
      ? null
      : message ?? globalLocale.upperCase(v, label));

  EzValidator oneOf(List<String?> items, [String? message]) =>
      _add((v) => items.contains(
            v,
          )
              ? null
              : message ?? globalLocale.oneOf(items, v as String, label));

  EzValidator notOneOf(List<String?> items, [String? message]) =>
      _add((v) => !items.contains(v)
          ? null
          : message ?? globalLocale.notOneOf(items, v as String, label));

  EzValidator defaultTest(String message, bool Function(String? v) test) =>
      _add((v) => test(v) ? null : message);

  EzValidator date([String? message]) => _add(
        (v) => DateTime.tryParse(v ?? '') != null
            ? null
            : message ?? globalLocale.date(v!, label),
      );
}
