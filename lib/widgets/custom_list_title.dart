import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

/// @description: 描述
/// @author: liuzhidong
/// @date: 2020/3/31 16:14
/// @version: 1.0 

/// titleWidget
///
/// Container(
///   margin: EdgeInsets.only(right: 10),
///   height: ScreenUtil().setHeight(60),
///   width: ScreenUtil().setHeight(60),
///   child: CircleAvatar(
///     child: Image.asset('assets/default.png'),
///   ),
/// ),
///
///自定义ListTitle
///

class HeadLine extends StatelessWidget {
  final String title;
  final Widget titleWidget;
  final double titleSize;
  final String trailing;
  final Widget trailingWidget;
  final double trailingSize;
  final String subtitle;
  final double subtitleSize;
  final IconData icon;
  final bool isIcon;
  final double iconSize;
  final Function onTop;

  const HeadLine({
    Key key,
    @required this.title,
    this.titleSize: 34,
    this.trailing,
    this.trailingSize,
    this.subtitle,
    this.subtitleSize: 26,
    this.icon: Icons.chevron_right,
    this.iconSize,
    this.titleWidget,
    this.trailingWidget,
    this.onTop,
    this.isIcon: true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  titleWidget ?? Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style:
                        TextStyle(fontSize: ScreenUtil().setSp(titleSize)),
                      ),
                      subtitle == null
                          ? Container()
                          : Container(
                        child: Text(
                          subtitle,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(subtitleSize),
                              color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              trailingWidget ??
                  Row(
                    children: <Widget>[
                      trailing == null
                          ? Container()
                          : Text(
                        trailing,
                        style: TextStyle(color: Colors.grey),
                      ),
                      isIcon
                          ? Icon(
                        icon,
                        color: Colors.grey,
                      )
                          : Container()
                    ],
                  ),
            ],
          ),
        ),
        onTap: onTop,
      ),
    );
  }
}