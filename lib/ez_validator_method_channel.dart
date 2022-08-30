import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ez_validator_platform_interface.dart';

/// An implementation of [EzValidatorPlatform] that uses method channels.
class MethodChannelEzValidator extends EzValidatorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ez_validator');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
