import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/provider/view_state.dart';
import 'package:makingfriends/provider/view_state_basic.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description： 获取用户详细信息
/// @author：liuzhidong
/// @date：2020/5/15 22:28
/// @version：1.0

class UserInfo extends ViewStateBasic<User> {

  User _user = User();

  User get user => _user;

  set user(User u) {
    _user = u;
    notifyListeners();
  }

  @override
  Future<User> find({Map data}) async {
    return await MakingFriendsApi.fetchGetUserInfo(user.id);
  }

  @override
  Future<User> save({Map data}) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<User> update({Map data}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  onCompleted(User data, ViewFunction type) {
    if (ViewFunction.find == type) {
      user = data;
    }
  }
}
