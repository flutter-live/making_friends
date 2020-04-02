import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'community_page.dart';
import 'information_page.dart';
import 'my_page.dart';
import 'trends_page.dart';

/// @description： tab
/// @author：liuzhidong
/// @date：2020/3/28 17:24
/// @version：1.0

List<Widget> pages = <Widget>[
  CommunityPage(),
  TrendsPage(),
  InformationPage(),
  MyPage()
];

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  DateTime _lastPressed;

  @override
  Widget build(BuildContext context) {
    //适配
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView(
          children: pages,
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('社区'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('动态'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              title: Text('消息'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              title: Text('我的'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index){
            _pageController.jumpToPage(index);

          }
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }
}
