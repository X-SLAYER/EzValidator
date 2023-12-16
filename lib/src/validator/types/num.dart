import 'package:ez_validator/src/validator/ez_validator_builder.dart';

extension NumValidatorExtensions<T> on EzValidator<T> {
  EzValidator<T> min(num min, [String? message]) {
    return addValidation((value) {
      if (value is num) {
        return value < min
            ? message ?? EzValidator.globalLocale.min('$value', min, label)
            : null;
      }
      return 'Invalid type for min comparison';
    });
  }

  EzValidator<T> max(num max, [String? message]) => addValidation((value) {
        if (value is num) {
          return value > max
              ? message ?? EzValidator.globalLocale.max('$value', max, label)
              : null;
        }
        return 'Invalid type for min comparison';
      });

  EzValidator<T> positive([String? message]) => addValidation((value) {
        if (value is num) {
          return value < 0
              ? message ?? EzValidator.globalLocale.positive('$value', label)
              : null;
        }
        return 'Invalid type for min comparison';
      });

  EzValidator<T> negative([String? message]) => addValidation((value) {
        if (value is num) {
          return value > 0
              ? message ?? EzValidator.globalLocale.negative('$value', label)
              : null;
        }
        return 'Invalid type for min comparison';
      });

  EzValidator<T> number([String? message]) => addValidation((v) {
        if (v is num) {
          return null;
        }
        return num.tryParse(v.toString()) != null
            ? null
            : message ?? EzValidator.globalLocale.number('$v', label);
      });

  EzValidator<T> isInt([String? message]) => addValidation((v) {
        if (v is int) {
          return null;
        }

        return int.tryParse(v.toString()) != null
            ? null
            : message ?? EzValidator.globalLocale.isInt('$v', label);
      });

  EzValidator<T> isDouble([String? message]) => addValidation((v) {
        if (v is double) {
          return null;
        }

        if (v is int) {
          return message ?? EzValidator.globalLocale.isDouble('$v', label);
        }

        if (int.tryParse(v.toString()) != null) {
          return message ?? EzValidator.globalLocale.isDouble('$v', label);
        }

        return double.tryParse(v.toString()) != null
            ? null
            : message ?? EzValidator.globalLocale.isDouble('$v', label);
      });

  EzValidator<T> notNumber([String? message]) => addValidation((v) {
        if (v is num) {
          return message ?? EzValidator.globalLocale.notNumber('$v', label);
        }
        return num.tryParse(v.toString()) == null
            ? null
            : message ?? EzValidator.globalLocale.notNumber('$v', label);
      });
}
