import '../common/schema_value.dart';
import '../validator/ez_validator_builder.dart';

class EzSchema extends SchemaValue {
  EzSchema.shape(
    this._schema, {
    this.fillSchema = true,
    this.noUnknown = false,
  });

  final Map<String, SchemaValue> _schema;

  /// when it's true the form will be filled
  ///
  /// with keys from the schema with empty string.
  ///
  /// fillSchema is [True] by default
  final bool? fillSchema;

  /// Disallow unknown fields
  ///
  /// noUnknown is [False] by default
  final bool noUnknown;

  /// access to the values of the schema
  Map<String, SchemaValue> get schema => _schema;

  /// get the values of the schema with specific key
  SchemaValue operator [](String key) => _schema[key]!;

  /// validate the values you have sent and return a [Map]
  /// with errors. each error will have the key from form keys
  ///
  /// if there is no errors it will return an empty `Map`
  Map<dynamic, dynamic> catchErrors(Map<dynamic, dynamic> form) {
    final data = _fillSchemaIfNeeded(form);

    Map<dynamic, dynamic> errors = {};
    _schema.forEach((key, value) {
      if (value is EzValidator) {
        var error = value.build()(data[key], data);
        if (error != null) {
          errors[key] = error;
        }
      } else if (value is EzSchema) {
        var nestedErrors = value.catchErrors(data[key] ?? {});
        if (nestedErrors.isNotEmpty) {
          errors[key] = nestedErrors;
        }
      }
    });

    if (noUnknown) {
      for (var key in form.keys) {
        if (!_schema.containsKey(key)) {
          errors[key] = EzValidator.globalLocale.unknownFieldMessage;
        }
      }
    }

    return errors;
  }

  /// validate the values you have sent and return a [Map]
  ///
  /// It will return a `Map` with errors and the data
  (Map<dynamic, dynamic> data, Map<dynamic, dynamic> errors) validateSync(
    Map<dynamic, dynamic> form,
  ) {
    final data = _fillSchemaIfNeeded(form);
    final errors = catchErrors(data);
    return (data, errors);
  }

  Map<dynamic, dynamic> _fillSchemaIfNeeded(Map<dynamic, dynamic> form) {
    final data = Map<dynamic, dynamic>.from(form);

    if (fillSchema ?? false) {
      _schema.forEach((key, value) {
        if (value is EzValidator) {
          data[key] ??= value.defaultValue;
        } else if (value is EzSchema) {
          if (!form.containsKey(key) || form[key] is! Map<dynamic, dynamic>) {
            data[key] = value._populateDefaultValues();
          } else {
            data[key] =
                value._fillSchemaIfNeeded(form[key] as Map<dynamic, dynamic>);
          }
        }
      });
    }

    return data;
  }

  Map<String, dynamic> _populateDefaultValues() {
    Map<String, dynamic> defaults = {};
    _schema.forEach((key, value) {
      if (value is EzValidator) {
        defaults[key] = value.defaultValue;
      } else if (value is EzSchema) {
        defaults[key] = value._populateDefaultValues();
      }
    });
    return defaults;
  }
}
