import 'package:demo_flutter/common/middlewares/route_welcome.dart';
import 'package:demo_flutter/pages/login/bindings.dart';
import 'package:demo_flutter/pages/login/view.dart';

import '../../pages/login/index.dart';
import '../../pages/logout_notice/index.dart';
import '../../pages/logout_operation/index.dart';
import '../../pages/welcome/index.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;

  static final List<GetPage> routes = [
    //初始页
    GetPage(
        name: AppRoutes.INITIAL,
        page: () => WelcomePage(),
        binding: WelcomeBinding(),
        middlewares: [
          RouteWelcomeMiddleWare(priority: 1),
        ]),
    //登录页
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),
    //账户注销说明页
    GetPage(
        name: AppRoutes.LOGOUT_NOTICE,
        page: () => LogoutNoticePage(),
        binding: LogoutNoticeBinding()),
    //账户注销操作
    GetPage(
      name: AppRoutes.LOGOUT_OPERATION,
      page: () => LogoutOperatPage(),
      binding: LogoutOperatBinding(),
    )
  ];
}
