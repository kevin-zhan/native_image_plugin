import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:native_image_plugin/native_image_plugin.dart';
import 'dart:typed_data';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List imageData;

  @override
  void initState() {
    super.initState();
    loadNativeImage();
  }

  loadNativeImage() async {
    var data;
    try {
      data = await NativeImagePlugin.getNativeImage("go_pre");
    } catch (exp) {
      print((exp as PlatformException).message);
      return;
    }

    setState(() {
      imageData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(

            children: <Widget>[
              Image(),
              Text('Image from natvie'),
              imageData == null ? Container() : Container(
                width: 500,
                height: 500,
                child: Image.memory(imageData),
              )
            ],
          ),
        ),
      ),
    );
  }
}
