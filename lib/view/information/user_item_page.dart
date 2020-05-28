import 'package:flutter/material.dart';
import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:makingfriends/widgets/image_setting.dart';

/// @description： 好友item
/// @author：liuzhidong
/// @date：2020/5/24 22:26
/// @version：1.0

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeadLine(
      isIcon: false,
      contentPadding:
      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      leadingWidget: Container(
        width: 30,
        height: 30,
        child: HttpImage(
          url: user.userpic == null ||
              user.userpic.isEmpty
              ? 'nothing.png'
              : user.userpic,
          errUrl: 'assets/nothing.png',
          borderRadius: 100,
          placeholderWidth: 10,
          placeholderHeight: 10,
        ),
      ),
      title: Text(user.username),
      titleWidget: Container(
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          color: Colors.pinkAccent,
        ),
        child: Text(
          user.userinfo.qg == 0
              ? '保密'
              : (user.userinfo.qg == 1
              ? '未婚'
              : '已婚'),
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
      onTop: () {
        bool isFollow = false;
        if(user?.fens != null){
          isFollow = user.fens.length > 0 ? true : false;
        }
        Jump.push('view/my/my_details_page?id=${user.id}&&isFollow=$isFollow');
      },
    );
  }
}
