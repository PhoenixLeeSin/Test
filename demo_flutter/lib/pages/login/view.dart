import 'package:flutter/services.dart';
import 'package:demo_flutter/common/values/values.dart';
import 'package:demo_flutter/pages/login/controller.dart';

import 'index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/widgets/widgets.dart';

class SignInPage extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // _buildCloseWidget(),
          // _buildUserIcon(),
          // _buildInputForm(),
          _buildReceiveChannelContent(),
          TextButton(
            onPressed: () {
              controller.sendBasicMessageAndReply();
            },
            child: Text(
              "Flutter通过Basic发送消息至iOS并接收回复",
            ),
          ),
          TextButton(
            onPressed: () {
              controller.sendMethodMessageAndReply();
            },
            child: Text(
              "Flutter通过method发送消息至iOS并接收回复",
            ),
          )
        ],
      ),
    );
  }

  //关闭按钮
  Widget _buildCloseWidget() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin:
            EdgeInsets.only(left: 10.w, top: (ScreenUtil().statusBarHeight).h),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.close,
              size: 22.h,
              color: Colors.black,
            ),
            Text(
              '登录',
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  //头像
  Widget _buildUserIcon() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 40.h),
      child: PhysicalModel(
        color: Colors.grey,
        shape: BoxShape.circle,
        child: Icon(
          Icons.person,
          size: 80.h,
          color: Colors.white,
        ),
      ),
    );
  }

  ///登录表单
  Widget _buildInputForm() {
    return Container(
      width: 295.w,
      margin: EdgeInsets.only(top: 49.h),
      child: Column(
        children: <Widget>[
          inputTextEdit(
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            hintText: "请输入手机号",
            marginTop: 0,
          ),
          inputTextEdit(
            controller: controller.passwordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: "请输入验证码",
            isPassword: true,
          ),
          Container(
            height: 10.h,
          ),
          btnFlatButtonWidget(
              onPressed: controller.handleLogin, title: "登录", width: 290.w),
        ],
      ),
    );
  }

  ///接收到原生消息的UI
  Widget _buildReceiveChannelContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      color: Colors.lime,
      margin: EdgeInsets.only(top: 29.h),
      child: Obx(() => Text(
            "${controller.state.text.value}",
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.sp,
            ),
          )),
    );
  }
}
