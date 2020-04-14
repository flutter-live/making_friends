import 'package:flutter/material.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/model/post_class.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import '../../provider/view_state_list.dart';

/// @description： 社区
/// @author：liuzhidong
/// @date：2020/3/28 23:35
/// @version：1.0

class CommunityVM extends ViewStateList<PostClass> {
  @override
  Future<List<PostClass>> loadData() async{
    return await MakingFriendsApi.fetchPostClass();
  }

}

class CommunityListPageVM extends ViewStateRefresh<ArticleDetails>{
  int id;

  @override
  Future<List<ArticleDetails>> loadData({int pageFirst}) async{
    return await MakingFriendsApi.fetchPostClassList(id, pageFirst);
  }


}