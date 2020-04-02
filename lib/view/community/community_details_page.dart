import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/widgets/custom_comment.dart';
import 'package:makingfriends/widgets/custom_division_line.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:makingfriends/widgets/list_item.dart';

/// @description: 社区内容详情页
/// @author: liuzhidong
/// @date: 2020/4/2 10:40
/// @version: 1.0

class CommunityDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '这是一个动态益出限制标题',
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListItem(),
          DivisionLine(),
          Container(
            child: Column(
              children: <Widget>[
                HeadLine(
                  title: '最新评论 3',
                  isIcon: false,
                ),
                CustomComment(),
                CustomComment(),
                CustomComment(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
