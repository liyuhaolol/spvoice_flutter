import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spvoice_flutter/view/commonheadbar.dart';

class PageSetting extends StatelessWidget {
  final arguments;

  PageSetting({this.arguments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          //iOS
        statusBarBrightness: Brightness.light,
          //Android
        statusBarIconBrightness: Brightness.dark,
          //Android
        systemNavigationBarIconBrightness: Brightness.dark,
        ),
          child: Column(
            children: [
              CommonHead(arguments['name']),
            ],
          ),
    )
    );
  }
}
