import 'package:makingfriends/config/net/http.dart';
import 'package:makingfriends/model/adsense.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/model/hot_topic.dart';
import 'package:makingfriends/model/post_class.dart';
import 'package:makingfriends/model/user.dart';

/// @description： 社区交友api
/// @author：liuzhidong
/// @date：2020/4/12 12:50
/// @version：1.0

class MakingFriendsApi {

  ///登陆
  static Future fetchLogin(String phone, String code) async{
    var response = await http.post('user/phonelogin?phone=$phone&&code=$code');
    return User.fromJson(response.data);
  }

  ///获取验证码
  static Future fetchSendCode(String phone) async{
    var response = await http.post('user/sendcode?phone=$phone');
    return response.data.toString().substring(4, response.data.toString().length);
  }

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
  static Future fetchFollow(page) async{
    var response = await http.get('followpost/$page');
    return response.data['list'].map<ArticleDetails>((item) => ArticleDetails.fromJson(item)).toList();
  }

  ///话题分类
  static Future fetchTopicClass() async{
    var response = await http.get('topicclass');
    return response.data['list'].map<PostClass>((item) => PostClass.fromJson(item)).toList();
  }

  ///广告
  static Future fetchAdsense() async{
    var response = await http.get('adsense/0');
    return response.data['list'].map<Adsense>((item) => Adsense.fromJson(item)).toList();
  }

  ///热门话题
  static Future fetchHotTopic() async{
    var response = await http.get('hottopic');
    return response.data['list'].map<HotTopic>((item) => HotTopic.fromJson(item)).toList();
  }

  ///获取指定话题分类下的话题列表
  static Future fetchTopic(id, page) async{
    var response = await http.get('/topicclass/$id/topic/$page');
    return response.data['list'].map<HotTopic>((item) => HotTopic.fromJson(item)).toList();
  }






}