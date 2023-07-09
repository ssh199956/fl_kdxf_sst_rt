import 'package:flutter_test/flutter_test.dart';
import 'package:fl_kdxf_sst_rt/fl_kdxf_sst_rt.dart';
import 'package:fl_kdxf_sst_rt/fl_kdxf_sst_rt_platform_interface.dart';
import 'package:fl_kdxf_sst_rt/fl_kdxf_sst_rt_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlKdxfSstRtPlatform
    with MockPlatformInterfaceMixin
    implements FlKdxfSstRtPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlKdxfSstRtPlatform initialPlatform = FlKdxfSstRtPlatform.instance;

  test('$MethodChannelFlKdxfSstRt is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlKdxfSstRt>());
  });

  test('getPlatformVersion', () async {
    FlKdxfSstRt flKdxfSstRtPlugin = FlKdxfSstRt();
    MockFlKdxfSstRtPlatform fakePlatform = MockFlKdxfSstRtPlatform();
    FlKdxfSstRtPlatform.instance = fakePlatform;

    expect(await flKdxfSstRtPlugin.getPlatformVersion(), '42');
  });
}
