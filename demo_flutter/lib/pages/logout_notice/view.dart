import 'package:flutter/material.dart';
import './index.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/widgets/widgets.dart';

class LogoutNoticePage extends GetView<LogoutNoticeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildNavBar(),
          _buildContent(),
          Spacer(),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    return Container(
      height: 44.h,
      margin: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 0.5,
        color: Color(0xFFF2F2F2),
      ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.only(left: 15.sp),
              child: Icon(
                Icons.arrow_back_ios,
                size: 24.sp,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 113.w),
            child: Text(
              "注销账号",
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                  color: Color(0xFF333333),
                  decoration: TextDecoration.none,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.fromLTRB(32.w, 22.h, 17.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "注销须知",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xFF282828),
              decoration: TextDecoration.none,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "1. 账号注销后该平台账号下所有产品均不可登录，所有交易数据将无法恢复，请确保所有订单均已完成并且无纠纷，账户注销后无法再对订单进行处理;\n 2. 您的身份信息将被删除，账户注销视为自动放弃平台内的所有权益、福利等，并且无法恢复;\n 3. 使用本平台服务、与该账号关联的其他产品将无法使用;\n 4. 账户注销时，平台将会检查是否符合注销条件，未符合注销条件的需用户处理后再注销账户;",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color(0xFF666666),
                decoration: TextDecoration.none,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 31.h),
      child: btnFlatButtonWidget(
        onPressed: () {
          controller.handleLogoutClick();
        },
        width: 345,
        height: 40,
        title: "确认注销",
      ),
    );
  }
}
