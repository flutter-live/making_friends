import 'package:flutter/material.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/widgets/custom_division_line.dart';
import 'package:makingfriends/widgets/list_item.dart';

/// @description： 搜索到的内容
/// @author：liuzhidong
/// @date：2020/4/2 18:41
/// @version：1.0

class SearchContent extends StatelessWidget {
  final String query;

  const SearchContent({Key key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListItem(
                onTap: () {
                  Jump.push('view/community/community_details_page');
                },
              ),
              DivisionLine()
            ],
          );
        });
  }
}
