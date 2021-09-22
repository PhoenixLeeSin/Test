import 'package:get/get.dart';
import './index.dart';

class LogoutOperatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogoutOperationController());
  }
}
