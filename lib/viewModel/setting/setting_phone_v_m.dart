import 'dart:async';

import 'package:flutter/material.dart';
import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';

/// @description： 绑定手机号
/// @author：liuzhidong
/// @date：2020/5/21 20:13
/// @version：1.0

class SettingPhoneVM extends ViewStateProvider {
  final UserVM userVM;

  String code;
  String phone;
  Timer countdownTimer;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  bool _autoValidator = false;

  SettingPhoneVM(this.userVM) : assert(userVM != null);

  bool get autoValidator => _autoValidator;

  set autoValidator(bool b) {
    _autoValidator = b;
    notifyListeners();
  }

  int _count = 0;

  int get count => _count;

  set count(int v) {
    _count = v;
    notifyListeners();
  }

  ///验证手机号
  Future<String> findCode() async {
    setBusy();
    try {
      code = await MakingFriendsApi.fetchSendCode(phone);
      setDef();
      return code;
    } catch (e, s) {
      setError(e, s);
      return '';
    }
  }

  ///绑定手机号
  Future bindingPhone() async {
    setBusy();
    try {
      var res = await MakingFriendsApi.fetchBindPhone(phone: phone, code: code);
     // userVM.setUser(user);
      setDef();
    } catch (e, s) {
      setError(e, s);
      return '';
    }
  }
}