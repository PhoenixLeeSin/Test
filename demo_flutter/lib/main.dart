import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_flutter/global.dart';
import 'package:get/get.dart';

import 'common/routes/app_pages.dart';
import 'common/services/global_config.dart';
import 'common/utils/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  await initServices();
  runApp(MyApp());
}

Future<void> initServices() async {
  print('starting services...');
  await Get.putAsync(() => GlobalConfigService().init());
  await Global.init();
  print('all services started..');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 667),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: true,

        enableLog: true,
        logWriterCallback: Logger.write,

        //路由
        getPages: AppPages.routes,

        //启动页面
        initialRoute: AppPages.INITIAL,

        builder: EasyLoading.init(),
      ),
    );
  }
}
