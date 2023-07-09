import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

/// 创建日期: 2021/5/27
/// 作者: lijianbin
/// 描述:

final df = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
///如果项目中使用了国际化,请约束DateFormat使用英文样式
// final df = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'","en");

///获取鉴权地址
String getAuthUrl(String host, String apiKey, String apiSecret) {
  var date = df.format(DateTime.now());
  final signatureOrigin = 'host: $host\ndate: $date\nGET /v2/iat HTTP/1.1';
  final signature = _hmacSha256Base64(signatureOrigin, apiSecret);
  final authorizationOrigin =
      'api_key="$apiKey", algorithm="hmac-sha256", headers="host date request-line", signature="$signature"';
  final authorization = base64.encode(authorizationOrigin.codeUnits);
  //对日期进行uri编码
  date = Uri.encodeComponent(date);
  final url =
      'wss://$host/v2/iat?authorization=$authorization&date=$date&host=$host';
  return url;
}

///hmacSha256加密后再进行base64编码
String _hmacSha256Base64(String message, String secret) {
  List<int> messageBytes = utf8.encode(message);
  List<int> secretBytes = utf8.encode(secret);
  Hmac hmac = Hmac(sha256, secretBytes);
  Digest digest = hmac.convert(messageBytes);
  return base64.encode(digest.bytes);
}
