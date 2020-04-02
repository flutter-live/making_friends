import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description: 头像
/// @author: liuzhidong
/// @date: 2020/4/2 11:21
/// @version: 1.0

class CircleAvatarImage extends StatelessWidget {
  final double width;
  final BoxFit fit;

  const CircleAvatarImage({
    Key key,
    this.width = 80,
    this.fit = BoxFit.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      child: CircleAvatar(
        child: Image.asset(
          'assets/default.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
