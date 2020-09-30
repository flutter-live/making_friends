import 'package:dio/dio.dart';
import 'package:makingfriends/config/net/http.dart';
import 'package:makingfriends/model/Comment.dart';
import 'package:makingfriends/model/UserCounts.dart';
import 'package:makingfriends/model/adsense.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/model/chat_model.dart';
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
  static Future fetchSupport(String id, int type) async {
    FormData formData = FormData.fromMap({"post_id": id, "type": type});
    var response = await http.post('support', data: formData);
    return response.data;
  }

  ///关注用户
  static Future fetchEachFollow(String userId) async {
    FormData formData = FormData.fromMap({"follow_id": userId});
    var response = await http.post('follow', data: formData);
    return response.data;
  }

  ///获取评论列表
  static Future fetchGetComments(String id) async {
    var response = await http.get('post/$id/comment');
    List<Comment> comments = response.data['list']
        .map<Comment>((item) => Comment.fromJson(item))
        .toList();
    List<Comment> list = await ClassUntils.getCommentData(comments);
    return list;
  }

  ///提交评论
  static Future fetchSetComments(int fid, String data, String postId) async {
    FormData formData = FormData.fromMap({"fid": fid, "data": data, "post_id": postId});
    var response = await http.post('post/comment', data: formData);
    return response.data;
  }

  ///搜索文章
  static Future fetchSearchPost(keyword	, page) async {
    var response = await http.post('search/post?keyword=$keyword&&page=$page');
    List<ArticleDetails> list = response.data['list']
        .map<ArticleDetails>((item) => ArticleDetails.fromJson(item))
        .toList();
    List<ArticleDetails> listHandle = list
        .map(
            (item) => item = item..processing = ClassUntils.getProcessing(item))
        .toList();
    return listHandle;
  }

  ///搜索话题
  static Future fetchSearchTopic(keyword, page) async {
    var response = await http.post('search/topic?keyword=$keyword&&page=$page');
    return response.data['list']
        .map<HotTopic>((item) => HotTopic.fromJson(item))
        .toList();
  }

  ///获取用户相关数据
  static Future fetchGetUserCounts(id) async {
    var response = await http.get('user/getcounts/$id');
    return UserCounts.fromJson(response.data);
  }

  ///获取用户详细信息
  static Future fetchGetUserInfo(id) async {
    var response = await http.post('getuserinfo?user_id=$id');
    return User.fromJson(response.data);
  }

  ///获取指定话题下的文章列表
  static Future fetchTopicPostList(id, page) async {
    var response = await http.get('topic/$id/post/$page');
    List<ArticleDetails> list = response.data['list']
        .map<ArticleDetails>((item) => ArticleDetails.fromJson(item))
        .toList();
    List<ArticleDetails> listHandle = list
        .map(
            (item) => item = item..processing = ClassUntils.getProcessing(item))
        .toList();
    return listHandle;
  }

  ///指定用户下的文章列表
  static Future fetchGetUserPostList(id, page) async {
    var response = await http.get('user/$id/post/$page');
    List<ArticleDetails> list = response.data['list']
        .map<ArticleDetails>((item) => ArticleDetails.fromJson(item))
        .toList();
    List<ArticleDetails> listHandle = list
        .map(
            (item) => item = item..processing = ClassUntils.getProcessing(item))
        .toList();
    return listHandle;
  }

  ///绑定手机号
  ///api有问题 不能使用
  static Future fetchBindPhone({String phone, String code}) async {
    print(phone);
    print(code);
    FormData formData = FormData.fromMap({"phone": phone, "code": code});
    var response = await http.post('user/bindphone', data: formData);
    return response.data;
  }

  ///修改密码
  static Future fetchRePassword({String newPassword, String renewPassword, String oldPassword}) async {
    FormData formData = FormData.fromMap({"oldpassword": oldPassword, "newpassword": newPassword, "renewpassword": renewPassword});
    var response = await http.post('repassword', data: formData);
    return response.data;
  }

  ///绑定邮箱
  static Future fetchBindEmail({String email}) async {
    print(email);
    FormData formData = FormData.fromMap({"email": email});
    var response = await http.post('user/bindemail', data: formData);
    return response.data;
  }

  ///修改资料
  static Future fetchEditUserInfo(Map<String, dynamic> userinfo) async {
    FormData formData = FormData.fromMap(userinfo);
    var response = await http.post('edituserinfo', data: formData);
    return response.data;
  }

  ///修改头像
  static Future fetchEditUserPic(String path) async {
    FormData formData = FormData.fromMap({
      "name": "userpic",
      "userpic": await MultipartFile.fromFile(path),
    });
    var response = await http.post('edituserpic', data: formData);
    return response.data;
  }

  ///搜素用户
  static Future fetchSearchUser(keyword, page) async {
    var response = await http.post('search/user?keyword=$keyword&&page=$page');
    return response.data['list']
        .map<User>((item) => User.fromJson(item))
        .toList();
  }

  ///互关
  static Future fetchFindCorrelation(page) async {
    var response = await http.get('friends/$page');
    print(response.data);
    return response.data['list']
        .map<User>((item) => User.fromJson(item))
        .toList();
  }

  ///粉丝
  static Future fetchFindFens(page) async {
    var response = await http.get('fens/$page');
    return response.data['list']
        .map<User>((item) => User.fromJson(item))
        .toList();
  }

  ///关注
  static Future fetchFindFollow(page) async {
    var response = await http.get('follows/$page');
    return response.data['list']
        .map<User>((item) => User.fromJson(item))
        .toList();
  }

  ///用户绑定
  static Future fetchUserBind(clientId) async {
    var response = await http.post('chat/bind?type=bind&&client_id=$clientId');
    return response.data;
  }

  ///获取未读信息
  static Future<List<ChatModel>> fetchGetUnreadMessages() async {
    var response = await http.post('chat/get');
    return response.data.map<ChatModel>((item) => ChatModel.fromJson(item)).toList();
  }

  ///发送消息
  static Future fetchSendChatMessages(Map<String, dynamic> map) async {
    FormData formData = FormData.fromMap(map);
    var response = await http.post('chat/send', data: formData);
    return response.data;
  }

}
