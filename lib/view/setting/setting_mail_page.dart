import 'package:flutter/material.dart';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/viewModel/setting/setting_mail_v_m.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/loading.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import '../../config/string.dart';

/// @description： 绑定邮件
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
      body: ProviderWidget<SettingMailVM>(
          model: SettingMailVM(Provider.of<UserVM>(context)),
          builder: (_, model, child) {
            return Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextField(
                      controller: model.controller,
                      decoration: InputDecoration(
                        hintText: '请输入你要绑定的邮箱号',
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      onSubmitted: (value) {
                        model.email = value;
                      },
                      onChanged: (value) {
                        model.email = value;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () => save(model),
                      child: Text(
                        '绑定',
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

void save(SettingMailVM model) async {
  if (isEmail(model.email)) {
    ProgressDialog.showProgress();
    await model.bindEmail();
    if (model.isError) {
      ProgressDialog.dismiss();
      showToast("绑定失败",
          textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          radius: 5,
          backgroundColor: Colors.black87);
      return;
    }
    if (model.isDef) {
      ProgressDialog.dismiss();
      showToast("绑定成功",
          textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          radius: 5,
          backgroundColor: Colors.black87);
      Navigator.pop(Application.context);
    }
  }else{
    showToast("邮箱格式不正确",
        textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        radius: 5,
        backgroundColor: Colors.black87);
  }
}

final String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
bool isEmail(String input) {
  if (input == null || input.isEmpty) return false;
  return new RegExp(regexEmail).hasMatch(input);
}
