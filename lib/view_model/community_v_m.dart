import 'package:flutter/material.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import '../provider/view_state_list.dart';

/// @description： 社区
/// @author：liuzhidong
/// @date：2020/3/28 23:35
/// @version：1.0

class CommunityVM extends ViewStateList {
  List<Map<String, dynamic>> map = [
    {'title': '关注', 'id': 1},
    {'title': '推荐', 'id': 2},
    {'title': '体育', 'id': 3},
    {'title': '热点', 'id': 4},
    {'title': '财经', 'id': 5},
  ];


  @override
  Future<List> loadData() {
    // TODO: implement loadData
    return null;
  }

}

class CommunityListPageVM extends ViewStateRefresh{
  @override
  Future<List> loadData({int pageFirst}) {
    // TODO: implement loadData
    return null;
  }



}