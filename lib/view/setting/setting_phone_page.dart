import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/viewModel/setting/setting_phone_v_m.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/loading.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import '../../config/string.dart';

/// @description： 绑定手机
/// @author：liuzhidong
/// @date：2020/4/6 15:56
/// @version：1.0

class SettingPhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleConfig.SETTING_PHONE_TITLE),
      ),
      body: ProviderWidget<SettingPhoneVM>(
          model: SettingPhoneVM(Provider.of<UserVM>(context)),
          builder: (_, model, child) {
            return Container(
              margin: EdgeInsets.all(5),
              child: Form(
                key: model.loginKey,
                autovalidate: model.autoValidator,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          //数字键盘
                          decoration: InputDecoration(
                            prefixIcon: Container(
                              width: 0,
                              alignment: Alignment.center,
                              child: Text(
                                '+86',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                            hintText: '手机号',
                          ),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly, //只输入数字
                            LengthLimitingTextInputFormatter(11) //限制长度
                          ],
                          onSaved: (value) {
                            model.phone = value;
                          },
                          onChanged: (value) {
                            model.phone = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value.length != 11) {
                              return '请填写正确的手机号';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          //数字键盘
                          decoration: InputDecoration(
                            hintText: '请输入验证码',
                            suffixIcon: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: GestureDetector(
                                child: _UpdateCode(),
                                onTap: () =>
                                    model.count == 0 ? getCode(model) : null,
                              ),
                            ),
                          ),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly, //只输入数字
                            LengthLimitingTextInputFormatter(4) //限制长度
                          ],
                          onSaved: (value) {
                            model.code = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value.length != 4) {
                              return '请填写正确的手机号';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: RaisedButton(
                          child: Text(
                            '绑定手机号',
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2,
                                fontSize: 18),
                          ),
                          onPressed: () => bindingPhone(model)),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}


class _UpdateCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingPhoneVM>(
      builder: (context, model, child) {
        return Container(
          width: model.count == 0 ? 100 : 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.pinkAccent,
          ),
          child: Text(
            model.count == 0 ? '获取验证码' : '获取验证码 (${model.count})',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}

void bindingPhone(SettingPhoneVM model) async{
  ProgressDialog.showProgress();
  var loginForm = model.loginKey.currentState;
  //读取当前 Form 状态
  if (loginForm.validate()) {
    loginForm.save();
    await model.bindingPhone();
    if(model.isError){
      ProgressDialog.dismiss();
      showToast("绑定失败",
          textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          radius: 5,
          backgroundColor: Colors.black87);
      return;
    }
    if(model.isDef){
      ProgressDialog.dismiss();
      showToast("绑定成功",
          textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          radius: 5,
          backgroundColor: Colors.black87);
      Navigator.pop(Application.context);
    }
  } else {
    model.autoValidator = true;
    ProgressDialog.dismiss();
  }
}

void getCode(SettingPhoneVM model) async {
  if (model.phone == null) {
    showToast("手机号不正确",
        textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        radius: 5,
        backgroundColor: Colors.black87);
    return;
  }
  await model.findCode();
  if (model.isDef) {
    if (model.code.isEmpty) return;
    model.count = 60;
    model.countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      model.count = --model.count;
      if (model.count == 0) {
        model.countdownTimer.cancel();
        model.countdownTimer = null;
      }
    });
    showToast(model.code,
        textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        radius: 5,
        backgroundColor: Colors.black87);
  }
}