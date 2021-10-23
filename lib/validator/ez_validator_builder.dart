import 'package:ez_validator/validator/ez_locale.dart';
import 'package:ez_validator/validator/regex_list.dart';

import 'ez_validator_locale.dart';

typedef StringValidationCallback = String? Function(String? value);

class EzValidator<T> {
  EzValidator({
    this.optional = false,
  }) : _locale = globalLocale;

  /// optional by default is `False`
  /// if optional `True` the required validation with be ignored
  final bool optional;
  final EzLocale _locale;
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

  EzValidator required([String? message]) => _add((v) =>
      v == null || v.trim().isEmpty ? message ?? _locale.required() : null);

  EzValidator minLength(int minLength, [String? message]) =>
      _add((v) => v!.length < minLength
          ? message ?? _locale.minLength(v, minLength)
          : null);

  EzValidator min(int min, [String? message]) => _add(
      (v) => int.parse('$v') <= min ? message ?? _locale.min('$v', min) : null);

  EzValidator max(int min, [String? message]) => _add(
      (v) => int.parse('$v') >= min ? message ?? _locale.max('$v', min) : null);

  EzValidator positive([String? message]) =>
      _add((v) => int.parse('$v') < 0 ? message ?? _locale.positive(v!) : null);

  EzValidator negative([String? message]) =>
      _add((v) => int.parse('$v') > 0 ? message ?? _locale.negative(v!) : null);

  EzValidator maxLength(int maxLength, [String? message]) =>
      _add((v) => v!.length > maxLength
          ? message ?? _locale.maxLength(v, maxLength)
          : null);

  EzValidator matches(String pattern, [String? message]) =>
      _add((v) => RegExp(pattern).hasMatch(v!)
          ? null
          : message ?? _locale.matches(pattern, v));

  EzValidator email([String? message]) => _add(
      (v) => emailRegExp.hasMatch(v!) ? null : message ?? _locale.email(v));

  EzValidator phone([String? message]) =>
      _add((v) => !anyLetterExp.hasMatch(v!) &&
              phoneRegExp.hasMatch(v.replaceAll(nonDigitsExp, ''))
          ? null
          : message ?? _locale.phoneNumber(v));

  EzValidator ip([String? message]) =>
      _add((v) => ipv4RegExp.hasMatch(v!) ? null : message ?? _locale.ip(v));

  EzValidator ipv6([String? message]) =>
      _add((v) => ipv6RegExp.hasMatch(v!) ? null : message ?? _locale.ipv6(v));

  EzValidator url([String? message]) =>
      _add((v) => urlRegExp.hasMatch(v!) ? null : message ?? _locale.url(v));

  EzValidator number([String? message]) =>
      _add((v) => digitsExp.hasMatch(v!) ? null : message ?? _locale.number(v));

  EzValidator notNumber([String? message]) => _add((v) =>
      nonDigitsExp.hasMatch(v!) ? null : message ?? _locale.notNumber(v));

  EzValidator boolean([String? message]) => _add(
      (v) => booleanExp.hasMatch(v!) ? null : message ?? _locale.boolean(v));

  EzValidator uuid([String? message]) =>
      _add((v) => uuidExp.hasMatch(v!) ? null : message ?? _locale.uuid(v));

  EzValidator lowerCase([String? message]) => _add(
      (v) => v == v!.toLowerCase() ? null : message ?? _locale.lowerCase(v));

  EzValidator date([String? message]) => _add(
        (v) => DateTime.tryParse(v ?? '') != null
            ? null
            : message ?? _locale.date(v!),
      );

  EzValidator upperCase([String? message]) => _add(
      (v) => v == v!.toUpperCase() ? null : message ?? _locale.upperCase(v));

  EzValidator oneOf(List<String?> items, [String? message]) => _add((v) =>
      items.contains(v) ? null : message ?? _locale.oneOf(items, v as String));

  EzValidator notOneOf(List<String?> items, [String? message]) =>
      _add((v) => !items.contains(v)
          ? null
          : message ?? _locale.notOneOf(items, v as String));

  EzValidator defaultTest(String message, bool Function(String? v) test) =>
      _add((v) => test(v) ? null : message);
}
