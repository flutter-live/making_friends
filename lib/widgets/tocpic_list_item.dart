import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'custom_image.dart';

/// @description: 话题列表部件
/// @author: liuzhidong
/// @date: 2020/3/31 12:16
/// @version: 1.0

class TocpicListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final int devNumber;
  final int devDayNumber;
  final String image;
  final Function onTap;

  const TocpicListItem({
    Key key,
    this.title,
    this.subtitle,
    this.devNumber,
    this.devDayNumber,
    this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CommonImage(
                width: 200,
                height: 150,
                image: 'assets/3.jpg',
              ),
              TocpicListTile(
                title: title,
                subtitle: subtitle,
                devNumber: devDayNumber,
                devDayNumber: devDayNumber,
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class TocpicListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int devNumber;
  final int devDayNumber;

  const TocpicListTile({
    Key key,
    @required this.title,
    @required this.subtitle,
    this.devNumber: 0,
    this.devDayNumber: 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: TextStyle(fontSize: ScreenUtil().setSp(34)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.grey, fontSize: ScreenUtil().setSp(30)),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '动态 $devNumber',
                    style: TextStyle(
                        color: Colors.grey, fontSize: ScreenUtil().setSp(30)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    '今日 $devDayNumber',
                    style: TextStyle(
                        color: Colors.grey, fontSize: ScreenUtil().setSp(30)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
