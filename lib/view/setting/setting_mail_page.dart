import 'package:flutter/material.dart';
import '../../config/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 邮件
/// @author：liuzhidong
/// @date：2020/4/6 15:58
/// @version：1.0

class SettingMailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleConfig.SETTING_MAIL_TITLE),
      ),
      body: Container(
        margin: EdgeInsets.all(20.w),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                decoration: InputDecoration(
                    hintText: '请输入你要绑定的邮箱号',
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
                  '绑定',
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
