import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import '../../config/string.dart';

/// @description： 关于
/// @author：liuzhidong
/// @date：2020/4/6 14:58
/// @version：1.0

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleConfig.ABOUT_PAGE_TITLR),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40.w),
              alignment: Alignment.center,
//              child: Container(
//                width: 250,
//                height: 250,
//                child: HttpImage(
//                  url: article.user.userpic == null || article.user.userpic.isEmpty ? 'nothing.png' : article.user.userpic,
//                  imageType: article.user.userpic == null || article.user.userpic.isEmpty ? ImageType.assets : ImageType.normal,
//                  errUrl: 'assets/nothing.png',
//                  borderRadius: 100,
//                  placeholderWidth: 10,
//                  placeholderHeight: 10,
//                ),
//              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text('version 1.12'),
            ),
            SizedBox(height: 50.h,),
            HeadLine(
              title: Text('新版本检测'),
              titleSize: 30,
              onTop: () {
              },
            ),
            HeadLine(
              title: Text('社区用户协议'),
              titleSize: 30,
              onTop: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
