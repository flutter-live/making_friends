import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:makingfriends/widgets/image_setting.dart';
import 'package:provider/provider.dart';

/// @description: 登陆后头像信息
/// @author: liuzhidong
/// @date: 2020/4/3 10:41
/// @version: 1.0

class MyHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserVM>(
      builder: (context, model, child) {
        return Column(
          children: <Widget>[
            HeadLine(
              isRipple: false,
              leadingWidget: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: HttpImage(
                  url: model.user.userpic ?? 'assets/wb.png',
                  errUrl: 'assets/wb.png',
                  borderRadius: 100,
                  placeholderWidth: 10,
                  placeholderHeight: 10,
                ),
              ),
              title: Text(model.user.username),
              subtitle: '总帖子1 今日发贴0',
              isIcon: false,
              onTop: () {
                Jump.push('view/my/my_details_page');
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '帖子',
                        style: TextStyle(
                          fontSize: 28.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '动态',
                        style: TextStyle(
                          fontSize: 28.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '评论',
                        style: TextStyle(
                          fontSize: 28.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '粉丝',
                        style: TextStyle(
                          fontSize: 28.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
