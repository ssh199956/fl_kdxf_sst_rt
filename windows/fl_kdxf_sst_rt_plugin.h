#ifndef FLUTTER_PLUGIN_FL_KDXF_SST_RT_PLUGIN_H_
#define FLUTTER_PLUGIN_FL_KDXF_SST_RT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace fl_kdxf_sst_rt {

class FlKdxfSstRtPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlKdxfSstRtPlugin();

  virtual ~FlKdxfSstRtPlugin();

  // Disallow copy and assign.
  FlKdxfSstRtPlugin(const FlKdxfSstRtPlugin&) = delete;
  FlKdxfSstRtPlugin& operator=(const FlKdxfSstRtPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace fl_kdxf_sst_rt

#endif  // FLUTTER_PLUGIN_FL_KDXF_SST_RT_PLUGIN_H_
