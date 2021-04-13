import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  int _androidVersion = 0;
  @override
  Future<void> initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    int _sdkLevel = 0;
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo deviceData =
        await DeviceInfoPlugin().androidInfo;
        _sdkLevel = deviceData.version.sdkInt;
      }
    } on PlatformException {
      _sdkLevel = 0;
    }
    setState(() {
      _androidVersion = _sdkLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return /*AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        *//*statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,*//*
        systemNavigationBarColor: (_androidVersion < 30 && _androidVersion != 0)?Colors.white:Colors.transparent.withOpacity(0.002),
        systemNavigationBarDividerColor:Colors.transparent,
        systemNavigationBarIconBrightness: (_androidVersion < 30 && _androidVersion != 0)?Brightness.dark:Brightness.light,
      ),
      child: ,
    )*/Stack(
      children: [
        Container(
          color: Colors.blueGrey,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
          child: Container(
            color: Colors.amber,
            child: SizedBox(
              height: MediaQuery.of(context).padding.bottom,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}








