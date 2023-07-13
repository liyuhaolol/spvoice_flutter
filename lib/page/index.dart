import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spvoice_flutter/state/request_view_state.dart';
import 'package:spvoice_flutter/state/tab_request_data.dart';
import 'package:spvoice_flutter/view/index/tab/tab_failure_view.dart';
import 'package:spvoice_flutter/view/index/tab/tab_loading_view.dart';
import 'package:spvoice_flutter/view/index/tab/tab_success_view.dart';
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
                create: (context)=>TabRequestData(),
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

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    switch(context.watch<TabRequestData>().state){
      case ViewState.INIT:
      case ViewState.LOADING:
        return TabLoadingView();
      case ViewState.SUCCESS:
        return TabSuccessView(Provider.of<TabRequestData>(context, listen: false).channelList);
      case ViewState.FAILURE:
        return TabFailureView();
    }
  }
}



