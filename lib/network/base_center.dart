import 'package:http/http.dart';

void PostRequest(String url,{Map<String,String> headers,Map<String,String> bodyParams}){
  post(Uri.parse(url),headers:headers,body: bodyParams);
}