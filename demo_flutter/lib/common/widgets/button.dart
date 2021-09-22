import 'package:flutter/material.dart';
import '../../common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///扁平角按钮
Widget btnFlatButtonWidget({
  required VoidCallback onPressed,
  double width = 140,
  double height = 44,
  Color bgColor = AppColors.primaryElement,
  String title = "button",
  Color fontColor = AppColors.primaryElementText,
  double fontSize = 18,
  String fontName = "Monterrat",
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Container(
    width: width.w,
    height: height.h,
    child: TextButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16.sp)),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.focused) &&
                !states.contains(MaterialState.pressed)) {
              return Colors.blue;
            } else if (states.contains(MaterialState.pressed)) {
              return Colors.deepPurple;
            }
            return fontColor;
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.blue[200];
            }
            return bgColor;
          }),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          )),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: fontColor,
            fontFamily: fontName,
            fontWeight: fontWeight,
            fontSize: fontSize.sp,
            height: 1,
          ),
        )),
  );
}
