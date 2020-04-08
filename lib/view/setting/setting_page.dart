import 'package:flutter/material.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import '../../config/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 描述
/// @author：liuzhidong
/// @date：2020/4/6 14:53
/// @version：1.0

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleConfig.SETTING_TITLE),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
          children: <Widget>[
            HeadLine(
              title: Text('账号与安全'),
              titleSize: 30,
              onTop: () {
                Jump.push('setting/account_security_page');
              },
            ),
            HeadLine(
              title: Text('资料编辑'),
              titleSize: 30,
              onTop: () {
                Jump.push('setting/editing_materials_page');
              },
            ),
            HeadLine(
              title: Text('清除缓存'),
              trailing: '0.00KB',
              titleSize: 30,
              isIcon: false,
              onTop: () {
                Jump.push('setting/clear_cache_page');
              },
            ),
            HeadLine(
              title: Text('意见反馈'),
              titleSize: 30,
              onTop: () {
                Jump.push('setting/feedack_page');
              },
            ),
            HeadLine(
              title: Text('关于社区'),
              titleSize: 30,
              onTop: () {
                Jump.push('setting/about_page');
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  '退出登陆',
                  style: TextStyle(
                    fontSize: 32.sp,
                    letterSpacing: 5.w,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
