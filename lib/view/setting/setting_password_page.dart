import 'package:flutter/material.dart';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/viewModel/setting/setting_password_v_m.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/loading.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import '../../config/string.dart';

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
      body: ProviderWidget<SettingPassWordVM>(
          model: SettingPassWordVM(Provider.of<UserVM>(context)),
          builder: (_, model, child) {
            return Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Visibility(
                    visible: model.isPassword,
                    child: Container(
                      child: TextField(
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: '输入旧密码',
                        ),
                        onSubmitted: (value) {
                          model.oldPassword = value;
                        },
                        onChanged: (value) {
                          model.oldPassword = value;
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: '输入新密码',
                      ),
                      onSubmitted: (value) {
                        model.newPassword = value;
                      },
                      onChanged: (value) {
                        model.newPassword = value;
                      },
                    ),
                  ),
                  Container(
                    child: TextField(
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: '确认新密码',
                      ),
                      onSubmitted: (value) {
                        model.renewPassword = value;
                      },
                      onChanged: (value) {
                        model.renewPassword = value;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () => save(model),
                      child: Text(
                        '设置',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

void save(SettingPassWordVM model) async {
  if (passwordValidator(model)) {
    ProgressDialog.showProgress();
    await model.rePasswordSubmitted();
    if (model.isError) {
      ProgressDialog.dismiss();
      showToast("密码错误",
          textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          radius: 5,
          backgroundColor: Colors.black87);
      return;
    }
    if (model.isDef) {
      ProgressDialog.dismiss();
      showToast("修改成功",
          textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          radius: 5,
          backgroundColor: Colors.black87);
      Navigator.pop(Application.context);
    }
  }
}

///验证
bool passwordValidator(SettingPassWordVM model) {
  if (model.newPassword == null || model.newPassword.isEmpty) {
    showToast("新密码不能为空",
        textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        radius: 5,
        backgroundColor: Colors.black87);
    return false;
  } else if (model.renewPassword == null || model.renewPassword.isEmpty) {
    showToast("确认密码不能为空",
        textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        radius: 5,
        backgroundColor: Colors.black87);
    return false;
  } else if (model.renewPassword.trim() != model.newPassword.trim()) {
    showToast("两次输入密码不一致",
        textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        radius: 5,
        backgroundColor: Colors.black87);
    return false;
  } else {
    return true;
  }
}
