import 'package:makingfriends/provider/view_state_list.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';

/// @description： 描述
/// @author：liuzhidong
/// @date：2020/3/29 23:20
/// @version：1.0


class TrendsVM extends ViewStateList {
  List<Map<String, dynamic>> map = [
    {'title': '关注', 'id': 1},
    {'title': '话题', 'id': 2},
  ];

  @override
  Future<List> loadData() {
    // TODO: implement loadData
    return null;
  }



}

class TrendsListPageVM extends ViewStateRefresh{
  @override
  Future<List> loadData({int pageFirst}) {
    // TODO: implement loadData
    return null;
  }



}