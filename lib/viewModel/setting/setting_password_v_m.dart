import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';

/// @description： 修改密码
/// @author：liuzhidong
/// @date：2020/5/21 21:12
/// @version：1.0

class SettingPassWordVM extends ViewStateProvider {
  final UserVM userVM;

  String newPassword;
  String renewPassword;
  String oldPassword;
  bool isPassword = false;

  SettingPassWordVM(this.userVM) : assert(userVM != null) {
    print(userVM.user.password);
    isPassword = userVM.user.password;
  }

  ///修改密码
  Future rePasswordSubmitted() async {
    setBusy();
    try {
      var res = await MakingFriendsApi.fetchRePassword(oldPassword: oldPassword, newPassword: newPassword, renewPassword: renewPassword);
      if(res.length == 0){
        userVM.setUser(userVM.user..password = true);
      }
      setDef();
    } catch (e, s) {
      setError(e, s);
      return '';
    }
  }
}
