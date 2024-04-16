import 'package:http/http.dart';
import 'package:logger/logger.dart';

import 'callback/http_callback.dart';

var _logger = Logger(
    printer: PrettyPrinter()
);

Future getRequest(String url,RequestSuccess requestSuccess,RequestFailure requestFailure, {Map<String,String>? headers,Map<String,String>? bodyParams}) async{
  try{
    String mUrl = url+'?';
    if(bodyParams != null){
      bodyParams.forEach((key, value) {
        mUrl += '$key=$value&';
      });
    }
    mUrl = mUrl.substring(0,mUrl.length-1);
    print('url:$mUrl');
    var response = await get(Uri.parse(mUrl),headers:headers);
    if(response.statusCode == 200){
      _logger.i("url:$mUrl\nresponse:${response.body}");
      requestSuccess(response.headers,response.body);
    }else{
      _logger.e('StatusCode:${response.statusCode}');
      requestFailure('StatusCode:${response.statusCode}');
    }
  } on Exception catch (e){
    _logger.e(e);
    requestFailure(e.toString());
  }
}

void postRequest(String url,{Map<String,String>? headers,Map<String,String>? bodyParams}) async{
  var response = await post(Uri.parse(url),headers:headers,body: bodyParams);
}