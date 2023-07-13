import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class NtpToken{
  static const _channelName = "ntpToken";
  static const _methodName = "getNtpToken";
  static MethodChannel _channel = MethodChannel(_channelName);

    static getNtpToken(String json,String rsa) async {
    var _logger = Logger(
        printer: PrettyPrinter()
    );
    String token = "";
    int a = 1;
    try{
      _channel = MethodChannel(_channelName);
      Map<String,Object> arguments = Map();
      arguments['json'] = json;
      arguments['rsa'] = rsa;
      arguments['a'] = a;
      token = await _channel.invokeMethod(_methodName,arguments);
    } on PlatformException catch (e) {
      _logger.e("Failed to get token: '${e.message}'.");
    }
    return token;
  }
}