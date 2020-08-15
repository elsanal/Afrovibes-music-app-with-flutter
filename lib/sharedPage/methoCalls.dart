import 'package:flutter/services.dart';


class methodCalls{

  static const MethodChannel _channel = const MethodChannel('calls');

  static Future<int> getSessionId()async{
    int sessionId;

    try{
      final int result = await _channel.invokeMethod('getSessionID');
      sessionId = result;
    } on PlatformException catch(e){
      sessionId = null;
    }
    return sessionId;
  }

  static playSong()async{
    _channel.invokeMethod('playSong');
  }

}