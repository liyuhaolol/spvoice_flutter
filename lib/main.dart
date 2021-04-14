
import 'package:flutter/material.dart';
import 'package:spvoice_flutter/routers/routers.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MyRouters.PAGE_SPLASH,
      onGenerateRoute: MyRouters.onGenerateRoute,
    );
  }
}

/*
class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Future<void> initState() {
    super.initState();
    //initPlatformState();
  }

*/
/*  Future<void> initPlatformState() async {
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
  }*//*


  @override
  Widget build(BuildContext context) {
    return
  }
}

*/






