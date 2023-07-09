
import 'fl_kdxf_sst_rt_platform_interface.dart';

class FlKdxfSstRt {
  Future<String?> getPlatformVersion() {
    return FlKdxfSstRtPlatform.instance.getPlatformVersion();
  }
}
