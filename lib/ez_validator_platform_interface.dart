import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ez_validator_method_channel.dart';

abstract class EzValidatorPlatform extends PlatformInterface {
  /// Constructs a EzValidatorPlatform.
  EzValidatorPlatform() : super(token: _token);

  static final Object _token = Object();

  static EzValidatorPlatform _instance = MethodChannelEzValidator();

  /// The default instance of [EzValidatorPlatform] to use.
  ///
  /// Defaults to [MethodChannelEzValidator].
  static EzValidatorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EzValidatorPlatform] when
  /// they register themselves.
  static set instance(EzValidatorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
