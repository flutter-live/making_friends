import 'package:flutter/material.dart';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/model/post_class.dart';
import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import 'package:provider/provider.dart';
import '../../provider/view_state_list.dart';
import '../global_state_model.dart';

/// @description： 社区
/// @author：liuzhidong
/// @date：2020/3/28 23:35
/// @version：1.0

class CommunityVM extends ViewStateList<PostClass> {
  @override
  Future<List<PostClass>> loadData() async {
    return await MakingFriendsApi.fetchPostClass();
  }
}

class CommunityListPageVM extends ViewStateRefresh<ArticleDetails> {
  int id;

  @override
  Future<List<ArticleDetails>> loadData({int pageFirst}) async {
    return await MakingFriendsApi.fetchPostClassList(id, pageFirst);
  }

  @override
  void onCompleted(List<ArticleDetails> data) {
    List<DataProcessing> processing =
        data.map((item) => item.processing).toList();
    GlobalStateModel.refresh(processing);
  }
}

///操作栏操作
class TopStepVM extends ViewStateProvider {
  ///踩顶
  Future<void> loadData(ArticleDetails article, int categ) async {
    setBusy();
    try {
      GlobalStateModel globalStateModel =
          Provider.of<GlobalStateModel>(Application.context, listen: false);
      DataProcessing item = DataProcessing();
      DataProcessing newItem = article.processing;
      if (categ == newItem.type) return;
      dynamic data = await MakingFriendsApi.fetchSupport(article.id, categ);
      if (data.length == 0) {
        item.id = article.id;
        if (categ == 0) {
          item.supportCount = ++newItem.supportCount;
          if (newItem.type == 1) {
            item.unsupportCount = --newItem.unsupportCount;
          } else if (newItem.type == 2) {
            item.unsupportCount = newItem.unsupportCount;
          }
        } else {
          item.unsupportCount = ++newItem.unsupportCount;
          if (newItem.type == 0) {
            item.supportCount = --newItem.supportCount;
          } else if (newItem.type == 2) {
            item.supportCount = newItem.supportCount;
          }
        }
        item.type = categ;
        item.commentCount = newItem.commentCount;
        item.isFollow = newItem.isFollow;
        globalStateModel.addFavourite(article.id, item);
        notifyListeners();
      }
      setDef();
    } catch (e, s) {
      setError(e, s);
    }
  }
}

///关注
class FollowVM extends ViewStateProvider {
  ///关注
  Future<void> loadData(ArticleDetails article) async {
    GlobalStateModel globalStateModel =
        Provider.of<GlobalStateModel>(Application.context, listen: false);
    dynamic data = await MakingFriendsApi.fetchEachFollow(article.userId);
    if (data.length == 0) {
      DataProcessing item = article.processing;
      item.isFollow = !item.isFollow;
      globalStateModel.addFavourite(article.id, item);
      globalStateModel.addFavourite(article.userId, item);
    }
  }
}
