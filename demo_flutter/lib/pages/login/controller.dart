import 'package:flutter/material.dart';
import 'package:demo_flutter/common/routes/app_pages.dart';
import 'package:demo_flutter/common/values/values.dart';
import 'package:demo_flutter/pages/login/state.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'index.dart';
import '../../common/utils/utils.dart';
import '../../common/models/models.dart';
import '../../common/routes/app_pages.dart';
import '../../common/values/values.dart';

class SignInController extends GetxController {
  final state = SignInState();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ///监听
  // final eventChannel = EventChannel("com.eventChannelName.iOSFlutter");
  final basicMessageChannel =
      BasicMessageChannel(BASIC_MESSAGE_CHANNEL, StandardMessageCodec());

  final methodChannel = MethodChannel(METHOD_CHANNEL);

  @override
  void onInit() {
    super.onInit();
    // eventChannel.receiveBroadcastStream().listen((event) {
    //   print("BBBBB");
    //   print(event);
    // });

    ///接受iOS发来的消息
    basicMessageChannel.setMessageHandler((result) async {
      if (result is Map) {
        int code = result["code"];
        String message = result['message'];
        state.text.value = "接收到消息：code:$code message: $message";
        print(state.text.value);
        // state.text.value = "DDDDDDDDDDD";
        return {
          "method": "close",
          "content": "Flutter接收到iOS传递的信息并回复",
          "code": 200
        };
      }
    });

    //接受iOS发来的消息
    methodChannel.setMethodCallHandler((call) {
      print(call.method == "test");
      if (call.method == "test") {
        if (call.arguments is Map) {
          int code = call.arguments["code"];
          String message = call.arguments['message'];
          state.text.value = "接收到消息：code:$code message: $message";
        }
        return Future(() => {
              "method": "close",
              "content": "Flutter接收到iOS传递的信息并回复",
              "code": 200
            });
      }
      return Future(() => {});
    });
  }

  void sendBasicMessageAndReply() async {
    Object? reply = await basicMessageChannel
        .send({"method": "close", "content": "传递flutter数据给iOS", "code": 200});
    if (reply is Map) {
      int code = reply["code"];
      String message = reply["message"];
      state.text.value = "接收到消息：code:$code message: $message";
    }
  }

  Future<Null> sendMethodMessageAndReply() async {
    print("ccccc");
    try {
      var reply = await methodChannel.invokeMethod('flutterTest',
          {"method": "close", "content": "传递flutter数据给iOS", "code": 200});
      print(reply is Map);
      if (reply is Map) {
        int code = reply["code"];
        String message = reply["message"];
        state.text.value = "接收到消息：code:$code message: $message";
      }
    } on PlatformException catch (e) {
      print("object");
    }
  }

  handleLogin() async {
    if (phoneController.text.length != 11) {
      ToastUtil.showToast("请输入正确的手机号");
      return;
    }
    if (passwordController.text == '') {
      ToastUtil.showToast("请输入正确的验证码");
      return;
    }
    var params = {
      "account": phoneController.text,
      "authCode": passwordController.text,
    };
    LoadingUtil.showLoading();
    Map<String, dynamic> map =
        await HttpUtil().post(SERVER_API_URL + LOGIN, data: params);
    LoadingUtil.dismissLoading();
    User? user = User.fromJson(map);
    print(user.result?.accessToken);
    bool a = await StorageUtil().setJSON(USERKEY, user);
    if (a) {
      Get.toNamed(AppRoutes.LOGOUT_NOTICE);
    }
  }
}
