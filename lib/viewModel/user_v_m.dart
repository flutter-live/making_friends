import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/model/user.dart';

/// @description：用户表
/// @author：liuzhidong
/// @date：2020/4/18 17:25
/// @version：1.0

class UserVM extends ChangeNotifier {
  static const String keyLoginName = 'KeyLoginName';

  User user;

  bool get hasUser => user != null;

  UserVM(){
    var userStr = Application.sharedPreferences.getString(keyLoginName);
    user = userStr != null && userStr.isNotEmpty ? User.fromJson(jsonDecode(userStr)) : null;
  }

  void setUser(User u) async{
    user = u;
    notifyListeners();
    Application.sharedPreferences.setString(keyLoginName, json.encode(user.toJson()));
  }


}