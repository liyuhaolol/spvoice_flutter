class HttpConstants{

  static const bool useInternetFakeData = false;//传true会去加载项目里的静态假数据


  ///github静态数据
  static const String HOST = 'https://fastly.jsdelivr.net/gh';
  static const String GET_TAB = HOST + '/liyuhaolol/spvoice_flutter/channelList.json';
  static const String GET_NEWS_LIST_DOWN = HOST + '/liyuhaolol/spvoice_flutter/firstPage.json';
  static const String GET_NEWS_LIST_UP = HOST + '/liyuhaolol/spvoice_flutter/secondPage.json';

  ///服务器动态数据
  static const String HOST2 = 'https://app.offshoremedia.net';
  static const String GET_NEWS_CHANNEL = HOST2+'/app/channel/v1/list';
  static const String GET_NEWS_LIST = HOST2+'/app/content/v3/list';



  ///范例而已
  static const int PULL_DOWN = 1;
  static const int PULL_UP = 2;

  ///只是个例子而已
  static String getPullUrl(int pullType){
    if(pullType == PULL_DOWN){

      return useInternetFakeData?GET_NEWS_LIST_DOWN:GET_NEWS_LIST;
    }else{
      return useInternetFakeData?GET_NEWS_LIST_UP:GET_NEWS_LIST;
    }
  }
}