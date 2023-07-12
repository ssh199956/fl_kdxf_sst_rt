<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# fl_kdxf_sst_rt

As shown in the figure below:

Welcome to my personal website：<https://www.sshlearning.cn>

Welcome to my github and invite you to build more：<https://github.com/ssh199956>

Welcome to my personal blog：<https://blog.sshlearning.cn>

Welcome to follow my document content：<https://data.sshlearning.cn>

Welcome to the static e-commerce website made during my study：<https://shenfeng.sshlearning.cn>

## Getting started

A Flutter plugin that supports KDXF for Streaming voice dictation, suitable for Android, iOS and
other platforms.

## Usage


```dart
//'Attention, set this content first before using all content'
setKDXFInfo("", "", "", "");
```
```dart
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

```

### Property

- **time**:

```dart
time选择-vad_eos根据这个去修改
//这里我设置的是2秒钟的时间，科大讯飞默认是3秒，这个时间可以自定义的
//填充business
business['language'] = 'zh_cn';
business['domain'] = 'iat';
business['accent'] = 'mandarin';
business['ptt'] = 0;
business['vad_eos'] = 2000;
business['dwa'] = 'wpgs';
business['ptt'] = 1;
