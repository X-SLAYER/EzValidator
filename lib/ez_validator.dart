library ez_validator;

import 'package:ez_validator/src/validator/ez_validator_builder.dart';

export 'package:ez_validator/src/schemas/ez_schema.dart';
export 'package:ez_validator/src/validator/ez_validator_builder.dart';
export 'package:ez_validator/src/validator/ez_validator_locale.dart';
export 'package:ez_validator/src/validator/types/validators.dart';

/// Type alias for shorter, less verbose API
typedef Ez<T> = EzValidator<T>;
