#import "NativeImagePlugin.h"

@implementation NativeImagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"native_image_plugin"
            binaryMessenger:[registrar messenger]];
  NativeImagePlugin* instance = [[NativeImagePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getNativeImage" isEqualToString:call.method]) {
      NSDictionary* args = (NSDictionary *)call.arguments;
      NSString* imageName = [args objectForKey:@"image_name"];
      if (!imageName) {
          result([FlutterError errorWithCode:@"nativeImage" message:@"Empty image name" details: nil]);
          return;
      }
    
      UIImage* image = [UIImage imageNamed:imageName];
      if (image == nil) {
          result([FlutterError errorWithCode:@"nativeImage" message:@"No such image" details: nil]);
          return;
      }
      NSData* imageData = UIImagePNGRepresentation(image);
      result(imageData);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
