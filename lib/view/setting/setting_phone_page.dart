import 'package:flutter/material.dart';
import '../../config/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 手机
/// @author：liuzhidong
/// @date：2020/4/6 15:56
/// @version：1.0

class SettingPhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleConfig.SETTING_PHONE_TITLE),
      ),
      body: Container(
        margin: EdgeInsets.all(20.w),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: TextField(
                        decoration: InputDecoration(
                          icon: Container(
                            child: Text('+86'),
                          ),
                          hintText: '手机号',
                          hintStyle: TextStyle(fontSize: 26.sp),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.w),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '请输入验证码',
                          hintStyle: TextStyle(fontSize: 26.sp),
                          suffixIcon: Container(
                            padding: EdgeInsets.symmetric(vertical: 15.w),
                              child: GestureDetector(
                                child: Container(
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5.w)),
                                    color: Colors.pinkAccent,
                                  ),
                                  child: Text('获取验证码', style: TextStyle(color: Colors.white),),
                                ),
                                onTap: (){
                                },
                              ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 40.w),
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  '绑定',
                  style: TextStyle(
                    fontSize: 32.sp,
                    letterSpacing: 5.w,
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
