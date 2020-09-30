import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description： 个人详细信息页面
/// @author：liuzhidong
/// @date：2020/5/16 09:06
/// @version：1.0

class MyInvitationVM extends ViewStateRefresh<ArticleDetails> {
  final String id;

  MyInvitationVM({this.id});

  @override
  Future<List<ArticleDetails>> loadData({int pageFirst}) async {
    return await MakingFriendsApi.fetchGetUserPostList(id, pageFirst);
  }
}
