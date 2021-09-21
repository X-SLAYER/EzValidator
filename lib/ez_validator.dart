
import 'dart:async';

import 'package:flutter/services.dart';

class EzValidator {
  static const MethodChannel _channel = MethodChannel('ez_validator');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
