import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingUtil {
  static showLoading({message = 'loading...'}) {
    EasyLoading.show(status: message);
  }

  static dismissLoading() {
    EasyLoading.dismiss();
  }
}
