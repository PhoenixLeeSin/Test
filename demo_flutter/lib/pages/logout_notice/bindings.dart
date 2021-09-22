import 'package:get/get.dart';
import './index.dart';

class LogoutNoticeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogoutNoticeController());
  }
}
