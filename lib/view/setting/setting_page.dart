import 'package:flutter/material.dart';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:makingfriends/widgets/dialog_helper.dart';
import 'package:provider/provider.dart';
import '../../config/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 设置
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
      body: Consumer<UserVM>(
        builder: (_, model, child) {
          return Container(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 5),
              children: <Widget>[
                Visibility(
                  visible: model.hasUser,
                  child: Column(
                    children: <Widget>[
                      HeadLine(
                        title: Text('账号与安全'),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        onTop: () => Jump.push('setting/account_security_page'),
                      ),
                      Divider(
                        height: 0.5,
                        color: Colors.black38,
                      ),
                      HeadLine(
                        title: Text('资料编辑'),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        onTop: () =>
                            Jump.push('setting/editing_materials_page'),
                      ),
                      Divider(
                        height: 0.5,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                ),
                HeadLine(
                  title: Text('清除缓存'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  onTop: () async {
                    if (await DialogHelper.showLoginDialog('是否要清除缓存？')) {
                      clearCache(model, context);
                    }
                  },
                ),
                Divider(
                  height: 0.5,
                  color: Colors.black38
                ),
                HeadLine(
                  title: Text('关于社区'),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  onTop: () => Jump.push('setting/about_page'),
                ),
                Divider(
                  height: 0.5,
                  color: Colors.black38,
                ),
                Visibility(
                  visible: model.hasUser,
                  child: RaisedButton(
                    onPressed: () => logout(model, context),
                    child: Text(
                      '退出登陆',
                      style: TextStyle(
                          fontSize: 18, letterSpacing: 2, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

///清除缓存
void clearCache(UserVM model, BuildContext context) async {
  await Application.sharedPreferences.clear();
  model.setUser(model.user);
}

///退出登陆
void logout(UserVM model, BuildContext context) async {
  if (await DialogHelper.showLoginDialog('是否要退出登陆？')) {
    model.setUser(null);
  }
}
