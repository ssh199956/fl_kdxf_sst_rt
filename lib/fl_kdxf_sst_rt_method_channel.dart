import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fl_kdxf_sst_rt_platform_interface.dart';

/// An implementation of [FlKdxfSstRtPlatform] that uses method channels.
class MethodChannelFlKdxfSstRt extends FlKdxfSstRtPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fl_kdxf_sst_rt');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
