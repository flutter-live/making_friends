import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description: 底部弹出框
/// @author: liuzhidong
/// @date: 2020/4/2 13:47
/// @version: 1.0

Future customBottomSheet(context) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return _ShowBottomSheet();
    },
  );
}

///自定义内容
class _ShowBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.w,
      child: Column(
        children: <Widget>[
          Container(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4.w,
                mainAxisSpacing: 4.w,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
