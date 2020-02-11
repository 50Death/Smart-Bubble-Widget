import 'dart:async';

import 'package:flutter/services.dart';

class SmartBubble {
  static const MethodChannel _channel =
      const MethodChannel('smart_bubble');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
