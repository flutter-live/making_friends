import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 昵称，职业，情感
/// @author：liuzhidong
/// @date：2020/4/6 17:46
/// @version：1.0

class EditingFromPage extends StatelessWidget {
  final String title;
  final String hintText;

  const EditingFromPage({Key key, this.title, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        margin: EdgeInsets.all(20.w),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 26.sp),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 40.w),
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  '完成',
                  style: TextStyle(
                    fontSize: 32.sp,
                    letterSpacing: 10.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
