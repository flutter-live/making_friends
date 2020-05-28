import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/viewModel/login_v_m.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/loading.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

/// @description：登陆页
/// @author：liuzhidong
/// @date：2020/4/14 20:08
/// @version：1.0

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: ProviderWidget<LoginVM>(
        model: LoginVM(Provider.of<UserVM>(context)),
        builder: (context, model, child) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Text(
                    '手机验证码登陆',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Form(
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
                                  child: UpdateCode(),
                                  onTap: () => model.count == 0 ? getCode(context) : null,
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
                              '登陆',
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontSize: 18),
                            ),
                            onPressed: () => login(context)),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '账号密码登陆',
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 1,
                        color: Colors.black87,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '登陆遇到问题',
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 1,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          '社交账号登陆',
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 1,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Image.asset(
                          'assets/wx.png',
                          width: 58,
                          height: 58,
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: Image.asset(
                          'assets/QQ.png',
                          width: 50,
                          height: 50,
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: Image.asset(
                          'assets/wb.png',
                          width: 50,
                          height: 50,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('注册即代表同意'),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          '《社区交友协议》',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
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

class UpdateCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginVM>(
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

void login(BuildContext context) async{
  ProgressDialog.showProgress();
  LoginVM model = Provider.of<LoginVM>(context, listen: false);
  var loginForm = model.loginKey.currentState;
  //读取当前 Form 状态
  if (loginForm.validate()) {
    loginForm.save();
    await model.login();
    if(model.isDef){
      ProgressDialog.dismiss();
      Navigator.pop(context);
    }
  } else {
    model.autoValidator = true;
    ProgressDialog.dismiss();
  }
}

void getCode(BuildContext context) async {
  LoginVM model = Provider.of<LoginVM>(context, listen: false);
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
