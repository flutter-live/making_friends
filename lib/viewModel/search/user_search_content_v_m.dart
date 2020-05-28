import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import 'package:makingfriends/viewModel/search/search_history_v_m.dart';

/// @description：搜索用户
/// @author：liuzhidong
/// @date：2020/5/24 10:04
/// @version：1.0

class UserSearchContentVM extends ViewStateRefresh<User> {
  final String query;
  final SearchHistoryVM searchHistoryVM;

  UserSearchContentVM({this.query, this.searchHistoryVM});

  @override
  Future<List<User>> loadData({int pageFirst}) async {
    if (query.isEmpty) return [];
    searchHistoryVM.addHistory(query);
    return await MakingFriendsApi.fetchSearchUser(query, pageFirst);
  }
}