import 'package:flutter/material.dart';

/// @description： 三角
/// @author：liuzhidong
/// @date：2020/4/8 20:58
/// @version：1.0

class TriangleCustomPainter extends CustomPainter {
  final Color color;
  TriangleCustomPainter({this.color});


  @override
  void paint(Canvas canvas, Size size) {
    ///定义画笔
    Paint _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    ///画路径
    Path path = Path()
      ..moveTo(0, 5)
      ..lineTo(12, 0)
      ..lineTo(12, 10);

    ///生成
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}