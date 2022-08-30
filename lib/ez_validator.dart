
import 'ez_validator_platform_interface.dart';

class EzValidator {
  Future<String?> getPlatformVersion() {
    return EzValidatorPlatform.instance.getPlatformVersion();
  }
}
