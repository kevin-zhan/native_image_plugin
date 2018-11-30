package tech.zymx.nativeimageplugin;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.text.TextUtils;

import java.io.ByteArrayOutputStream;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** NativeImagePlugin */
public class NativeImagePlugin implements MethodCallHandler {
  private Registrar mRegistrar;

  NativeImagePlugin(Registrar registrar) {
    mRegistrar = registrar;
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "native_image_plugin");
    channel.setMethodCallHandler(new NativeImagePlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } if(call.method.equals("getNativeImage")) {
      if (!call.hasArgument("image_name")) {
        result.error("NativeImage", "Empty image name", null);
        return;
      }
      String imageName = call.argument("image_name");
      if (TextUtils.isEmpty(imageName)) {
        result.error("NativeImage", "Empty image name", null);
        return;
      }
      int redId = mRegistrar.activeContext().getResources().getIdentifier(imageName, "drawable", mRegistrar.activity().getPackageName());
      if (redId == 0) {
        result.error("NativeImage", "No such image", null);
        return;
      }
      Bitmap bitmap = BitmapFactory.decodeResource(mRegistrar.activeContext().getResources(), redId);
      ByteArrayOutputStream stream = new ByteArrayOutputStream(bitmap.getByteCount());
      bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
      byte[] byteArray = stream.toByteArray();
      bitmap.recycle();
      result.success(byteArray);
    } else {
      result.notImplemented();
    }
  }
}
