import 'package:flutter/foundation.dart';

class EzSchema {
  final Map<String, String? Function(String? value)> _schema;

  /// when its true it will throw exception.
  /// when the form and schema has different keys
  final bool? identicalKeys;

  /// when it's true the form will be filled
  /// with keys from the schema with empty string.
  /// fillSchema is [True] by default
  final bool? fillSchema;

  EzSchema.shape(this._schema, {this.identicalKeys, this.fillSchema = true});

  ///validate the values you have sent and return a [Map]
  ///with errors. each error will have the key from form keys
  Map<String, String> validateSync(Map<String, dynamic> form) {
    if (identicalKeys ?? false) {
      if (!_compareKeys(form)) {
        throw Exception("value and schema must have the same keys");
      }
    }
    if (fillSchema ?? false) {
      final _schemaKeys = _schema.keys.toList();
      final _formKeys = form.keys.toList();
      for (var key in _schemaKeys) {
        if (!_formKeys.contains(key)) {
          form[key] = null;
        }
      }
    }
    Map<String, String> _errors = {};
    for (var key in form.keys) {
      late String? Function(String?)? validator;
      if (_schema.containsKey(key)) {
        validator = _schema[key];
        try {
          if (validator!(form[key]) != null) {
            _errors[key] = validator(form[key]) ?? '';
          }
        } catch (e) {
          _errors[key] = e.toString();
        }
      }
    }
    return _errors;
  }

  bool _compareKeys(Map<String, dynamic> form) {
    return (listEquals(form.keys.toList(), _schema.keys.toList()));
  }
}
