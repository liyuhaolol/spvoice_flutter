
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String content){
  Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      fontSize: 16.0
  );
}