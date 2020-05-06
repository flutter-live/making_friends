import 'package:dio/dio.dart';
import 'package:makingfriends/config/net/http.dart';
import 'package:makingfriends/model/Comment.dart';
import 'package:makingfriends/model/adsense.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/model/hot_topic.dart';
import 'package:makingfriends/model/post_class.dart';
import 'package:makingfriends/model/upload.dart';
import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/utils/class_untils.dart';

/// @description： 社区交友api
/// @author：liuzhidong
/// @date：2020/4/12 12:50
/// @version：1.0

class MakingFriendsApi {
  ///登陆
  static Future fetchLogin(String phone, String code) async {
    var response = await http.post('user/phonelogin?phone=$phone&&code=$code');
    return User.fromJson(response.data);
  }

  ///获取验证码
  static Future fetchSendCode(String phone) async {
    var response = await http.post('user/sendcode?phone=$phone');
    return response.data
        .toString()
        .substring(4, response.data.toString().length);
  }

  ///文章分类
  static Future fetchPostClass() async {
    var response = await http.get('postclass');
    return response.data['list']
        .map<PostClass>((item) => PostClass.fromJson(item))
        .toList();
  }

  ///文章分类下制定列表
  static Future fetchPostClassList(id, page) async {
    var response = await http.get('postclass/$id/post/$page');
    List<ArticleDetails> list = response.data['list']
        .map<ArticleDetails>((item) => ArticleDetails.fromJson(item))
        .toList();
    List<ArticleDetails> listHandle = list
        .map(
            (item) => item = item..processing = ClassUntils.getProcessing(item))
        .toList();
    return listHandle;
  }

  ///关注好友动态列表
  static Future fetchFollow(page) async {
    var response = await http.get('followpost/$page');
    List<ArticleDetails> list = response.data['list']
        .map<ArticleDetails>((item) => ArticleDetails.fromJson(item))
        .toList();
    List<ArticleDetails> listHandle = list
        .map(
            (item) => item = item..processing = ClassUntils.getProcessing(item))
        .toList();
    return listHandle;
  }

  ///话题分类
  static Future fetchTopicClass() async {
    var response = await http.get('topicclass');
    return response.data['list']
        .map<PostClass>((item) => PostClass.fromJson(item))
        .toList();
  }

  ///广告
  static Future fetchAdsense() async {
    var response = await http.get('adsense/0');
    return response.data['list']
        .map<Adsense>((item) => Adsense.fromJson(item))
        .toList();
  }

  ///热门话题
  static Future fetchHotTopic() async {
    var response = await http.get('hottopic');
    return response.data['list']
        .map<HotTopic>((item) => HotTopic.fromJson(item))
        .toList();
  }

  ///获取指定话题分类下的话题列表
  static Future fetchTopic(id, page) async {
    var response = await http.get('topicclass/$id/topic/$page');
    return response.data['list']
        .map<HotTopic>((item) => HotTopic.fromJson(item))
        .toList();
  }

  ///上传图片
  static Future fetchUpload(List<String> paths) async {
    List<Future> futures = [];
    paths.forEach((item) {
      futures.add(MultipartFile.fromFile(item));
    });
    var list = await Future.wait(futures);
    FormData formData = FormData.fromMap({"imglist": list});
    var response = await http.post('image/uploadmore', data: formData);
    List<Upload> uploads = response.data['list']
        .map<Upload>((item) => Upload.fromJson(item))
        .toList();
    return uploads;
  }

  ///发布文章
  static Future fetchCreate(Map<String, dynamic> map) async {
    var response = await http.post('post/create', data: map);
    return ArticleDetails.fromJson(response.data['detail']);
  }

  ///用户顶踩
  static Future fetchSupport(int id, int type) async {
    FormData formData = FormData.fromMap({"post_id": id, "type": type});
    var response = await http.post('support', data: formData);
    return response.data;
  }

  ///关注用户
  static Future fetchEachFollow(int userId) async {
    FormData formData = FormData.fromMap({"follow_id": userId});
    var response = await http.post('follow', data: formData);
    return response.data;
  }

  ///获取评论列表
  static Future fetchGetComments(int id) async {
    var response = await http.get('post/$id/comment');
    List<Comment> comments = response.data['list']
        .map<Comment>((item) => Comment.fromJson(item))
        .toList();
    List<Comment> list = ClassUntils.getCommentData(comments);
    return list;
  }

  ///提交评论
  static Future fetchSetComments(int fid, String data, int postId) async {
    FormData formData = FormData.fromMap({"fid": fid, "data": data, "post_id": postId});
    var response = await http.post('post/comment', data: formData);
    return response.data;
  }

}
