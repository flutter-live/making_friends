import 'package:flutter/material.dart';
import 'package:makingfriends/widgets/cirle_avatar_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description: 评论
/// @author: liuzhidong
/// @date: 2020/4/2 11:04
/// @version: 1.0

class CustomComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ///头像
          CircleAvatarImage(
            width: 80,
          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  '18811475898',
                  style: TextStyle(color: Colors.blue, letterSpacing: 1.5.w),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5.w, top: 5.w),
                child: Text(
                  '我是一直笑笑',
                  style: TextStyle(letterSpacing: 1.5.w, height: 2.w),
                ),
              ),
              Container(
                child: Text(
                  '2017-09-27 下午 2：08',
                  style: TextStyle(color: Colors.grey, fontSize: 22.sp),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.w),
                child: SecondComment(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.w),
                child: SecondComment(),
              ),
              // CustomComment(),
            ],
          )
        ],
      ),
    );
  }
}

///二级聊天
class SecondComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ///头像
              CircleAvatarImage(
                width: 40,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10.w,
                ),
                child: Text(
                  '18811475898',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 50.w, bottom: 10.w, top: 5.w),
            child: Text(
              '我是一直笑笑',
              style: TextStyle(letterSpacing: 1.5.w, height: 1.w),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 50.w),
            child: Text(
              '2017-09-27 下午 2：08',
              style: TextStyle(color: Colors.grey, fontSize: 22.sp),
            ),
          ),
          // CustomComment(),
        ],
      ),
    );
  }
}
