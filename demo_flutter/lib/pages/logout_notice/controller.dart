import 'package:demo_flutter/common/utils/alert.dart';
import 'package:get/get.dart';
import './index.dart';
import '../../common/utils/utils.dart';
import '../../common/routes/app_pages.dart';

class LogoutNoticeController extends GetxController {
  final state = LogoutNoticeState();

  void handleLogoutClick() {
    AlertUtil.showAlert(
      "提示",
      "确定进行注销操作？",
      isShowClose: true,
      leftButtonTap: () => Get.back(),
      rightButtonTap: () =>
          {Get.back(), Get.toNamed(AppRoutes.LOGOUT_OPERATION)},
    );
  }
}
