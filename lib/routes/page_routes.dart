import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/utils/fluro_convert_utils.dart';
import 'package:makingfriends/view/community/community_details_page.dart';
import 'package:makingfriends/view/information/chat_page.dart';
import 'package:makingfriends/view/information/find_friends_page.dart';
import 'package:makingfriends/view/login/login_page.dart';
import 'package:makingfriends/view/my/my_details_page.dart';
import 'package:makingfriends/view/release/release_page.dart';
import 'package:makingfriends/view/setting/about_page.dart';
import 'package:makingfriends/view/setting/account_security_page.dart';
import 'package:makingfriends/view/setting/clear_cache_page.dart';
import 'package:makingfriends/view/setting/editing_from_page.dart';
import 'package:makingfriends/view/setting/editing_materials_page.dart';
import 'package:makingfriends/view/setting/feedback_page.dart';
import 'package:makingfriends/view/setting/setting_mail_page.dart';
import 'package:makingfriends/view/setting/setting_page.dart';
import 'package:makingfriends/view/setting/setting_password_page.dart';
import 'package:makingfriends/view/setting/setting_phone_page.dart';
import 'package:makingfriends/view/trends/tocpic_classification_page.dart';
import 'package:makingfriends/view/trends/tocpic_details_page.dart';
import '../view/tab/tab_page.dart';

/// @description： 路由配置
/// @author：liuzhidong
/// @date：2020/3/27 23:36
/// @version：1.0

class PageRoutes {
  static setRouters(Router router) {
    //没有找到页面
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('================== 没有找到对应的页面 =======================');
      return;
    });

    pageRouters.forEach((path, handler) {
      router.define(path, handler: handler);
    });
  }
}

final Map<String, Handler> pageRouters = {
  '/': Handler(handlerFunc: (context, params) => TabPage()),
  //登陆页
  'view/login/login_page': Handler(handlerFunc: (context, params) => LoginPage()),
  //话题分类
  'view/trends/tocpic_classification_page': Handler(handlerFunc: (context, params) {
    String index = params['type']?.first;
    return TocpicClassificationPage(type: int.parse(index),);
  }),
  //话题详情页
  'view/trends/tocpic_details_page': Handler(handlerFunc: (context, params) => TocpicDetailsPage()),
  //社区内容详情页
  'view/community/community_details_page': Handler(handlerFunc: (context, params) {
    Map<String, dynamic> article = FluroConvertUtils.string2map(params['article']?.first);
    return CommunityDetailsPage(article: ArticleDetails.fromJson(article));
  }),
  //我的详情页
  'view/my/my_details_page': Handler(handlerFunc: (context, params) => MyDetailsPage()),
  //设置
  'setting/setting_page': Handler(handlerFunc: (context, params) => SettingPage()),
  //账号与安全
  'setting/account_security_page': Handler(handlerFunc: (context, params) => AccountSecurityPage()),
  //清除缓存
  'setting/clear_cache_page': Handler(handlerFunc: (context, params) => ClearCachePage()),
  //编辑资料
  'setting/editing_materials_page': Handler(handlerFunc: (context, params) => EditingMaterials()),
  //意见反馈
  'setting/feedack_page': Handler(handlerFunc: (context, params) => FeedbackPage()),
  //关于
  'setting/about_page': Handler(handlerFunc: (context, params) => AboutPage()),
  //绑定邮箱
  'setting/setting_mail_page': Handler(handlerFunc: (context, params) => SettingMailPage()),
  //修改手机号
  'setting/setting_phone_page': Handler(handlerFunc: (context, params) => SettingPhonePage()),
  //修改密码
  'setting/setting_password_page': Handler(handlerFunc: (context, params) => SettingPasswordPage()),
  //昵称，情感，职业表单
  'setting/editing_from_page': Handler(handlerFunc: (context, params) {
    String title = FluroConvertUtils.fluroCnParamsDecode(params['title']?.first);
    String hitText = FluroConvertUtils.fluroCnParamsDecode(params['hintText'].first);
    return EditingFromPage(title: title, hintText: hitText,);
  }),
  //查找好友
  'information/find_friends_page': Handler(handlerFunc: (context, params) => FindFriendsPage()),
  //聊天
  'information/chat_page': Handler(handlerFunc: (context, params) => ChatPage()),
  //发布页
  'release/release_page': Handler(handlerFunc: (context, params) => ReleasePage()),


};
