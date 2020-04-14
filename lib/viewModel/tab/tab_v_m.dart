import 'package:flutter/material.dart';
import 'package:makingfriends/model/tab_bottom_navigtion_bar.dart';
import 'package:makingfriends/view/tab/community_page.dart';
import 'package:makingfriends/view/tab/information_page.dart';
import 'package:makingfriends/view/tab/my_page.dart';
import 'package:makingfriends/view/tab/trends_page.dart';

/// @description： tab
/// @author：liuzhidong
/// @date：2020/4/12 11:02
/// @version：1.0

class TabVM extends ChangeNotifier  {

  List<Widget> _pages = <Widget>[
    CommunityPage(),
    TrendsPage(),
    Container(),
    InformationPage(),
    MyPage()
  ];

  List<Widget> get pages => _pages;


  List<TaBottomNavigtionBar> _navigtionBars = [
    TaBottomNavigtionBar(icon: Icons.home, name: '社区'),
    TaBottomNavigtionBar(icon: Icons.search, name: '动态'),
    TaBottomNavigtionBar(icon: Icons.notifications_active, name: '发布'),
    TaBottomNavigtionBar(icon: Icons.notifications_active, name: '信息'),
    TaBottomNavigtionBar(icon: Icons.face, name: '我的'),
  ];

  List<TaBottomNavigtionBar> get navigtionBars => _navigtionBars;

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }




}