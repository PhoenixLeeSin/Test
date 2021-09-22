import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AlertUtil {
  static showAlert(String title, String content,
      {isShowClose = false,
      leftButtonTitle = '取消',
      leftButtonTap = VoidCallback,
      rightButtonTitle = '确定',
      rightButtonTap = VoidCallback}) {
    if (GetPlatform.isIOS) {
      return showCupertinoDialog(
        context: Get.context!,
        builder: (context) {
          return CupertinoAlertDialog(
            title: _buildTitle(title, isShowClose),
            content: _buildContent(content),
            actions: [
              CupertinoButton(
                  child: Text(leftButtonTitle), onPressed: leftButtonTap),
              CupertinoButton(
                  child: Text(rightButtonTitle), onPressed: rightButtonTap),
            ],
          );
        },
      );
    } else {
      return showDialog(
          context: Get.context!,
          builder: (context) {
            return AlertDialog(
              title: _buildTitle(title, isShowClose),
              content: _buildContent(content),
              actions: [
                TextButton(
                    onPressed: leftButtonTap, child: Text(leftButtonTitle)),
                TextButton(
                    onPressed: rightButtonTap, child: Text(rightButtonTitle)),
              ],
            );
          });
    }
  }

  static Widget _buildTitle(String title, bool isShowClose) {
    //实现两个子控件分别中间对齐和右对齐
    return Stack(
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
        Positioned(
          right: 0.w,
          child: isShowClose
              ? GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.close,
                    size: 18.sp,
                    color: Colors.blue,
                  ),
                )
              : Container(),
        )
      ],
    );
  }

  static Widget _buildContent(String content) {
    return Container(
      child: Text(
        content,
        style: TextStyle(
          color: Color(0xFF666666),
          decoration: TextDecoration.none,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
