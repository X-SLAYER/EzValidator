import 'package:ez_validator/src/validator/ez_validator_builder.dart';

import '../regex_list.dart';

extension StringValidatorExtensions<T> on EzValidator<T> {
  EzValidator<T> matches(RegExp reg, [String? message]) =>
      addValidation((value) {
        if (value is String) {
          return reg.hasMatch(value)
              ? null
              : message ??
                  EzValidator.globalLocale.matches(reg.pattern, value, label);
        }
        return 'Invalid type for pattern matching';
      });

  EzValidator<T> email([String? message]) => addValidation((v) {
        if (v is String) {
          return emailRegExp.hasMatch(v)
              ? null
              : message ?? EzValidator.globalLocale.email(v, label);
        }
        return 'Invalid type for email validation';
      });

  EzValidator<T> phone([String? message]) => addValidation((v) {
        if (v is String) {
          return phoneRegExp.hasMatch(v)
              ? null
              : message ?? EzValidator.globalLocale.phoneNumber(v, label);
        }
        return 'Invalid type for phone validation';
      });

  EzValidator<T> ip([String? message]) => addValidation((v) {
        if (v is String) {
          return ipv4RegExp.hasMatch(v)
              ? null
              : message ?? EzValidator.globalLocale.ip(v, label);
        }
        return 'Invalid type for ip validation';
      });

  EzValidator<T> ipv6([String? message]) => addValidation((v) {
        if (v is String) {
          return ipv6RegExp.hasMatch(v)
              ? null
              : message ?? EzValidator.globalLocale.ipv6(v, label);
        }
        return 'Invalid type for ipv6 validation';
      });

  EzValidator<T> url([String? message]) => addValidation((v) {
        if (v is String) {
          return urlRegExp.hasMatch(v)
              ? null
              : message ?? EzValidator.globalLocale.url(v, label);
        }
        return 'Invalid type for url validation';
      });

  EzValidator<T> uuid([String? message]) => addValidation((v) {
        if (v is String) {
          return uuidExp.hasMatch(v)
              ? null
              : message ?? EzValidator.globalLocale.uuid(v, label);
        }
        return 'Invalid type for uuid validation';
      });

  EzValidator<T> lowerCase([String? message]) => addValidation((v) {
        if (v is String) {
          return v == v.toLowerCase()
              ? null
              : message ?? EzValidator.globalLocale.lowerCase(v, label);
        }
        return 'Invalid type for lowerCase validation';
      });

  EzValidator<T> upperCase([String? message]) => addValidation((v) {
        if (v is String) {
          return v == v.toUpperCase()
              ? null
              : message ?? EzValidator.globalLocale.upperCase(v, label);
        }
        return 'Invalid type for lowerCase validation';
      });
}
