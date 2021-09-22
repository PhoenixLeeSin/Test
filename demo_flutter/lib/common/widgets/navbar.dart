import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget navBarWidget(
    {isShowLeftBtn = true,
    leftBtnTap = VoidCallback,
    title = "",
    isShowRightBtn = false,
    rightWidget = Widget,
    rightBtnTap = VoidCallback}) {
  return Container(
      padding: EdgeInsets.fromLTRB(15, ScreenUtil().statusBarHeight, 0, 0),
      height: 44 + ScreenUtil().statusBarHeight,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: Color(0xFFF2F2F2),
            width: 0.5,
          ))),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: isShowLeftBtn
                ? GestureDetector(
                    onTap: leftBtnTap,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Container(),
          ),
          Expanded(
            flex: 1,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 18.sp,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: isShowRightBtn
                ? GestureDetector(
                    onTap: rightBtnTap,
                    child: rightWidget,
                  )
                : Container(),
          )
        ],
      ));
}
