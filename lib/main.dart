
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
  @override
  Future<void> initState() {
    super.initState();
    //initPlatformState();
  }

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
  }*/

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarDividerColor:Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark
      ),
      child: Stack(
        children: [
          Container(
            color: Colors.blueGrey,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
            child: Container(
              color: Colors.amber,
              child: SizedBox(
                height: getBottomSafeareaHeight(context),
                width: double.infinity,
              ),
            ),
          ),
          //SafeArea(child: Container(color: Colors.blue,))
        ],
      ),
    );
  }
}

double getBottomSafeareaHeight(BuildContext context){
  double height = MediaQuery.of(context).viewInsets.bottom;
  return height == 0?MediaQuery.of(context).padding.bottom:height;
}








