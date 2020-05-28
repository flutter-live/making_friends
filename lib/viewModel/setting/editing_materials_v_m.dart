import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';

/// @description： 修改资料
/// @author：liuzhidong
/// @date：2020/5/23 14:57
/// @version：1.0

class EditingMaterialsVM extends ViewStateProvider {
  final UserVM userVM;

  EditingMaterialsVM(this.userVM) {
    user = userVM.user;
  }

  User _user = User();

  User get user => _user;

  set user(User u) {
    _user = u;
    notifyListeners();
  }
}
