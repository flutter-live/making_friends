import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

/// @description: 自定义图片 可高斯模糊
/// @author: liuzhidong
/// @date: 2020/3/31 16:14
/// @version: 1.0 

///自定义图片
class CommonImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final bool isFilter;
  final Function onTap;

  const CommonImage({
    Key key,
    @required this.image,
    this.height: 150,
    this.width: double.infinity,
    this.borderRadius: 5,
    this.margin: const EdgeInsets.only(left: 5, right: 5),
    this.isFilter: false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: ScreenUtil().setHeight(height),
        width: width == double.infinity ? width : ScreenUtil().setWidth(width),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: width == double.infinity
                  ? width
                  : ScreenUtil().setWidth(width),
              height: ScreenUtil().setHeight(height),
              margin: margin,
              child: SettingImage(image: 'assets/3.jpg', width: width, height: height, isFilter: isFilter, borderRadius: borderRadius,),
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
              ),
            )
          ],
        ),
      ),
    );
  }
}

///图片处理
class SettingImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final bool isFilter;
  final double borderRadius;

  const SettingImage({
    Key key,
    @required this.image,
    this.width,
    this.height,
    this.isFilter,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: <Widget>[
          Image.asset(
            image,
            width: width == double.infinity ? width : ScreenUtil().setWidth(width),
            height: ScreenUtil().setHeight(height),
            fit: BoxFit.fill,
          ),
          isFilter ? IFilter() : Container(),
        ],
      ),
    );
  }
}

///图片高斯模糊
class IFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
      child: Opacity(
        opacity: 0.7,
        child: new Container(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
    );
  }
}
