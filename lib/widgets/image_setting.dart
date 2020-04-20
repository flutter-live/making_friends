import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @description： 图片加载
/// @author：liuzhidong
/// @date：2020/4/12 19:20
/// @version：1.0

enum ImageType {
  normal,
  assets, //资源目录
}

class HttpImage extends StatelessWidget {
  final double width;
  final double height;
  final double placeholderWidth;
  final double placeholderHeight;
  final double errorWidth;
  final double errorHeight;
  final Alignment alignment;
  final String url;
  final String errUrl;
  final double borderRadius;
  final BoxFit fit;

  const HttpImage({
    Key key,
    this.width,
    this.height,
    this.alignment: Alignment.centerLeft,
    this.url,
    this.placeholderWidth: 15,
    this.placeholderHeight: 15,
    this.errorWidth,
    this.errorHeight,
    this.errUrl,
    this.borderRadius: 5,
    this.fit: BoxFit.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          alignment: alignment,
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => Container(
            child: ImageHelper.placeHolder(height: placeholderHeight, width: placeholderWidth),
          ),
          errorWidget: (context, url, error) =>
              ImageHelper.error(url: errUrl),
        ),
    );
  }
}

class ImageHelper {
  static Widget placeHolder({double width, double height}) {
    return Container(
        width: width,
        height: height,
        child: CupertinoActivityIndicator(radius: min(width, height)));
  }

  static Widget error({double width, double height, double size, String url}) {
    return Container(
      alignment: Alignment.centerLeft,
      width: width,
      height: height,
      child: url == null
          ? Icon(
              Icons.error_outline,
              size: size,
            )
          : Image.asset(url),
    );
  }
}
