import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:makingfriends/model/tab_bottom_navigtion_bar.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/viewModel/infromation/web_socket_chat.dart';
import 'package:makingfriends/viewModel/tab/tab_v_m.dart';
import 'package:provider/provider.dart';

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
              physics: const NeverScrollableScrollPhysics(),
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
              items: List.generate(model.navigtionBars.length, (index) {
                if (index == 3) {
                  return BottomNavigationBarItem(
                    icon: InfromationIcon(model: model.navigtionBars[index]),
                    title: Text(model.navigtionBars[index].name),
                  );
                }
                return BottomNavigationBarItem(
                  icon: Icon(model.navigtionBars[index].icon),
                  title: Text(model.navigtionBars[index].name),
                );
              }),
              currentIndex: model.selectedIndex,
              onTap: (index) {
                if (index == 2) return;
                _pageController.jumpToPage(index);
              },
            ),
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

///消息图标
class InfromationIcon extends StatelessWidget {
  final TaBottomNavigtionBar model;

  const InfromationIcon({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Icon(model.icon),
          Positioned(
            left: 15,
            top: -5,
            child: Container(
              padding: const EdgeInsets.all(1),
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
              constraints: const BoxConstraints(
                minWidth: 15,
                minHeight: 15,
              ),
              child: Badge(),
            ),
          ),
        ],
      ),
    );
  }
}

///未读信息
class Badge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WebSocketChat>(builder: (context, model, child) {
      String total =
          model.total > 99 ? '${model.total}+' : model.total.toString();
      return Text(
        total,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      );
    });
  }
}
