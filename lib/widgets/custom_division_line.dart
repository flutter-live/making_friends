import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description: 描述
/// @author: liuzhidong
/// @date: 2020/3/31 16:18
/// @version: 1.0 

///统一分割
class DivisionLine extends StatelessWidget {
  final double height;

  const DivisionLine({Key key, this.height: 15}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.w,
      color: Color.fromRGBO(245, 245, 245, 1),
      width: double.infinity,
    );
  }
}