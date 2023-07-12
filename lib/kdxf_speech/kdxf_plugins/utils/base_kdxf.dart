import 'dart:async';
import 'package:fl_kdxf_sst_rt/kdxf_speech/kdxf_plugins/utils/sound_manage.dart';
import 'package:fl_kdxf_sst_rt/kdxf_speech/kdxf_plugins/utils/xf_manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

//this is your base plugin for kdxf
const host = '';
const appId = '';
const apiKey = '';
const apiSecret = '';

mixin KDXFBaseSpeechRecognitionMixin<T extends StatefulWidget> on State<T> {
  String _msg = '开始问我问题吧！';
  XfManage? _xf;
  bool isStarting = false;

  //callback firstly
  void setKDXFInfo(
      String host, String appId, String appKey, String apiSecret) {
    host = host;
    appId = appId;
    appKey = appKey;
    apiSecret = apiSecret;
  }

  get isCanSpeak => !isStarting;

  get showMsg => _msg;

  set updateMsg(String value) {
    setState(() {
      _msg = value;
    });
  }

  void KDXFInit() {
    checkPermission();
    SoundRecord.init();
    KDXFStartListening();
  }

  /// 获取/判断权限
  Future<bool> checkPermission() async {
    final status = await Permission.microphone.status;
    if (status.isDenied) {
      // 无权限，则请求权限
      PermissionStatus requestStatus = await Permission.microphone.request();
      return requestStatus != PermissionStatus.granted;
    } else {
      return true;
    }
  }

  void KDXFDispose() {
    _xf?.close();
    _msg = "";
    SoundRecord.dispose();
    isStarting = false;
    _msg = '开始问我问题吧！';
  }

  void KDXFStartListening() async {
    isStarting = true;
    await SoundRecord.startListening();
    startConnect();
  }

  void KDXFStopListening() async {
    _xf?.sendEndMessage();
    Future.delayed(Duration(milliseconds: 50), () {
      KDXFDispose();
    });
  }

  startConnect() async {
    setState(() {
      _msg = '';
    });
    _xf = XfManage.connect(
      host,
      apiKey,
      apiSecret,
      appId,
      await SoundRecord.currentSamples(),
      (msg, {bool isEnd = false}) {
        setState(() {
          _msg = '$msg';
        });
        if (isEnd) {
          send(_msg);
          isStarting = false;
        }
      },
    );
  }

  send(String msg) {
    if (msg.length > 0 && msg != "?" && msg != "。") {
      sendMessage();
      KDXFDispose();
    }
  }

  sendMessage() {
    //you can white your logic
  }
}

mixin KDXFBaseSpeechRecognitionBlueMixin {
  String _msg = '开始问我问题吧！';
  XfManage? _xf;
  bool isStarting = false;

  get isCanSpeak => !isStarting;

  get showMsg => _msg;

  set updateMsg(String value) {
    _msg = value;
  }

  void KDXFInit() {
    checkPermission();
    SoundRecord.init();
    KDXFStartListening();
  }

  /// 获取/判断权限
  Future<bool> checkPermission() async {
    final status = await Permission.microphone.status;
    if (status.isDenied) {
      // 无权限，则请求权限
      PermissionStatus requestStatus = await Permission.microphone.request();
      return requestStatus != PermissionStatus.granted;
    } else {
      return true;
    }
  }

  void KDXFDispose() {
    _xf?.close();
    _msg = "";
    SoundRecord.dispose();
    isStarting = false;
  }

  void KDXFStartListening() async {
    isStarting = true;
    await SoundRecord.startListening();
    startConnect();
  }

  void KDXFStopListening() async {
    Future.delayed(Duration(milliseconds: 50), () {
      KDXFDispose();
    });
  }

  startConnect() async {
    _msg = '';

    _xf = XfManage.connect(
      host,
      apiKey,
      apiSecret,
      appId,
      await SoundRecord.currentSamples(),
      (msg, {bool isEnd = false}) {
        _msg = '$msg';
        if (isEnd) {
          send(_msg);
          isStarting = false;
        }
      },
    );
  }

  send(String msg) {
    if (msg.length > 0 && msg != "?" && msg != "。") {
      sendMessage();
      KDXFDispose();
    }
  }

  sendMessage() {
    //you can white your logic
  }
}
