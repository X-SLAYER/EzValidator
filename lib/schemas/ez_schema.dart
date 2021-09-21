import 'package:flutter/foundation.dart';

class EzSchema {
  final Map<String, String? Function(String? value)> _schema;

  /// when its true it will throw exception
  /// when the form and schema has different keys
  final bool? identicalKeys;

  EzSchema.shape(this._schema, {this.identicalKeys});

  ///validate the values you have sent and return a [Map]
  ///with errors. each error will have the key from form keys
  Map<String, String> validateSync(Map<String, dynamic> form) {
    if (identicalKeys ?? false) {
      if (!_compareKeys(form)) {
        throw Exception("value and schema must have the same keys");
      }
    }
    Map<String, String> _errors = {};
    form.forEach((key, value) {
      late String? Function(String?)? validator;
      if (_schema.containsKey(key)) {
        validator = _schema[key];
        if (validator!(form[key]) != null) {
          _errors[key] = validator(form[key]) ?? '';
        }
      }
    });
    return _errors;
  }

  bool _compareKeys(Map<String, dynamic> form) {
    return (listEquals(form.keys.toList(), _schema.keys.toList()));
  }
}
