// ignore_for_file: avoid_shadowing_type_parameters

import 'dart:convert';

import '../../../ez_validator.dart';

extension SchemaValidation<T> on EzValidator<T> {
  /// Creates an `EzValidator` that validates a `Map<String, dynamic>` object
  /// against a given `EzSchema`.
  ///
  /// This validator is intended for validating complex objects represented
  /// as maps. It uses the provided `EzSchema` to validate each key-value
  /// pair within the map. If any validation errors are found, it returns
  /// a JSON-encoded string containing the errors.
  ///
  /// Example Usage:
  /// ```
  /// final EzSchema myObjectSchema = EzSchema.shape({
  ///   "name": EzValidator<String>().required(),
  ///   "age": EzValidator<int>().min(0),
  /// });
  ///
  /// final EzValidator<Map<String, dynamic>> myObjectValidator =
  ///     EzValidator().schema<Map<String, dynamic>>(myObjectSchema);
  ///
  /// // Usage in a more complex schema
  /// final EzSchema complexSchema = EzSchema.shape({
  ///   "myObject": myObjectValidator,
  /// });
  /// ```
  ///
  /// This allows for the validation of nested objects within a larger schema.
  ///
  /// Note: The value being validated is expected to be of type `Map<String, dynamic>`.
  /// If it is not, the validator will return an error message indicating the type mismatch.

  EzValidator<T> schema<T>(EzSchema schema) =>
      EzValidator<T>().addValidation((value, [entireData]) {
        if (value is Map<String, dynamic>) {
          var errors = schema.catchErrors(value);
          if (errors.isNotEmpty) {
            return jsonEncode(errors);
          }
        } else {
          return 'Invalid type, expected Map<String, dynamic>';
        }
        return null;
      });
}
