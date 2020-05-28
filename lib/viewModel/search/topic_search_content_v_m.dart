import 'package:makingfriends/model/hot_topic.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import 'package:makingfriends/viewModel/search/search_history_v_m.dart';

/// @description： 话题搜索
/// @author：liuzhidong
/// @date：2020/5/15 19:14
/// @version：1.0

class TopicSearchResultVM extends ViewStateRefresh<HotTopic> {
  final String query;
  final SearchHistoryVM searchHistoryVM;

  TopicSearchResultVM({this.query, this.searchHistoryVM});

  @override
  Future<List<HotTopic>> loadData({int pageFirst}) async {
    if (query.isEmpty) return [];
    searchHistoryVM.addHistory(query);
    return await MakingFriendsApi.fetchSearchTopic(query, pageFirst);
  }
}