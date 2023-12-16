import 'package:ez_validator/src/validator/ez_validator_builder.dart';

extension BooleanValidatorExtensions<T> on EzValidator<T> {
  EzValidator<T> boolean([String? message]) => addValidation((v) => v is bool
      ? null
      : message ?? EzValidator.globalLocale.boolean('$v', label));
}
