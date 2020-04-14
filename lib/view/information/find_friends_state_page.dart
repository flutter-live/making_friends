import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 互关， 关注， 粉丝
/// @author：liuzhidong
/// @date：2020/4/7 21:30
/// @version：1.0

class FindFriendsStatePage extends StatefulWidget {
  @override
  _FindFriendsStatePageState createState() => _FindFriendsStatePageState();
}

class _FindFriendsStatePageState extends State<FindFriendsStatePage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      itemBuilder: (BuildContext context, int index) {
        return HeadLine(
          isIcon: false,
//          leadingWidget: Container(
//            width: 70,
//            height: 70,
//            child: HttpImage(
//              url: article.user.userpic == null || article.user.userpic.isEmpty ? 'nothing.png' : article.user.userpic,
//              imageType: article.user.userpic == null || article.user.userpic.isEmpty ? ImageType.assets : ImageType.normal,
//              errUrl: 'assets/nothing.png',
//              borderRadius: 100,
//              placeholderWidth: 10,
//              placeholderHeight: 10,
//            ),
//          ),
          title: Text('18811475898'),
          titleWidget: Container(
            margin: EdgeInsets.only(left: 20.w),
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.w)),
              color: Colors.pinkAccent,
            ),
            child: Row(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.mars,
                  size: 25.sp,
                  color: Colors.white,
                ),
                Text(
                  '未知',
                  style:
                  TextStyle(fontSize: 22.sp, color: Colors.white),
                )
              ],
            ),
          ),
          onTop: () {},
        );
      },
      itemCount: 20,
    );
  }


}
