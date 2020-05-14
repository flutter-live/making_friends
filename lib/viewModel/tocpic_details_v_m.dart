import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description: 话题详情页
/// @author: liuzhidong
/// @date: 2020/3/31 16:26
/// @version: 1.0

class TocpicDetailsVM extends ViewStateProvider {
  List<Map<String, dynamic>> _map = [
    {'title': '默认', 'id': 1},
    {'title': '最新', 'id': 2},
  ];

  List<Map<String, dynamic>> get map => _map;
}

class TocpicDetailsItemVM extends ViewStateRefresh<ArticleDetails> {
  final int id;

  TocpicDetailsItemVM(this.id);

  @override
  Future<List<ArticleDetails>> loadData({int pageFirst}) async {
    return await MakingFriendsApi.fetchTopicPostList(id, pageFirst);
  }
}
