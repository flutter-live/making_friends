import 'package:makingfriends/model/Comment.dart';
import 'package:makingfriends/provider/view_state_list.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description： 分类详情
/// @author：liuzhidong
/// @date：2020/5/3 00:27
/// @version：1.0

///评论
class CommentVM extends ViewStateList<Comment>{
  int id;

  @override
  Future<List<Comment>> loadData() async{
    return await MakingFriendsApi.fetchGetComments(id);
  }

  Future comment(int infoId, String data, replyId) async{
    return await MakingFriendsApi.fetchSetComments(infoId, data, replyId);
  }







}