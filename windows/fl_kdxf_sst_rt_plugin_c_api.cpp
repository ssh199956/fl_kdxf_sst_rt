#include "include/fl_kdxf_sst_rt/fl_kdxf_sst_rt_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "fl_kdxf_sst_rt_plugin.h"

void FlKdxfSstRtPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  fl_kdxf_sst_rt::FlKdxfSstRtPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
