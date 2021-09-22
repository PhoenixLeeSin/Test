import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void showToast(String message,
      {timeInSecForIosWeb = 1,
      backgroundColor = Colors.black87,
      textColor = Colors.white}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength:
            message.length > 20 ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: timeInSecForIosWeb,
        backgroundColor: backgroundColor,
        textColor: textColor);
  }
}
