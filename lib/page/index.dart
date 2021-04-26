import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spvoice_flutter/controller/tab_loading_controller.dart';
import 'package:spvoice_flutter/network/requestcenter.dart';
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
            MainTop(),
            Expanded(
              child: ChangeNotifierProvider(
                create: (context)=>TabRequsetController(),
                child: MainPage(),
              ),
            ),
            MainBottom(),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
    RequestCenter.getTab(context);
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<TabRequsetController>().getView();
  }
}


