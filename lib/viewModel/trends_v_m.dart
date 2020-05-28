import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/provider/view_state_list.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description： 动态
/// @author：liuzhidong
/// @date：2020/3/29 23:20
/// @version：1.0

class TrendsVM extends ViewStateRefresh<ArticleDetails> {
  List<Map<String, dynamic>> _map = [
    {'title': '关注', 'id': 1},
    {'title': '话题', 'id': 2},
  ];

  List<Map<String, dynamic>> get map => _map;

  @override
  Future<List<ArticleDetails>> loadData({int pageFirst}) async {
    return await MakingFriendsApi.fetchFollow(pageFirst);
  }
}

class TrendsListPageVM extends ViewStateRefresh {
  @override
  Future<List> loadData({int pageFirst}) {
    // TODO: implement loadData
    return null;
  }
}
