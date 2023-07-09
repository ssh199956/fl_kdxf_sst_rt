
import '../generated/json/base/json_convert_content.dart';

class ResponseData with JsonConvert<ResponseData> {
  int? code;
  String? message;
  String? sid;
  Data? data;
}

class Data with JsonConvert<Data> {
  Result? result;
  int? status;
}

class Result with JsonConvert<Result> {
  int? bg;
  int? ed;
  String? pgs;
  List<Ws>? ws;
  List<int>? rg;
  int? sn;
  bool? ls;

  Message getMessage() {
    StringBuffer sb = StringBuffer();
    if (this.ws != null && this.ws!.isNotEmpty) {
      for (Ws? ws in this.ws!) {
        sb.write(ws!.cw![0].w);
      }
    }

    Message msg = Message();
    msg.sn = this.sn;
    msg.pgs = this.pgs;
    msg.rg = this.rg;
    msg.text = sb.toString();
    return msg;
  }
}

class Ws with JsonConvert<Ws> {
  int? bg;
  List<Cw>? cw;
}

class Cw with JsonConvert<Cw> {
  int? sc;
  String? w;
}

class Message {
  //结果序列号
  int? sn = 1;

  //开启wpgs会有此字段,apd表示追加,rpl表示前面部分替换
  String? pgs = '';

  //开启wpgs会有此字段,部分替换范围,假设值为[2,5]，则代表要替换的是第2次到第5次返回的结果
  List<int>? rg = [];

  //文本
  String? text = '';

  //删除标记,被替换了
  bool? deleted = false;
}
