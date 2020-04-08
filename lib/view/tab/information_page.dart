import 'package:flutter/material.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/widgets/cirle_avatar_image.dart';
import 'package:makingfriends/widgets/custom_dialog.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import '../../config/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 消息
/// @author：liuzhidong
/// @date：2020/3/28 17:45
/// @version：1.0

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).padding.top;
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person_add),
          onPressed: () {
            Jump.push('information/find_friends_page');
          },
        ),
        title: Text(TitleConfig.INFORMATION_TITLE),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.view_list),
            onPressed: () async {
              final result = await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(750.w, h, 0.0, 0.0),
                items: <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                    value: '0',
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: Text('添加好友'),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: '1',
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('清除列表'),
                    ),
                  ),
                ],
              );
              print(result);
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        itemBuilder: (BuildContext context, int index) {
          return HeadLine(
            isIcon: false,
            leadingWidget: CircleAvatarImage(
              width: 80,
            ),
            title: Text('18811475898'),
            subtitle: '2019-06-30 下午 9：16',
            trailingWidget: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '下午 6：10',
                    style: TextStyle(color: Colors.black54, fontSize: 22.sp),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.w),
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: Text(
                      '12',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                  )
                ],
              ),
            ),
            onTop: () {
              Jump.push('information/chat_page');
            },
          );
        },
        itemCount: 20,
      ),
    );
  }
}
