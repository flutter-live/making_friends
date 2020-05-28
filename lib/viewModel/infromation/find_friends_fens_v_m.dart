import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description：粉丝
/// @author：liuzhidong
/// @date：2020/5/24 22:20
/// @version：1.0

class FindFriendsFensVM extends ViewStateRefresh<User> {
  @override
  Future<List<User>> loadData({int pageFirst}) async {
    return await MakingFriendsApi.fetchFindFens(pageFirst);
  }
}