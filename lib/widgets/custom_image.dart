import 'dart:ui';
import 'package:flutter/material.dart';
import 'image_setting.dart';

/// @description: 自定义图片 可高斯模糊
/// @author: liuzhidong
/// @date: 2020/3/31 16:14
/// @version: 1.0

///自定义图片
class CommonImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final bool isType;
  final double borderRadius;
  final bool isFilter;
  final Function onTap;
  final BoxFit fit;

  const CommonImage({
    Key key,
    @required this.image,
    this.height: 120,
    this.width,
    this.borderRadius: 5,
    this.isFilter: false,
    this.onTap,
    this.isType: true,
    this.fit: BoxFit.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: <Widget>[
          SettingImage(
            image: image,
            width: width,
            height: height,
            isFilter: isFilter,
            borderRadius: borderRadius,
            isType: isType,
            fit: fit,
          ),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
            ),
          )
        ],
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
  final bool isType;
  final double borderRadius;
  final BoxFit fit;

  const SettingImage({
    Key key,
    @required this.image,
    this.width,
    this.height,
    this.isFilter,
    this.borderRadius,
    this.isType,
    this.fit: BoxFit.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        isType
            ? HttpImage(
                width: width,
                height: height,
                url: image,
                errUrl: 'assets/nothing.png',
                borderRadius: borderRadius,
                alignment: Alignment.center,
                fit: fit,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image.asset(
                  image,
                  height: height,
                  width: width,
                  fit: BoxFit.fill,
                ),
              ),
        isFilter
            ? IFilter(
                borderRadius: borderRadius,
              )
            : Container(),
      ],
    );
  }
}

///图片高斯模糊
class IFilter extends StatelessWidget {
  final double borderRadius;

  const IFilter({Key key, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
        child: Opacity(
          opacity: 0.7,
          child: new Container(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
