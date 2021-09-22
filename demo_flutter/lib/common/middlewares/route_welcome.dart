import 'package:flutter/material.dart';
import '../routes/app_pages.dart';
import '../../global.dart';
import 'package:get/get.dart';

///首次加载欢迎页

class RouteWelcomeMiddleWare extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteWelcomeMiddleWare({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (Global.isFirstOpen == true) {
      // return null;
      return RouteSettings(name: AppRoutes.SIGN_IN);
    } else {
      return RouteSettings(name: AppRoutes.SIGN_IN);
    }
  }
}
