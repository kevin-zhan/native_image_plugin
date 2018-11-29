import 'dart:async';

import 'package:flutter/services.dart';

class NativeImagePlugin {
  static const MethodChannel _channel =
      const MethodChannel('native_image_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
