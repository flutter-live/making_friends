import 'package:makingfriends/model/hot_topic.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description： 话题分类
/// @author：liuzhidong
/// @date：2020/4/20 20:01
/// @version：1.0

class TocpicClassificationVM extends ViewStateRefresh<HotTopic> {

  List<Map<String, dynamic>> map = [];

  int id;

  @override
  Future<List<HotTopic>> loadData({int pageFirst}) async{

    return await MakingFriendsApi.fetchTopic(id, pageFirst);
  }




}