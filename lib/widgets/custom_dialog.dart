import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:makingfriends/config/application.dart';

/// @description： 自定义对话框
/// @author：liuzhidong
/// @date：2020/3/27 23:26
/// @version：1.0

class CustomDialog {
  ///对话框
  static dialogDivider(
    String title, {
    Function onConfirom,
    double width = 220,
    double borderRadius = 4,
    Alignment titleAlignment = Alignment.center,
    Color titleColor = Colors.black,
    double titleFontSize = 14,
    FontWeight titleFontWeight = FontWeight.w500,
    String onConfiromText = '确认',
    String onCancelText = '取消',
    Color onConfiromTextColor = Colors.redAccent,
    Color onCancelTextColor = Colors.redAccent,
    double buttonFontSize = 14,
    Function onCancel,
  }) {
    return YYDialog().build()
      ..width = width
      ..borderRadius = borderRadius
      ..barrierDismissible = false
      ..context = Application.context
      ..text(
        padding: EdgeInsets.all(25.0),
        alignment: titleAlignment,
        text: title,
        color: titleColor,
        fontSize: titleFontSize,
        fontWeight: titleFontWeight,
      )
      ..divider()
      ..doubleButton(
        padding: EdgeInsets.only(top: 10.0),
        gravity: Gravity.center,
        withDivider: true,
        text1: onCancelText,
        color1: onCancelTextColor,
        fontSize1: buttonFontSize,
        fontWeight1: FontWeight.bold,
        onTap1: onCancel,
        text2: onConfiromText,
        color2: onConfiromTextColor,
        fontSize2: buttonFontSize,
        fontWeight2: FontWeight.bold,
        onTap2: onConfirom,
      )
      ..show();
  }

  ///弹出框默认底部
  static dialogBottomSheet(
      {BuildContext context,
      double width: double.infinity,
      double borderRadius: 0,
      Gravity gravity: Gravity.bottom}) {
    return YYDialog().build(context)
      ..width = width
      ..gravity = gravity
      ..gravityAnimationEnable = true
      ..borderRadius = borderRadius
      ..widget(Container(
        height: 200,
      ))
      ..show();
  }
}
