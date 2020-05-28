import 'package:flutter/material.dart';
import 'package:makingfriends/model/UserCounts.dart';

/// @description：其他关联信息
/// @author：liuzhidong
/// @date：2020/5/17 18:33
/// @version：1.0

class MyRelation extends StatelessWidget {
  final UserCounts userCounts;

  const MyRelation({Key key, this.userCounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: <Widget>[
                Text(
                  userCounts.postCount.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '总帖子',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: <Widget>[
                Text(
                  userCounts.withfenCount.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                SizedBox(width: 5),
                Text(
                  '粉丝',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Row(
              children: <Widget>[
                Text(
                  userCounts.withfollowCount.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                SizedBox(width: 5),
                Text(
                  '关注',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
