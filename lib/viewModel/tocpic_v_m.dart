import 'package:makingfriends/provider/view_state_refresh.dart';

/// @description： 话题
/// @author：liuzhidong
/// @date：2020/3/30 21:41
/// @version：1.0

class TocpicVM extends ViewStateRefresh {

  List<Map<String, dynamic>> map = [
    {'title': '关注', 'id': 1},
    {'title': '推荐', 'id': 2},
    {'title': '体育', 'id': 3},
    {'title': '热点', 'id': 4},
    {'title': '财经', 'id': 5},
  ];

  @override
  Future<List> loadData({int pageFirst}) {
    // TODO: implement loadData
    return null;
  }




}