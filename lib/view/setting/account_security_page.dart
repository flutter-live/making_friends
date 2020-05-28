import 'package:flutter/material.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:provider/provider.dart';
import '../../config/string.dart';

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
      body: Consumer<UserVM>(
        builder: (_, model, child) {
          return Container(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 5),
              children: <Widget>[
                HeadLine(
                  title: Text('手机号'),
                  trailing: model.user.phone == null || model.user.phone.isEmpty
                      ? '未绑定'
                      : model.user.phone,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  onTop: () {
                    Jump.push('setting/setting_phone_page');
                  },
                ),
                Divider(
                  height: 0.5,
                  color: Colors.black38,
                ),
                HeadLine(
                  title: Text('登陆密码'),
                  trailing: model.user.password == null || !model.user.password
                      ? '未设置'
                      : '修改密码',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  onTop: () {
                    Jump.push('setting/setting_password_page');
                  },
                ),
                Divider(
                  height: 0.5,
                  color: Colors.black38,
                ),
                HeadLine(
                  title: Text('邮箱绑定'),
                  trailing: model.user.email == null || model.user.email.isEmpty
                      ? '未绑定'
                      : model.user.email,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  onTop: () {
                    Jump.push('setting/setting_mail_page');
                  },
                ),
                Divider(
                  height: 0.5,
                  color: Colors.black38,
                ),
                HeadLine(
                  title: Text('微信账号'),
                  trailing: '未绑定',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  onTop: () {},
                ),
                Divider(
                  height: 0.5,
                  color: Colors.black38,
                ),
                HeadLine(
                  title: Text('QQ账号'),
                  trailing: '未绑定',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  onTop: () {},
                ),
                Divider(
                  height: 0.5,
                  color: Colors.black38,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
