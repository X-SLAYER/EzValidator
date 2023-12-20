import 'package:ez_validator/src/validator/ez_validator_builder.dart';

extension DateValidatorExtensions<T> on EzValidator<T> {
  /// Checks if the value is a date
  EzValidator<T> date([String? message]) => addValidation((v, [_]) {
        if (v is DateTime) {
          return null;
        }
        if (DateTime.tryParse(v.toString()) != null) {
          return null;
        }
        return message ?? EzValidator.globalLocale.date('$v', label);
      });

  /// Checks if the value is is after [date]
  /// [message] is the message to return if the validation fails
  EzValidator<T> minDate(DateTime date, [String? message]) =>
      addValidation((v, [_]) {
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

  /// Checks if the value is is before [date]
  /// [message] is the message to return if the validation fails
  EzValidator<T> maxDate(DateTime date, [String? message]) =>
      addValidation((v, [_]) {
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
