import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import 'package:makingfriends/viewModel/search/search_history_v_m.dart';

/// @description： 帖子搜索
/// @author：liuzhidong
/// @date：2020/5/8 21:24
/// @version：1.0

class SearchPostResultVM extends ViewStateRefresh<ArticleDetails> {
  final String query;
  final SearchHistoryVM searchHistoryVM;

  SearchPostResultVM({this.query, this.searchHistoryVM});

  @override
  Future<List<ArticleDetails>> loadData({int pageFirst}) async {
    if (query.isEmpty) return [];
    searchHistoryVM.addHistory(query);
    return await MakingFriendsApi.fetchSearchPost(query, pageFirst);
  }
}
