import 'package:http/http.dart';
import 'package:spvoice_flutter/callback/http_callback.dart';


void getRequest(String url,RequestFailure requestFailure, {Map<String,String> headers,Map<String,String> bodyParams}) async{
  try{
    var response = await get(Uri.parse(url),headers:headers);
    if(response.statusCode == 200){
      print(response.body);
    }else{
      requestFailure();
    }
  } on Exception catch (e){
    requestFailure();
  }
}

void postRequest(String url,{Map<String,String> headers,Map<String,String> bodyParams}) async{
  var response = await post(Uri.parse(url),headers:headers,body: bodyParams);
}