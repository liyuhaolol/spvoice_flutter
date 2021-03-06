class HttpConstants{
  static const String HOST = 'https://gitee.com';

  ///得到栏目
  static const String GET_TAB = HOST + '/TheCoders/ntzs/raw/master/channelList.json';

  ///范例而已
  static const int PULL_DOWN = 1;
  static const int PULL_UP = 2;
  ///得到新闻列表下拉
  static const String GET_NEWS_LIST_DOWN = HOST + '/TheCoders/ntzs/raw/master/firstPage.json';

  ///得到新闻列表上拉
  static const String GET_NEWS_LIST_UP = HOST + '/TheCoders/ntzs/raw/master/secondPage.json';

  ///只是个例子而已
  static String getPullUrl(int pullType){
    if(pullType == PULL_DOWN){
      return GET_NEWS_LIST_DOWN;
    }else{
      return GET_NEWS_LIST_UP;
    }
  }
}