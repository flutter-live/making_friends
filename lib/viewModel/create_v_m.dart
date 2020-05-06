import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/model/create.dart';
import 'package:makingfriends/model/hot_topic.dart';
import 'package:makingfriends/model/making_friends_code.dart';
import 'package:makingfriends/model/upload.dart';
import 'package:makingfriends/provider/view_state.dart';
import 'package:makingfriends/provider/view_state_basic.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description： 发布文章
/// @author：liuzhidong
/// @date：2020/4/27 23:23
/// @version：1.0

class CreateVM extends ViewStateBasic{
  static const keyDraft = 'keyDraft';

  CreateVM(){
    getDraft();
  }

  ///分类
  MakingFriendsCode _makingFriendsCode;

  MakingFriendsCode get makingFriendsCode => _makingFriendsCode;

  set makingFriendsCode(MakingFriendsCode model){
    _makingFriendsCode = model;
    notifyListeners();
  }

  ///照片
  List<Upload> _imageList;

  List<Upload> get imageList => _imageList;

  set imageList(List<Upload> l){
    _imageList = l;
    notifyListeners();
  }

  ///显示的范围
  int _isopen = 0;

  int get isopen => _isopen;

  set isopen(int i){
    _isopen = i;
    notifyListeners();
  }

  ///内容
  String _title;

  String get title => _title;

  set title(String t){
    _title = t;
    notifyListeners();
  }

  ///话题
  HotTopic _hotTopic;

  HotTopic get hotTopic => _hotTopic;

  set hotTopic(HotTopic item){
    _hotTopic = item;
    notifyListeners();
  }

  TextEditingController titleContoller = TextEditingController();

  ///保存草稿
  void saveDraft(){
    Map<String, dynamic> draft = {
      "title": title,
      "hotTopic": hotTopic?.toJson(),
      "isopen": isopen,
      "makingFriendsCode": makingFriendsCode
    };
    Application.sharedPreferences.setString(keyDraft, jsonEncode(draft));
  }
  ///获取草稿
  void getDraft(){
    String d = Application.sharedPreferences.getString(keyDraft);
    if(d != null){
      Map<String, dynamic> draft = jsonDecode(d);
      title = draft['title'].toString();
      hotTopic = draft['hotTopic'] == null ? null : HotTopic.fromJson(draft['hotTopic']);
      isopen = draft['isopen'];
      makingFriendsCode = draft['makingFriendsCode'] == null ? null : MakingFriendsCode.fromJson(draft['makingFriendsCode']);
    }
  }

  ///取消草稿
  void clearDraft(){
    Application.sharedPreferences.remove(keyDraft);
  }

  @override
  Future find({Map data}) {
    // TODO: implement find
    return null;
  }

  @override
  Future<void> onCompleted(data, ViewFunction type) {
    // TODO: implement onCompleted
    return null;
  }

  @override
  Future save({Map data}) async{
    Map<String, dynamic> map = {
      "imglist": jsonEncode(imageList.map((item)=> Imglist.fromJson({'id': item.id})).toList()),
      "text": title,
      "isopen": isopen,
      "topic_id": hotTopic.id,
      "post_class_id": makingFriendsCode.code
    };
    return await MakingFriendsApi.fetchCreate(map);
  }
}



