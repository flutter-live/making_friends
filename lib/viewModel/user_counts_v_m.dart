import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/model/UserCounts.dart';
import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:provider/provider.dart';

/// @description： 用户相关信息
/// @author：liuzhidong
/// @date：2020/5/10 12:17
/// @version：1.0

class UserCountsVM extends ViewStateProvider {
  User _user = User();

  User get user => _user;

  set user(User s) {
    _user = s;
    notifyListeners();
  }

  UserCounts _userCounts = UserCounts();

  UserCounts get userCounts => _userCounts;

  set userCounts(UserCounts u) {
    _userCounts = u;
    notifyListeners();
  }

  //获取用户相关信息
  void getUserCounts() async {
    UserVM userVM = Provider.of<UserVM>(Application.context, listen: false);
    user = userVM.user;
    userCounts = await MakingFriendsApi.fetchGetUserCounts(user.id);
  }

  //获取指定用户相关信息
  void getAssignUserCounts(String userId) async {
    setBusy();
    try {
      userCounts = await MakingFriendsApi.fetchGetUserCounts(userId);
      setDef();
    } catch (e, s) {
      setError(e, s);
    }
  }
}
