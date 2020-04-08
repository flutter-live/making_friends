import 'package:flutter/material.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';

/// @description: 描述
/// @author: liuzhidong
/// @date: 2020/4/3 10:36
/// @version: 1.0 

class MyListItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          HeadLine(
            leadingWidget: Icon(
              Icons.visibility,
              color: Colors.pinkAccent,
            ),
            title: Text('浏览历史'),
          ),
          HeadLine(
            leadingWidget: Icon(
              Icons.beenhere,
              color: Colors.pinkAccent,
            ),
            title: Text('社区认证'),
          ),
          HeadLine(
            leadingWidget: Icon(
              Icons.library_books,
              color: Colors.pinkAccent,
            ),
            title: Text('审核帖子'),
          ),
        ],
      ),
    );
  }
}
