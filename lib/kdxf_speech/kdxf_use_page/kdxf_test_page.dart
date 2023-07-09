import 'package:flutter/material.dart';
import '../kdxf_plugins/utils/base_kdxf.dart';

class MyHomeXFPage extends StatefulWidget {
  const MyHomeXFPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomeXFPageState createState() => _MyHomeXFPageState();
}

class _MyHomeXFPageState extends State<MyHomeXFPage>
    with KDXFBaseSpeechRecognitionMixin {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    KDXFInit();
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    KDXFDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('语音听写'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              showMsg ?? "",
              style: const TextStyle(color: Colors.red, fontSize: 20),
            ),
            ElevatedButton(
              onPressed: KDXFStartListening,
              child: const Text('开始录音'),
            ),
            ElevatedButton(
              onPressed: KDXFStopListening,
              child: const Text('停止录音'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text(showMsg ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
