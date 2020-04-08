import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description: HeadLine
/// @author: liuzhidong
/// @date: 2020/3/31 16:14
/// @version: 1.0

class HeadLine extends StatelessWidget {
  final Widget title;
  final Widget titleWidget;
  final Widget leadingWidget;
  final double leadingWidgetRight;
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
  final bool isRipple; //是否禁用水波纹
  final CrossAxisAlignment crossAxisAlignment;

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
    this.leadingWidgetRight: 20,
    this.trailingWidget,
    this.onTop,
    this.isIcon: true,
    this.titleWidget,
    this.isRipple: true,
    this.crossAxisAlignment: CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onTop == null
        ? CoustomHeadLine(
            title: title,
            trailingWidget: trailingWidget,
            leadingWidget: leadingWidget,
            leadingWidgetRight: leadingWidgetRight,
            titleSize: titleSize,
            trailing: trailing,
            trailingSize: trailingSize,
            subtitle: subtitle,
            subtitleSize: subtitleSize,
            isIcon: isIcon,
            icon: icon,
            iconSize: iconSize,
            titleWidget: titleWidget,
            crossAxisAlignment: crossAxisAlignment)
        : Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: isRipple ? null : Colors.transparent,
              splashColor: isRipple ? null : Colors.transparent,
              child: CoustomHeadLine(
                  title: title,
                  trailingWidget: trailingWidget,
                  leadingWidget: leadingWidget,
                  leadingWidgetRight: leadingWidgetRight,
                  titleSize: titleSize,
                  trailing: trailing,
                  trailingSize: trailingSize,
                  subtitle: subtitle,
                  subtitleSize: subtitleSize,
                  isIcon: isIcon,
                  icon: icon,
                  iconSize: iconSize,
                  titleWidget: titleWidget,
                  crossAxisAlignment: crossAxisAlignment),
              onTap: onTop,
            ),
          );
  }
}

class CoustomHeadLine extends StatelessWidget {
  final Widget title;
  final Widget titleWidget;
  final Widget leadingWidget;
  final double leadingWidgetRight;
  final double titleSize;
  final String trailing;
  final Widget trailingWidget;
  final double trailingSize;
  final String subtitle;
  final double subtitleSize;
  final IconData icon;
  final bool isIcon;
  final double iconSize;
  final CrossAxisAlignment crossAxisAlignment;

  const CoustomHeadLine({
    Key key,
    this.title,
    this.titleWidget,
    this.leadingWidget,
    this.leadingWidgetRight,
    this.titleSize,
    this.trailing,
    this.trailingWidget,
    this.trailingSize,
    this.subtitle,
    this.subtitleSize,
    this.icon,
    this.isIcon,
    this.iconSize,
    this.crossAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: crossAxisAlignment,
            children: <Widget>[
              leadingWidget == null
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(right: leadingWidgetRight.w),
                      child: leadingWidget,
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      DefaultTextStyle(
                        style: TextStyle(
                            fontSize: titleSize.sp,
                            letterSpacing: 1.w,
                            color: Colors.black),
                        child: title,
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
          Row(
            children: <Widget>[
              trailingWidget == null
                  ? trailing == null
                      ? Container()
                      : Text(
                          trailing,
                          style: TextStyle(color: Colors.grey),
                        )
                  : trailingWidget,
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
