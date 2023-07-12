import 'package:fl_kdxf_sst_rt/kdxf_speech/kdxf_plugins/utils/base_kdxf.dart';
import 'package:flutter/material.dart';
import 'kdxf_speech/kdxf_plugins/utils/sound_manage.dart';

class WsWidgetPage extends StatefulWidget {
  @override
  _WsWidgetPageState createState() => _WsWidgetPageState();
}

class _WsWidgetPageState extends State<WsWidgetPage>
    with KDXFBaseSpeechRecognitionMixin {
  @override
  void initState() {
    super.initState();
    //this is your keys of kdxf.
    setKDXFInfo("", "", "", "");
    KDXFInit();
  }

  @override
  void dispose() {
    KDXFDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('讯飞语音转文字测试'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await SoundRecord.startListening();
              updateMsg = "录音中..";
            },
            child: Text('开始录音'),
          ),
          ElevatedButton(
            onPressed: KDXFStopListening,
            child: Text('停止录音'),
          ),
          Container(
            height: 20,
          ),
          Center(child: Text(showMsg)),
        ],
      ),
    );
  }
}
