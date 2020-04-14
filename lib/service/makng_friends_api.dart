import 'package:makingfriends/config/net/http.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/model/post_class.dart';

/// @description： 社区交友api
/// @author：liuzhidong
/// @date：2020/4/12 12:50
/// @version：1.0

class MakingFriendsApi {
  ///文章分类
  static Future fetchPostClass() async{
    var response = await http.get('postclass');
    return response.data['list'].map<PostClass>((item) => PostClass.fromJson(item)).toList();
  }

  ///文章分类下制定列表
  static Future fetchPostClassList(id, page) async{
    var response = await http.get('postclass/$id/post/$page');
    return response.data['list'].map<ArticleDetails>((item) => ArticleDetails.fromJson(item)).toList();
  }

  ///关注好友动态列表
  static Future fetchfollow() async{
    var response = await http.get('follow');
    return response.data['list'].map<ArticleDetails>((item) => ArticleDetails.fromJson(item)).toList();
  }




}