import 'package:ez_validator/src/validator/ez_validator_builder.dart';

/// A class to hold multiple validators that form a union
///
/// This class is used to validate a value against multiple validators.
class UnionValidator extends EzValidator<dynamic> {
  final List<EzValidator> validators;

  UnionValidator(this.validators) : super() {
    assert(
      validators.isNotEmpty,
      'Union validator must have at least one validator',
    );
    addValidation(_unionValidation);
  }

  dynamic _unionValidation(dynamic value, [Map<dynamic, dynamic>? ref]) {
    List<String> errors = [];

    // Try each validator
    for (var validator in validators) {
      try {
        final error = validator.validate(value, ref);
        if (error == null) {
          return null;
        }
        errors.add(error.toString());
      } catch (e) {
        errors.add(e.toString());
      }
    }
    return errors.join(", ");
  }
}

/// Extension to add the union method to EzValidator
///
/// method for composing "OR" types.
extension UnionValidatorExtension on EzValidator {
  EzValidator<dynamic> union(List<EzValidator> validators) {
    return UnionValidator(validators);
  }
}
