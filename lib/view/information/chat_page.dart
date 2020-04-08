import 'package:flutter/material.dart';
import 'package:makingfriends/view/information/triangle_custom_painter_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/widgets/cirle_avatar_image.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'dart:math' as math;

/// @description： 聊天
/// @author：liuzhidong
/// @date：2020/4/7 21:00
/// @version：1.0

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('社区交友'),
        actions: <Widget>[IconButton(icon: Icon(Icons.list), onPressed: () {})],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 40.w),
                  children: <Widget>[
                    LeftChat(),
                    RightChat(),
                    LeftChat(),
                    RightChat(),
                    LeftChat(),
                    RightChat(),
                    RightChat(),
                    RightChat(),
                    RightChat(),
                    RightChat(),
                    LeftChat(),
                    RightChat(),
                    LeftChat(),
                    RightChat(),
                    LeftChat(),
                    RightChat(),
                    RightChat(),
                    RightChat(),
                    RightChat(),
                    RightChat(),

                  ],
                ),
              ),
              Container(
                height: 80.h,
                child: ChatInputVBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

///左侧聊天
class LeftChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: HeadLine(
          leadingWidgetRight: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          isIcon: false,
          leadingWidget: CircleAvatarImage(
            width: 60,
            height: 60,
          ),
          title: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10, bottom: 10),
                child: CustomPaint(
                  painter: TriangleCustomPainter(color: Colors.grey[300]),
                ),
              ),
              Container(
                child: Container(
                  width: 450.w,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(10.w))),
                  child: Text('dasdsdsdasdasdsdasda'),
                ),
              )
            ],
          )),
    );
  }
}

///右侧聊天
class RightChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: HeadLine(
        crossAxisAlignment: CrossAxisAlignment.start,
        isIcon: false,
        title: Container(),
        trailingWidget: Container(
          child: Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Container(
                      width: 450.w,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.w, horizontal: 10.w),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.w))),
                      child: Text(
                        'dasdsdsdasdasdsdasda',
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.w,
                            fontSize: 32.sp),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 10.w),
                child: Transform.rotate(
                  angle: math.pi,
                  child: Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    child: CustomPaint(
                      painter: TriangleCustomPainter(
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
              CircleAvatarImage(
                width: 60,
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}

///输入框
class ChatInputVBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                right: 20.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.grey[300],
              ),
              height: 50.h,
              child: TextField(
                scrollPadding: EdgeInsets.all(0),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(bottom: 30.w, left: 30.w, top: 5.w),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            child: MaterialButton(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              minWidth: 110.w,
              height: 50.h,
              onPressed: () {},
              child: Text(
                '发送',
                style: TextStyle(color: Colors.white, fontSize: 26.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}
