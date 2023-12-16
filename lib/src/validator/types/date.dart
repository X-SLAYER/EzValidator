import 'package:ez_validator/src/validator/ez_validator_builder.dart';

extension DateValidatorExtensions<T> on EzValidator<T> {
  EzValidator<T> date([String? message]) => addValidation((v) {
        if (v is DateTime) {
          return null;
        }
        if (DateTime.tryParse(v.toString()) != null) {
          return null;
        }
        return message ?? EzValidator.globalLocale.date('$v', label);
      });

  EzValidator<T> minDate(DateTime date, [String? message]) =>
      addValidation((v) {
        if (DateTime.tryParse(v.toString()) == null) {
          return message ?? EzValidator.globalLocale.date('$v', label);
        }
        if (v is! DateTime) {
          return message ?? EzValidator.globalLocale.date('$v', label);
        }
        return v.isAfter(date) || v.isAtSameMomentAs(date)
            ? null
            : message ?? EzValidator.globalLocale.dateMin('$v', date, label);
      });

  EzValidator<T> maxDate(DateTime date, [String? message]) =>
      addValidation((v) {
        if (DateTime.tryParse(v.toString()) == null) {
          return message ?? EzValidator.globalLocale.date('$v', label);
        }
        if (v is! DateTime) {
          return message ?? EzValidator.globalLocale.date('$v', label);
        }
        return v.isBefore(date) || v.isAtSameMomentAs(date)
            ? null
            : message ?? EzValidator.globalLocale.dateMin('$v', date, label);
      });
}
