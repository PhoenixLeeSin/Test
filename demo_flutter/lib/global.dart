import 'dart:io';
// import 'package:';
import 'package:flutter/material.dart';
import './common/utils/utils.dart';
import './common/values/values.dart';

class Global {
  ///是否第一次打开
  static bool? isFirstOpen;

  /// init
  static Future init() async {
    //运行开始
    WidgetsFlutterBinding.ensureInitialized();

    /// 工具初始
    await StorageUtil().init();
    HttpUtil();

    ///读取设备第一次打开
    isFirstOpen = StorageUtil().getBool(STORAGE_DEVICE_FIRST_OPEN_KEY);
    if (isFirstOpen == null) {
      isFirstOpen = true;
    }
  }

  /// 保存已打开App
  static saveAlreadyOpen() {
    StorageUtil().setBool(STORAGE_DEVICE_FIRST_OPEN_KEY, false);
  }
}
