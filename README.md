# native_image_plugin

It's a simple flutter plugin to get image data from native side.  
The plugin is not made for pure Flutter project, but for the mix project.  
When we add flutter as a module to an existing project, we need to use previous icons sometimes. It's not unwise to add repeat icon to flutter again, 
cause that may make the larger apk/ipa even more larger.  
Since Flutter has provided Platform Channel to transform data with native platform. We can use the tech to transform image 
data from native platform to Flutter.

## Getting Started
You can use the plugin to get platform image data.
```dart
Future<Uint8List> loadImage(String imageName) async {
  var imageData = await NativeImagePlugin.getNativeImage(imageName);
  return imageData;
}
```
And use the ```Image.memory(imageData)```, you can present the image on your Flutter view.