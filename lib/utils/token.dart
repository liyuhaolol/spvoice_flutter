import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class NtpToken{
  static const _channelName = "ntpToken";
  static const _methodName = "getNtpToken";
  static MethodChannel _channel;

    static getNtpToken(String json,String rsa) async {
    var _logger = Logger(
        printer: PrettyPrinter()
    );
    String token = "";
    int a = 1;
    try{
      _channel = MethodChannel(_channelName);
      token = await _channel.invokeMethod(_methodName,[json,rsa,a]);
    } on PlatformException catch (e) {
      _logger.e("Failed to get token: '${e.message}'.");
    }
    return token;
  }
}