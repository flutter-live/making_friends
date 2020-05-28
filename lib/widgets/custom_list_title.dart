import 'package:flutter/material.dart';

/// @description: HeadLine
/// @author: liuzhidong
/// @date: 2020/3/31 16:14
/// @version: 1.0

class HeadLine extends StatelessWidget {
  final Widget title;
  final EdgeInsetsGeometry contentPadding;
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
    this.titleSize: 17,
    this.trailing,
    this.trailingSize,
    this.subtitle,
    this.subtitleSize: 14,
    this.icon: Icons.chevron_right,
    this.iconSize,
    this.leadingWidget,
    this.leadingWidgetRight: 10,
    this.trailingWidget,
    this.onTop,
    this.isIcon: true,
    this.titleWidget,
    this.isRipple: true,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: isRipple ? null : Colors.transparent,
        splashColor: isRipple ? null : Colors.transparent,
        child: CoustomHeadLine(
          headLine: this,
        ),
        onTap: onTop,
      ),
    );
  }
}

class CoustomHeadLine extends StatelessWidget {
  final HeadLine headLine;

  const CoustomHeadLine({
    Key key,
    this.headLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: headLine.contentPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: headLine.crossAxisAlignment,
            children: <Widget>[
              headLine.leadingWidget == null
                  ? Container()
                  : Container(
                      margin:
                          EdgeInsets.only(right: headLine.leadingWidgetRight),
                      child: headLine.leadingWidget,
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      DefaultTextStyle(
                        style: TextStyle(
                            fontSize: headLine.titleSize,
                            color: Colors.black87),
                        child: headLine.title,
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                            fontSize: headLine.titleSize,
                            color: Colors.black87),
                        child: headLine.titleWidget ?? Container(),
                      ),
                    ],
                  ),
                  headLine.subtitle == null
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(top: 3),
                          child: Text(
                            headLine.subtitle,
                            style: TextStyle(
                                fontSize: headLine.subtitleSize,
                                color: Colors.black54),
                          ),
                        )
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              headLine.trailingWidget == null
                  ? headLine.trailing == null
                      ? Container()
                      : Text(
                          headLine.trailing,
                          style: TextStyle(color: Colors.grey),
                        )
                  : headLine.trailingWidget,
              headLine.isIcon
                  ? Icon(
                      headLine.icon,
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
