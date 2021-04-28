typedef RequestSuccess = void Function(Map<String,String> headers,String bodyParams);

typedef RequestFailure = void Function(String msg);