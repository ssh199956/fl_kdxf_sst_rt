import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:fl_kdxf_sst_rt/kdxf_speech/kdxf_plugins/utils/sound_manage.dart';
import 'package:fl_kdxf_sst_rt/kdxf_speech/kdxf_plugins/utils/xf_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

import '../bean/response_data_entity.dart';
import '../generated/json/response_data_entity_helper.dart';
import 'base_kdxf.dart';

/// 创建日期: 2023/6/28
/// 作者: suoshuaihong
/// 描述:
class XfManage with KDXFBaseSpeechRecognitionBlueMixin {
  static const frameSize = 1280;
  static const int intervel = 40;
  static const statusFirstFrame = 0;
  static const statusContinueFrame = 1;
  static const statusLastFrame = 2;

  final String _host;
  final String _appId;
  final String _apiKey;
  final String _apiSecret;
  final Decoder _decoder = Decoder();
  IOWebSocketChannel? _channel;
  int _status = statusFirstFrame;

  // Timer? timer;

  // DateTime _start;
  // DateTime _end;

  ///关闭连接
  close() {
    log('关闭连接');
    _channel?.sink.close();
  }

  int lastIndex = 0;

  /// 创建连接
  /// data 需要转化的音频的字节数组
  /// listen 转化完成后的回调
  XfManage.connect(this._host, this._apiKey, this._apiSecret, this._appId,
      List<int> data, void Function(String msg, {bool isEnd}) listen) {
    log('创建连接');
    _channel?.sink.close();
    _channel =
        IOWebSocketChannel.connect(getAuthUrl(_host, _apiKey, _apiSecret));
    //创建监听
    _channel?.stream.listen((event) {
      if (kDebugMode) {
        print("收到数据$event");
      }
      _onEvent(event, listen);
    });

    SoundRecord.getStream()?.stream.listen((event) {
      translate(event.data!.toList());
    });
    if (kDebugMode) {
      print("当前数据长度${SoundRecord.currentSamples1().length}");
    }
  }

  void sendEndMessage() {
    //第一帧和中间帧
    _send('', 2);
  }

  void _onEvent(dynamic data, void Function(String msg, {bool isEnd}) listen) {
    Map<String, dynamic> map = json.decode(data);
    final resp = ResponseData();
    responseDataFromJson(resp, map);

    //识别失败
    if (resp.code != 0) {
      log('code:${resp.code} error:${resp.message} sid:${resp.sid}');
      return;
    }
    if (resp.data != null) {
      //中间识别结果
      if (resp.data?.result != null) {
        final msg = resp.data?.result?.getMessage();
        if (msg != null) {
          _decoder.decode(msg);
        }
        log('中间识别结果:$_decoder');
        listen(_decoder.toString());
      }

      //说明数据全部返回完毕，可以关闭连接，释放资源
      if (resp.data?.status == 2) {
        // _end = DateTime.now();
        // log('总共耗时:${_end.difference(_start).inMilliseconds}');
        log('最终识别结果:$_decoder');
        listen(_decoder.toString(), isEnd: true);
        _decoder.discard();
        KDXFStopListening();
      }
    }
  }

  ///语音转文字
  translate(List<int> bytes) {
    // _start = DateTime.now();
    if (bytes is! Uint8List) {
      bytes = Uint8List.fromList(bytes);
    }
    int count = 0;
    final l = bytes.length % frameSize;
    if (l > 0) {
      count = (bytes.length / frameSize + 1).toInt();
    } else {
      count = bytes.length ~/ frameSize;
    }
    log('count = $count');
    for (int i = 0; i < count; i++) {
      List<int> len;
      if (i == count - 1) {
        len = bytes.sublist(i * frameSize);
      } else {
        len = bytes.sublist(i * frameSize, (i + 1) * frameSize);
      }
      String msg;
      if (len.isEmpty) {
        msg = '';
      } else {
        msg = base64.encode(len);
      }

      //第一帧和中间帧
      Future.delayed(const Duration(milliseconds: intervel), () {
        _send(msg, _status);
      });
    }
  }

  ///向服务器发送数据
  void _send(String msg, int status) {
    switch (status) {
      case statusFirstFrame: // 第一帧音频status = 0
        Map frame = {};
        Map business = {}; //第一帧必须发送
        Map common = {}; //第一帧必须发送
        Map data = {}; //每一帧都要发送

        //填充common
        common['app_id'] = _appId;
        //填充business
        business['language'] = 'zh_cn';
        business['domain'] = 'iat';
        business['accent'] = 'mandarin';
        business['ptt'] = 0;
        business['vad_eos'] = 2000;
        business['dwa'] = 'wpgs';
        business['ptt'] = 1;

        //填充data
        data['status'] = statusFirstFrame;
        data['format'] = 'audio/L16;rate=16000';
        data['encoding'] = 'raw';
        data['audio'] = msg;
        //填充frame
        frame['common'] = common;
        frame['business'] = business;
        frame['data'] = data;
        _sendMessage(json.encode(frame));
        _status = statusContinueFrame; // 发送完第一帧改变status 为 1
        log('send first');
        break;

      case statusContinueFrame: //中间帧status = 1
        Map frame1 = {};
        Map data1 = {};
        data1['status'] = statusContinueFrame;
        data1['format'] = 'audio/L16;rate=16000';
        data1['encoding'] = 'raw';
        data1['audio'] = msg;
        frame1['data'] = data1;
        _sendMessage(json.encode(frame1));
        log('send continue');
        break;

      case statusLastFrame: // 最后一帧音频status = 2 ，标志音频发送结束
        Map frame2 = {};
        Map data2 = {};
        data2['status'] = statusLastFrame;
        data2['format'] = 'audio/L16;rate=16000';
        data2['encoding'] = 'raw';
        data2['audio'] = '';
        frame2['data'] = data2;
        _sendMessage(json.encode(frame2));
        log('send last');
        _status = statusFirstFrame;
        log('所有数据都已发送');
        break;
    }
  }

  void _sendMessage(dynamic data) {
    if (_channel?.closeCode != null) return;
    _channel?.sink?.add(data);
  }
}

///解析返回数据，仅供参考
class Decoder {
  List<Message> msgs = [];

  ///解码
  void decode(Message msg) {
    //替换前面部分结果
    if ("rpl" == msg.pgs) {
      for (int i = msg.rg![0] - 1; i <= msg.rg![1] - 1; i++) {
        msgs[i].deleted = true;
      }
    }
    msgs.add(msg);
  }

  @override
  toString() {
    StringBuffer sb = StringBuffer();
    for (Message msg in msgs) {
      if (!msg.deleted!) {
        sb.write(msg.text);
      }
    }
    return sb.toString();
  }

  ///丢弃
  void discard() {
    msgs.clear();
  }
}

bool isDebug = true;

///日志
log(dynamic msg) {
  if (isDebug) {
    if (kDebugMode) {
      print('$msg');
    }
  }
}
