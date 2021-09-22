import 'dart:io';
import 'package:get/get.dart';

///全局响应数据

class GlobalConfigService extends GetxService {
  ///发布渠道
  var channel = "".obs;

  ///是否iOS
  var isIOS = false.obs;

  Future<GlobalConfigService> init() async {
    channel.value = "Apple";
    isIOS.value = Platform.isIOS;
    return this;
  }
}