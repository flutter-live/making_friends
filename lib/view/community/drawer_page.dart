import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:makingfriends/view/my/my_head_page.dart';
import 'package:makingfriends/view/my/my_list_item_page.dart';
import 'package:makingfriends/widgets/custom_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 抽屉
/// @author：liuzhidong
/// @date：2020/3/29 11:41
/// @version：1.0

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).padding.top;
    return Drawer(
      child: Column(
        children: <Widget>[
          Head(height: _height),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          CommonImage(
            image: 'assets/3.jpg',
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          MyListItemPage(),
        ],
      ),
    );
  }
}

class Head extends StatelessWidget {
  final double height;

  const Head({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          CommonImage(
            image: 'assets/1.jpg',
            height: 450.h,
            margin: EdgeInsets.all(0),
            borderRadius: 0,
            isFilter: true,
          ),
          Container(
            margin: EdgeInsets.only(top: height, bottom: 20),
            child: MyHead(),
          ),
        ],
      ),
    );
  }
}
