import 'package:flutter/material.dart';
import 'package:makingfriends/widgets/list_item.dart';

/// @description: 描述
/// @author: liuzhidong
/// @date: 2020/4/1 14:43
/// @version: 1.0 

class TocpicDetailsItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ListView(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.all(0),
      children: <Widget>[
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem()
      ],
    );
  }
}
