import 'package:ez_validator/validator/regex_list.dart';

import 'form_validator_locale.dart';
import 'local.dart';

typedef StringValidationCallback = String? Function(String? value);

typedef Action<T> = Function(T builder);

class EzValidator {
  EzValidator({
    String? localeName,
    this.optional = false,
    FormValidatorLocale? locale = const LocaleEn(),
    this.requiredMessage,
  }) : _locale = locale as FormValidatorLocale {
    if (!optional) required(requiredMessage);
  }

  final bool optional;
  final String? requiredMessage;
  final FormValidatorLocale _locale;
  final List<StringValidationCallback> validations = [];

  EzValidator reset() {
    validations.clear();
    if (optional != true) {
      required(requiredMessage);
    }
    return this;
  }

  EzValidator _add(StringValidationCallback validator) {
    validations.add(validator);
    return this;
  }

  String? test(String? value) {
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

  StringValidationCallback build() => test;

  EzValidator required([String? message]) => _add(
      (v) => v == null || v.isEmpty ? message ?? _locale.required() : null);

  EzValidator minLength(int minLength, [String? message]) =>
      _add((v) => v!.length < minLength
          ? message ?? _locale.minLength(v, minLength)
          : null);

  EzValidator min(int min, [String? message]) => _add(
      (v) => int.parse('$v') <= min ? message ?? _locale.min('$v', min) : null);

  EzValidator max(int min, [String? message]) => _add(
      (v) => int.parse('$v') >= min ? message ?? _locale.max('$v', min) : null);

  EzValidator maxLength(int maxLength, [String? message]) =>
      _add((v) => v!.length > maxLength
          ? message ?? _locale.maxLength(v, maxLength)
          : null);

  EzValidator matches(RegExp regExp, String message) =>
      _add((v) => regExp.hasMatch(v!) ? null : message);

  EzValidator email([String? message]) => _add(
      (v) => emailRegExp.hasMatch(v!) ? null : message ?? _locale.email(v));

  EzValidator phone([String? message]) => _add((v) => !anyLetter.hasMatch(v!) &&
          phoneRegExp.hasMatch(v.replaceAll(nonDigitsExp, ''))
      ? null
      : message ?? _locale.phoneNumber(v));

  EzValidator ip([String? message]) =>
      _add((v) => ipv4RegExp.hasMatch(v!) ? null : message ?? _locale.ip(v));

  EzValidator ipv6([String? message]) =>
      _add((v) => ipv6RegExp.hasMatch(v!) ? null : message ?? _locale.ipv6(v));

  EzValidator url([String? message]) =>
      _add((v) => urlRegExp.hasMatch(v!) ? null : message ?? _locale.url(v));

  EzValidator boolean([String? message]) => _add(
      (v) => booleanExp.hasMatch(v!) ? null : message ?? _locale.boolean(v));

  EzValidator uuid([String? message]) =>
      _add((v) => uuidExp.hasMatch(v!) ? null : message ?? _locale.uuid(v));

  EzValidator lowerCase([String? message]) => _add(
      (v) => v == v!.toLowerCase() ? null : message ?? _locale.lowerCase(v));

  EzValidator upperCase([String? message]) => _add(
      (v) => v == v!.toUpperCase() ? null : message ?? _locale.upperCase(v));

  EzValidator oneOf(List<String?> items, [String? message]) => _add((v) =>
      items.contains(v) ? null : message ?? _locale.oneOf(items, v as String));

  EzValidator notOneOf(List<String?> items, [String? message]) => _add((v) =>
      !items.contains(v) ? null : message ?? _locale.oneOf(items, v as String));

  EzValidator defaultTest(String message, bool Function(String?) test) =>
      _add((v) => test(v) ? null : message);
}
