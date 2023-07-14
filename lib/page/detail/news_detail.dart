import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spvoice_flutter/model/list_item.dart';
import 'package:spvoice_flutter/state/news_detail_state.dart';
import 'package:spvoice_flutter/state/webview_delay_state.dart';
import 'package:spvoice_flutter/view/common_bottom_bar.dart';
import 'package:spvoice_flutter/view/overscroll_behavior.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatelessWidget {
  final arguments;
  NewsDetail({this.arguments});

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
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: ChangeNotifierProvider(
                    create: (context) => NewsDetailState(),
                    child: _getContent(arguments['news']),
                  )),
              CommonBottom(),
            ],
          ),
        ),
      ),
    );
  }
}
class _getContent extends StatelessWidget {
  News news;

  _getContent(this.news);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        initWebview(news.contentStaticPage!),
        _getDefaultView(context),
      ],
    );
  }
  Widget _getDefaultView(BuildContext context){
    if(context.watch<NewsDetailState>().state == NewsState.LOADING){
      return Container(width: double.infinity,
          child: Image.asset('images/news_detail_defalut.png',
            fit: BoxFit.fitWidth,
            alignment: AlignmentDirectional.topStart,));
    }else{
      return Container();
    }
  }

  Widget initWebview(String url){
    return ChangeNotifierProvider(
        create: (_) => WebviewInitState(),
        child: InjectWebview(url));
  }
}

class InjectWebview extends StatefulWidget {
  String url;
  InjectWebview(this.url);
  @override
  _InjectWebviewState createState() => _InjectWebviewState();
}

class _InjectWebviewState extends State<InjectWebview> {

  @override
  initState(){
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) {
      //给100毫秒延迟，让UI反应一下，避免感觉第一秒很短
      Future.delayed(
          Duration(
              milliseconds: 300),
              (){
                context.read<WebviewInitState>().state = WebState.COMPLATE;
          }
      );
      //startCountdownTimer();//启动计时器
    });
  }

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress){
            if(progress > 70){
              context.read<NewsDetailState>().state = NewsState.FINISH;
            }
          }
        )
      )
    ..loadRequest(Uri.parse("${widget.url}?platform=Android&closeDL=true"));
    if(context.watch<WebviewInitState>().state == WebState.INIT){
      return Container();
    }else{
      return ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: WebViewWidget(controller: controller),
      );
    }
  }
}




