import 'dart:convert';

import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/config/cache.dart';
import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description：用户表
/// @author：liuzhidong
/// @date：2020/4/18 17:25
/// @version：1.0

class UserVM extends ViewStateProvider {
  User user;

  bool get hasUser => user != null;

  UserVM() {
    var userStr =
        Application.sharedPreferences.getString(CacheKey.keyLoginName);
    user = userStr != null && userStr.isNotEmpty
        ? User.fromJson(jsonDecode(userStr))
        : null;
  }

  void setUser(User u) async {
    user = u;
    notifyListeners();
    if (u == null) {
      Application.sharedPreferences.remove(CacheKey.keyLoginName);
    } else {
      Application.sharedPreferences
          .setString(CacheKey.keyLoginName, json.encode(user.toJson()));
    }
  }

  ///获取用户详细信息
  Future<void> find() async {
    User u = await MakingFriendsApi.fetchGetUserInfo(user.id);
    setUser(u);
  }

  ///修改用户信息
  Future<bool> update(User u) async {
    try {
      Map<String, dynamic> basic = {
        "name": u.username,
        "sex": u.userinfo.sex,
        "qg": u.userinfo.qg,
        "job": u.userinfo.job,
        "birthday": u.userinfo.birthday,
        "path": u.userinfo.path,
      };
      var res = await MakingFriendsApi.fetchEditUserInfo(basic);
      if (res.length == 0) {
        setUser(u);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  ///修改头像
  Future<void> editUserPic(String path) async {
    var res = await MakingFriendsApi.fetchEditUserPic(path);
    setUser(user..userpic = res);
  }
}
