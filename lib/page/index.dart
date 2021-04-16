import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spvoice_flutter/view/indexbottombutton.dart';
import 'package:spvoice_flutter/view/indexheader.dart';

class PageIndex extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,//iOS
          statusBarIconBrightness: Brightness.dark,//Android
          systemNavigationBarIconBrightness: Brightness.dark,//Android
        ),
        child: Column(
          children: [
            MainPage(),
            Expanded(
              child: Container(width: double.infinity,
                color: Colors.amber,
              child: Text('1'),),
            ),
            MainBottom(),
          ],
        ),
      ),
    );
  }
}
