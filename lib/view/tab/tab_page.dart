import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/viewModel/tab/tab_v_m.dart';

/// @description： tab
/// @author：liuzhidong
/// @date：2020/3/28 17:24
/// @version：1.0

// ignore: must_be_immutable
class TabPage extends StatelessWidget {
  PageController _pageController;
  DateTime _lastPressed;

  @override
  Widget build(BuildContext context) {
    //适配
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    _pageController = PageController(initialPage: 0);

    return ProviderWidget<TabVM>(
      model: TabVM(),
      builder: (context, model, child) {
        return Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              if (_lastPressed == null ||
                  DateTime.now().difference(_lastPressed) >
                      Duration(seconds: 1)) {
                //两次点击间隔超过1秒则重新计时
                _lastPressed = DateTime.now();
                return false;
              }
              return true;
            },
            child: PageView(
              children: model.pages,
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                if (index == 2) return;
                model.setIndex(index);
              },
            ),
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                primaryColor: Theme.of(context).primaryColor),
            child: BottomNavigationBar(
                selectedLabelStyle: TextStyle(color: Colors.pinkAccent),
                type: BottomNavigationBarType.fixed,
                items: model.navigtionBars
                    .map((item) => BottomNavigationBarItem(
                        icon: Icon(item.icon), title: Text(item.name)))
                    .toList(),
                currentIndex: model.selectedIndex,
                onTap: (index) {
                  if (index == 2) return;
                  _pageController.jumpToPage(index);
                }),
          ),
          floatingActionButton: Container(
            padding: EdgeInsets.all(5),
            width: 65,
            height: 65,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: <BoxShadow>[
                  //设置阴影
                  new BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 10,
                  ),
                ]),
            child: FloatingActionButton(
              highlightElevation: 0,
              elevation: 0,
              onPressed: () {
                Jump.push('release/release_page',
                    transition: TransitionType.inFromBottom);
              },
              child: Icon(Icons.add),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
