import 'package:flutter/material.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';

/// @description: 描述
/// @author: liuzhidong
/// @date: 2020/3/31 16:26
/// @version: 1.0 

class TocpicDetailsVM extends ViewStateRefresh {
  List<Map<String, dynamic>> map = [
    {'title': '默认', 'id': 1},
    {'title': '最新', 'id': 2},
  ];
  @override
  Future<List> loadData({int pageFirst}) {
    // TODO: implement loadData
    return null;
  }



}