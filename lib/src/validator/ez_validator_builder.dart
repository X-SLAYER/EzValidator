import 'package:ez_validator/src/validator/extensions.dart';
import 'package:ez_validator/src/validator/ez_locale.dart';
import 'package:ez_validator/src/validator/regex_list.dart';

import 'ez_validator_locale.dart';

typedef ValidationCallback<T> = String? Function(T? value);

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

  final List<ValidationCallback<T>> validations = [];
  static EzLocale globalLocale = const DefaultLocale();

  EzValidator<T> _add(ValidationCallback<T> validator) {
    validations.add(validator);
    return this;
  }

  /// set custom locale
  static void setLocale(EzLocale locale) {
    globalLocale = locale;
  }

  String? _test(T? value) {
    if (value == null && defaultValue != null) {
      value = defaultValue;
    }

    for (var validate in validations) {
      if (optional && value.isNullOrEmpty) {
        return null;
      }

      final result = validate(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  ValidationCallback<T> build() => _test;

  EzValidator<T> required([String? message]) => _add(
        (v) => v == null || v.isNullOrEmpty
            ? message ?? globalLocale.required(label)
            : null,
      );

  EzValidator<T> isType(Type type, [String? message]) => _add(
        (v) {
          if (type == Map && v is Map) {
            return null;
          }
          if (v.runtimeType == double || v.runtimeType == int && type == num) {
            return null;
          }
          return v.runtimeType == type
              ? null
              : message ?? globalLocale.isTypeOf(type, label);
        },
      );

  EzValidator<T> minLength(int minLength, [String? message]) => _add(
        (v) {
          if (v is String) {
            return v.length < minLength
                ? message ?? globalLocale.minLength(v, minLength, label)
                : null;
          }
          if (v is List) {
            return v.length < minLength
                ? message ??
                    globalLocale.minLength(v.toString(), minLength, label)
                : null;
          }
          if (v is Map) {
            return v.length < minLength
                ? message ??
                    globalLocale.minLength(v.toString(), minLength, label)
                : null;
          }
          return null;
        },
      );

  EzValidator<T> min(num min, [String? message]) {
    return _add((value) {
      if (value is num) {
        return value < min
            ? message ?? globalLocale.min('$value', min, label)
            : null;
      }
      return 'Invalid type for min comparison';
    });
  }

  EzValidator<T> max(num max, [String? message]) => _add((value) {
        if (value is num) {
          return value > max
              ? message ?? globalLocale.max('$value', max, label)
              : null;
        }
        return 'Invalid type for min comparison';
      });

  EzValidator<T> positive([String? message]) => _add((value) {
        if (value is num) {
          return value < 0
              ? message ?? globalLocale.positive('$value', label)
              : null;
        }
        return 'Invalid type for min comparison';
      });

  EzValidator<T> negative([String? message]) => _add((value) {
        if (value is num) {
          return value > 0
              ? message ?? globalLocale.negative('$value', label)
              : null;
        }
        return 'Invalid type for min comparison';
      });

  EzValidator<T> maxLength(int maxLength, [String? message]) => _add((v) {
        if (v is String) {
          return v.length > maxLength
              ? message ?? globalLocale.maxLength(v, maxLength, label)
              : null;
        }
        if (v is List) {
          return v.length > maxLength
              ? message ??
                  globalLocale.maxLength(v.toString(), maxLength, label)
              : null;
        }
        if (v is Map) {
          return v.length > maxLength
              ? message ??
                  globalLocale.maxLength(v.toString(), maxLength, label)
              : null;
        }
        return null;
      });

  EzValidator<T> listOf(Type type, [String? message]) => _add((v) {
        if (v is List) {
          for (var item in v) {
            if (type == Map && item is Map) {
              continue;
            }
            if (item.runtimeType != type) {
              return message ?? globalLocale.listOf(type, label);
            }
          }
          return null;
        }
        return 'Invalid type for list validation';
      });

  EzValidator<T> matches(RegExp reg, [String? message]) => _add((value) {
        if (value is String) {
          return reg.hasMatch(value)
              ? null
              : message ?? globalLocale.matches(reg.pattern, value, label);
        }
        return 'Invalid type for pattern matching';
      });

  EzValidator<T> email([String? message]) => _add((v) {
        if (v is String) {
          return emailRegExp.hasMatch(v)
              ? null
              : message ?? globalLocale.email(v, label);
        }
        return 'Invalid type for email validation';
      });

  EzValidator<T> phone([String? message]) => _add((v) {
        if (v is String) {
          return phoneRegExp.hasMatch(v)
              ? null
              : message ?? globalLocale.phoneNumber(v, label);
        }
        return 'Invalid type for phone validation';
      });

  EzValidator<T> ip([String? message]) => _add((v) {
        if (v is String) {
          return ipv4RegExp.hasMatch(v)
              ? null
              : message ?? globalLocale.ip(v, label);
        }
        return 'Invalid type for ip validation';
      });

  EzValidator<T> ipv6([String? message]) => _add((v) {
        if (v is String) {
          return ipv6RegExp.hasMatch(v)
              ? null
              : message ?? globalLocale.ipv6(v, label);
        }
        return 'Invalid type for ipv6 validation';
      });

  EzValidator<T> url([String? message]) => _add((v) {
        if (v is String) {
          return urlRegExp.hasMatch(v)
              ? null
              : message ?? globalLocale.url(v, label);
        }
        return 'Invalid type for url validation';
      });

  EzValidator<T> number([String? message]) => _add((v) {
        if (v is num) {
          return null;
        }
        return num.tryParse(v.toString()) != null
            ? null
            : message ?? globalLocale.number('$v', label);
      });

  EzValidator<T> isInt([String? message]) => _add((v) {
        if (v is int) {
          return null;
        }

        return int.tryParse(v.toString()) != null
            ? null
            : message ?? globalLocale.isInt('$v', label);
      });

  EzValidator<T> isDouble([String? message]) => _add((v) {
        if (v is double) {
          return null;
        }

        if (v is int) {
          return message ?? globalLocale.isDouble('$v', label);
        }

        if (int.tryParse(v.toString()) != null) {
          return message ?? globalLocale.isDouble('$v', label);
        }

        return double.tryParse(v.toString()) != null
            ? null
            : message ?? globalLocale.isDouble('$v', label);
      });

  EzValidator<T> notNumber([String? message]) => _add((v) {
        if (v is num) {
          return message ?? globalLocale.notNumber('$v', label);
        }
        return num.tryParse(v.toString()) == null
            ? null
            : message ?? globalLocale.notNumber('$v', label);
      });

  EzValidator<T> boolean([String? message]) => _add(
      (v) => v is bool ? null : message ?? globalLocale.boolean('$v', label));

  EzValidator<T> uuid([String? message]) => _add((v) {
        if (v is String) {
          return uuidExp.hasMatch(v)
              ? null
              : message ?? globalLocale.uuid(v, label);
        }
        return 'Invalid type for uuid validation';
      });

  EzValidator<T> lowerCase([String? message]) => _add((v) {
        if (v is String) {
          return v == v.toLowerCase()
              ? null
              : message ?? globalLocale.lowerCase(v, label);
        }
        return 'Invalid type for lowerCase validation';
      });

  EzValidator<T> upperCase([String? message]) => _add((v) {
        if (v is String) {
          return v == v.toUpperCase()
              ? null
              : message ?? globalLocale.upperCase(v, label);
        }
        return 'Invalid type for lowerCase validation';
      });

  EzValidator<T> oneOf(List<T> items, [String? message]) =>
      _add((v) => items.contains(v)
          ? null
          : message ?? globalLocale.oneOf(items, '$v', label));

  EzValidator<T> notOneOf(List<T> items, [String? message]) =>
      _add((v) => !items.contains(v)
          ? null
          : message ?? globalLocale.notOneOf(items, '$v', label));

  EzValidator<T> addMethod(bool Function(T? v) validWhen, [String? message]) =>
      _add((v) => validWhen(v) ? null : message ?? 'Invalid Condition');

  EzValidator<T> date([String? message]) => _add((v) {
        if (v is DateTime) {
          return null;
        }
        if (DateTime.tryParse(v.toString()) != null) {
          return null;
        }
        return message ?? globalLocale.date('$v', label);
      });

  EzValidator<T> minDate(DateTime date, [String? message]) => _add((v) {
        if (DateTime.tryParse(v.toString()) == null) {
          return message ?? globalLocale.date('$v', label);
        }
        if (v is! DateTime) {
          return message ?? globalLocale.date('$v', label);
        }
        return v.isAfter(date) || v.isAtSameMomentAs(date)
            ? null
            : message ?? globalLocale.dateMin('$v', date, label);
      });

  EzValidator<T> maxDate(DateTime date, [String? message]) => _add((v) {
        if (DateTime.tryParse(v.toString()) == null) {
          return message ?? globalLocale.date('$v', label);
        }
        if (v is! DateTime) {
          return message ?? globalLocale.date('$v', label);
        }
        return v.isBefore(date) || v.isAtSameMomentAs(date)
            ? null
            : message ?? globalLocale.dateMin('$v', date, label);
      });
}
