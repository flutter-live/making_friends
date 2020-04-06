import 'package:flutter/material.dart';
import '../../config/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 密码
/// @author：liuzhidong
/// @date：2020/4/6 15:57
/// @version：1.0

class SettingPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleConfig.SETTING_PASSWORD_TITLE),
      ),
      body: Container(
        margin: EdgeInsets.all(20.w),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: '输入新密码',
                  hintStyle: TextStyle(fontSize: 26.sp),
                ),
              ),
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: '输入新密码',
                  hintStyle: TextStyle(fontSize: 26.sp),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 40.w),
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  '设置',
                  style: TextStyle(
                    fontSize: 32.sp,
                    letterSpacing: 5.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
