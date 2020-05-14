import 'package:flutter/material.dart' hide showSearch;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/flutter/search.dart';
import 'package:makingfriends/view/information/find_friends_state_page.dart';
import 'package:makingfriends/view/search/search_page.dart';

/// @description： 查找好友
/// @author：liuzhidong
/// @date：2020/4/7 20:59
/// @version：1.0

class FindFriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: DefaultSearchDelegate(hintText: '查找好友'));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                color: Colors.white70,
              ),
              width: 750.w,
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.black26,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      '搜索用户',
                      style: TextStyle(color: Colors.black26, fontSize: 24.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: '互关'),
              Tab(text: '关注'),
              Tab(text: '粉丝'),
            ],
          ),
        ),
        body: TabBarView(
            children: <Widget>[
              FindFriendsStatePage(),
              FindFriendsStatePage(),
              FindFriendsStatePage(),
            ],
        ),
      ),
    );
  }
}
