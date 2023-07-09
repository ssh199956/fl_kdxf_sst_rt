import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound/public/tau.dart';
import 'package:permission_handler/permission_handler.dart';

/// 创建日期: 2023/6/25
/// 作者: suoshuaihong
/// 描述:
class SoundRecord {
  static bool _isRecording = false;

  static FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  static StreamSubscription? _audioSubscription;
  static List<Uint8List> _currentSamples = [];
  static StreamController<FoodData>? recordingDataController;
  static StreamController<FoodData>? recordingDataController1;

  ///初始化
  static init() async {
    if (recordingDataController?.isClosed == false) {
      await recordingDataController?.sink?.close();
      await recordingDataController?.close();
    }
    recordingDataController = StreamController<FoodData>();
    await _audioSubscription?.cancel();
    // _audioSubscription = recordingDataController?.stream.listen((event) {
    //   // print('_currentSamples: $data');
    //   _currentSamples.add(event.data!);
    // });
    recordingDataController1 = recordingDataController;
    // 初始化录音
    await _recorder.openRecorder();
    // await _recorder.initialize();
  }

  ///销毁
  static dispose() async {
    if (recordingDataController?.isClosed == false) {
      await recordingDataController?.sink.close();
      await recordingDataController?.close();
      recordingDataController=null;
    }

    await _audioSubscription?.cancel();
    await _recorder.stopRecorder();
    _currentSamples.clear();
    _isRecording = false;
  }

  ///开始录音
  static Future<bool> startListening() async {
    //授权
    if (Platform.isAndroid &&
        !await Permission.microphone.request().isGranted) {
      return false;
    }
    //清空缓存
    _currentSamples.clear();
    if (_isRecording) return false;
    //开始录音
    await _recorder.startRecorder(
      codec: Codec.pcm16,
      toStream: recordingDataController?.sink,
      numChannels: 1,
      sampleRate: 16000,
    );
    _isRecording = true;
    return true;
  }

  static StreamController<FoodData>? getStream(){
    return recordingDataController1;
  }

  static Future<bool> stopListening() async {
    if (!_isRecording) return false;
    await _recorder.stopRecorder();
    _isRecording = false;
    return true;
  }

  static Future<List<int>> currentSamples() async {
    List<int> list = [];
    _currentSamples.forEach((element) {
      list.addAll(element);
    });
    return list;
  }

  static List<int> currentSamples1() {
    List<int> list = [];
    _currentSamples.forEach((element) {
      list.addAll(element);
    });
    return list;
  }

  static void clear() {
    _currentSamples=[];
  }
}
