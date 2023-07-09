import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fl_kdxf_sst_rt_method_channel.dart';

abstract class FlKdxfSstRtPlatform extends PlatformInterface {
  /// Constructs a FlKdxfSstRtPlatform.
  FlKdxfSstRtPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlKdxfSstRtPlatform _instance = MethodChannelFlKdxfSstRt();

  /// The default instance of [FlKdxfSstRtPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlKdxfSstRt].
  static FlKdxfSstRtPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlKdxfSstRtPlatform] when
  /// they register themselves.
  static set instance(FlKdxfSstRtPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
