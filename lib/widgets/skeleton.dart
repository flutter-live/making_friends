import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// @description： 骨架屏封装
/// @author：liuzhidong
/// @date：2020/3/28 14:36
/// @version：1.0

/// 骨架屏 元素背景 ->形状及颜色
class SkeletonDecoration extends BoxDecoration {
  SkeletonDecoration({
    isCircle: false,
    isDark: false,
  }) : super(
    color: !isDark ? Colors.grey[350] : Colors.grey[700],
    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
  );
}

class Skeleton extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final int length;
  final IndexedWidgetBuilder betweeChild;
  final Widget headChild;
  final Widget footerChild;

  Skeleton(
      {this.length: 10, //一般屏幕长度够用
        this.padding = const EdgeInsets.all(7),
        @required this.betweeChild,
        this.headChild,
        this.footerChild});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        period: Duration(milliseconds: 600),
        baseColor: isDark ? Colors.grey[700] : Colors.grey[350],
        highlightColor: isDark ? Colors.grey[500] : Colors.grey[200],
        child: Padding(
          padding: padding,
          child: Column(
            children: <Widget>[
              headChild ?? Container(),
              betweeChild == null ? Container() : Column(
                children:
                List.generate(length, (index) => betweeChild(context, index)),
              ),
              footerChild ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}
