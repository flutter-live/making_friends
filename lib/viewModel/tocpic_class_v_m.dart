import 'package:makingfriends/model/making_friends_code.dart';
import 'package:makingfriends/model/post_class.dart';
import 'package:makingfriends/provider/view_state_list.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description：获取所有话题分类
/// @author：liuzhidong
/// @date：2020/4/22 19:33
/// @version：1.0

class TocpicClassVM extends ViewStateList<PostClass> {
  ///话题分类
  MakingFriendsCode _makingFriendsCode;

  MakingFriendsCode get makingFriendsCode => _makingFriendsCode;

  set makingFriendsCode(MakingFriendsCode model){
    _makingFriendsCode = model;
    notifyListeners();
  }

  @override
  Future<List<PostClass>> loadData() async{
    return await MakingFriendsApi.fetchTopicClass();
  }

}