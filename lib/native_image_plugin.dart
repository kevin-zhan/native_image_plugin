import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class NativeImagePlugin {
  static const MethodChannel _channel =
      const MethodChannel('native_image_plugin');

  static Future<Uint8List> getNativeImage(String imageName) async {
    var imageData =
        await _channel.invokeMethod("getNativeImage", {"image_name": imageName});
    return Uint8List.fromList(imageData);
  }
}