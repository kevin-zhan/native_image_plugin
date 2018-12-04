import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

/// A plugin to fetch image data from platform side
///
/// You can use it to get image data in `Uint8List` format. And
/// present it through `Image.memory()`
class NativeImagePlugin {
  /// the channel to pass image name and receive image data
  static const MethodChannel _channel =
      const MethodChannel('native_image_plugin');

  /// Get image data from platform resource.
  ///
  /// @param imageName The name of the native image resource
  static Future<Uint8List> getNativeImage(String imageName) async {
    var imageData =
        await _channel.invokeMethod("getNativeImage", {"image_name": imageName});
    return Uint8List.fromList(imageData);
  }
}