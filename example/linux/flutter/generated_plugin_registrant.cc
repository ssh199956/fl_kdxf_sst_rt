//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <fl_kdxf_sst_rt/fl_kdxf_sst_rt_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) fl_kdxf_sst_rt_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlKdxfSstRtPlugin");
  fl_kdxf_sst_rt_plugin_register_with_registrar(fl_kdxf_sst_rt_registrar);
}
