import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description: HeadLine
/// @author: liuzhidong
/// @date: 2020/3/31 16:14
/// @version: 1.0

class HeadLine extends StatelessWidget {
  final String title;
  final Widget titleWidget;
  final Widget leadingWidget;
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
    this.titleSize: 32,
    this.trailing,
    this.trailingSize,
    this.subtitle,
    this.subtitleSize: 26,
    this.icon: Icons.chevron_right,
    this.iconSize,
    this.leadingWidget,
    this.trailingWidget,
    this.onTop,
    this.isIcon: true,
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onTop == null
        ? CoustomHeadLine(
            title: title,
            trailingWidget: trailingWidget,
            leadingWidget: leadingWidget,
            titleSize: titleSize,
            trailing: trailing,
            trailingSize: trailingSize,
            subtitle: subtitle,
            subtitleSize: subtitleSize,
            isIcon: isIcon,
            icon: icon,
            iconSize: iconSize,
            titleWidget: titleWidget,
          )
        : Material(
            child: InkWell(
              child: CoustomHeadLine(
                title: title,
                trailingWidget: trailingWidget,
                leadingWidget: leadingWidget,
                titleSize: titleSize,
                trailing: trailing,
                trailingSize: trailingSize,
                subtitle: subtitle,
                subtitleSize: subtitleSize,
                isIcon: isIcon,
                icon: icon,
                iconSize: iconSize,
                titleWidget: titleWidget,
              ),
              onTap: onTop,
            ),
          );
  }
}

class CoustomHeadLine extends StatelessWidget {
  final String title;
  final Widget titleWidget;
  final Widget leadingWidget;
  final double titleSize;
  final String trailing;
  final Widget trailingWidget;
  final double trailingSize;
  final String subtitle;
  final double subtitleSize;
  final IconData icon;
  final bool isIcon;
  final double iconSize;

  const CoustomHeadLine({
    Key key,
    this.title,
    this.titleWidget,
    this.leadingWidget,
    this.titleSize,
    this.trailing,
    this.trailingWidget,
    this.trailingSize,
    this.subtitle,
    this.subtitleSize,
    this.icon,
    this.isIcon,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              leadingWidget == null
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(right: 20.w),
                      child: leadingWidget,
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(fontSize: titleSize.sp),
                      ),
                      titleWidget ?? Container(),
                    ],
                  ),
                  subtitle == null
                      ? Container()
                      : Container(
                          child: Text(
                            subtitle,
                            style: TextStyle(
                                fontSize: subtitleSize.sp,
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
    );
  }
}
