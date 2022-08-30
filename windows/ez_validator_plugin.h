#ifndef FLUTTER_PLUGIN_EZ_VALIDATOR_PLUGIN_H_
#define FLUTTER_PLUGIN_EZ_VALIDATOR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace ez_validator {

class EzValidatorPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  EzValidatorPlugin();

  virtual ~EzValidatorPlugin();

  // Disallow copy and assign.
  EzValidatorPlugin(const EzValidatorPlugin&) = delete;
  EzValidatorPlugin& operator=(const EzValidatorPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace ez_validator

#endif  // FLUTTER_PLUGIN_EZ_VALIDATOR_PLUGIN_H_
