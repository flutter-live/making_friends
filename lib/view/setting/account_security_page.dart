import 'package:flutter/material.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import '../../config/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 账号安全
/// @author：liuzhidong
/// @date：2020/4/6 14:54
/// @version：1.0

class AccountSecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleConfig.ACCOUNT_SECURITY_TITLE),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
          children: <Widget>[
            HeadLine(
              title: Text('手机号'),
              titleSize: 30,
              trailing: '1881475898',
              onTop: () {
                Jump.push('setting/setting_phone_page');
              },
            ),
            HeadLine(
              title: Text('登陆密码'),
              trailing: '******',
              titleSize: 30,
              onTop: () {
                Jump.push('setting/setting_password_page');
              },
            ),
            HeadLine(
              title: Text('邮箱绑定'),
              trailing: '1956252575@qq.com',
              titleSize: 30,
              onTop: () {
                Jump.push('setting/setting_mail_page');
              },
            ),
            HeadLine(
              title: Text('微信账号'),
              trailing: '18811475898',
              titleSize: 30,
              onTop: () {
              },
            ),
            HeadLine(
              title: Text('QQ账号'),
              trailing: '1956252575',
              titleSize: 30,
              onTop: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}


