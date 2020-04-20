import 'dart:async';
import 'package:flutter/material.dart';
import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';

/// @description： 登陆
/// @author：liuzhidong
/// @date：2020/4/18 13:17
/// @version：1.0

const String keyLoginName = 'KeyLoginName';

class LoginVM extends ViewStateProvider {
  final UserVM userVM;

  String code;
  String phone;
  Timer countdownTimer;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  bool _autoValidator = false;

  LoginVM(this.userVM) : assert(userVM != null);

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

  Future login() async {
    setBusy();
    try {
      User user = await MakingFriendsApi.fetchLogin(phone, code);
      userVM.setUser(user);
      setDef();
    } catch (e, s) {
      setError(e, s);
      return '';
    }
  }



}
