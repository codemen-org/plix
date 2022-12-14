import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ToastUtil {
  static void showLongToast(String message) {
    String trn = message.tr;
    Fluttertoast.showToast(
      msg: trn,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void showShortToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static void showNoInternetToast() {
    Fluttertoast.showToast(
      msg: "Please check your internet connection",
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
