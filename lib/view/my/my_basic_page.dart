import 'package:flutter/material.dart';
import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/widgets/image_setting.dart';

/// @description：我的详细基本信息资料
/// @author：liuzhidong
/// @date：2020/5/17 18:28
/// @version：1.0

class MyBasicPage extends StatelessWidget {
  final User user;

  const MyBasicPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              user.username,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '职业',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Text(
                        user.userinfo.job ?? '无',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '故乡',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Text(
                        user.userinfo.path ?? '无',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///我的基本信息头像
class MyAvatarPage extends StatelessWidget {
  final User user;

  const MyAvatarPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Theme.of(context).accentColor,
      ),
      child: Container(
        width: 60,
        height: 60,
        child: HttpImage(
          url: user.userpic == null || user.userpic.isEmpty
              ? 'nothing.png'
              : user.userpic,
          errUrl: 'assets/nothing.png',
          borderRadius: 100,
          placeholderWidth: 10,
          placeholderHeight: 10,
        ),
      ),
    );
  }
}
