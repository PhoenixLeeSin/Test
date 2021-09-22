import '../../common/routes/app_pages.dart';
import '../../global.dart';
import 'package:get/get.dart';
import 'index.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();
  WelcomeController();

  //跳转 登录
  handleNavSignin() {
    Global.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }

  @override
  void onReady() {
    super.onReady();
  }
}
