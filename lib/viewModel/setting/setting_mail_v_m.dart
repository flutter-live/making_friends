import 'package:flutter/material.dart';
import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/loading.dart';
import 'package:oktoast/oktoast.dart';

/// @description：绑定邮件
/// @author：liuzhidong
/// @date：2020/5/21 22:20
/// @version：1.0

class SettingMailVM extends ViewStateProvider {
  final UserVM userVM;
  String email;

  TextEditingController controller = TextEditingController();

  SettingMailVM(this.userVM) : assert(userVM != null) {
    if (userVM.user.email != null && userVM.user.email.isNotEmpty) {
      controller.text = userVM.user.email;
      email = userVM.user.email;
    }
  }

  ///绑定邮箱
  Future bindEmail() async {
    setBusy();
    try {
      var res = await MakingFriendsApi.fetchBindEmail(email: email);
      if (res.length == 0) {
        userVM.setUser(userVM.user..email = email);
      }else{
        showToast(res['msg'],
            textPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            radius: 5,
            backgroundColor: Colors.black87);
        ProgressDialog.dismiss();
        return;
      }
      setDef();
    } catch (e, s) {
      setError(e, s);
      return '';
    }
  }
}
