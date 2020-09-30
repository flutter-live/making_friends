import 'dart:convert';

import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/config/cache.dart';
import 'package:makingfriends/model/Comment.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/provider/view_state_list.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description： 分类详情
/// @author：liuzhidong
/// @date：2020/5/3 00:27
/// @version：1.0

///评论
class CommentVM extends ViewStateList<Comment> {
  String id;

  @override
  Future<List<Comment>> loadData() async {
    return await MakingFriendsApi.fetchGetComments(id);
  }

  Future comment(int infoId, String data, String replyId) async {
    return await MakingFriendsApi.fetchSetComments(infoId, data, replyId);
  }

  ///添加历史记录
  Future browseHistory(ArticleDetails articleDetails) async{
    List<ArticleDetails> listDetails = List<ArticleDetails>();
    List<String> list = Application.sharedPreferences.getStringList(CacheKey.keyBrowseHistory) ?? [];
    if(list.length > 0) {
      list.forEach((item) async=> listDetails.add(ArticleDetails.fromJson(jsonDecode(item))));
      listDetails.retainWhere((e) => e.id != articleDetails.id);
    }
    listDetails.insert(0, articleDetails);
    List<String> kList = listDetails.map<String>((e) => json.encode(e.toJson())).toList();
    Application.sharedPreferences.setStringList(CacheKey.keyBrowseHistory, kList);
  }
}
