#include "include/ez_validator/ez_validator_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "ez_validator_plugin.h"

void EzValidatorPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  ez_validator::EzValidatorPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
