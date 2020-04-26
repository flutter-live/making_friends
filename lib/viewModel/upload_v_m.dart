import 'package:flutter/material.dart';
import 'package:makingfriends/model/upload.dart';
import 'package:makingfriends/provider/view_state_list.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description： 上传图片
/// @author：liuzhidong
/// @date：2020/4/24 20:01
/// @version：1.0

class UploadVN extends ViewStateList<Upload>{
  List<Upload> imageList = [];
  List<String> paths = [];


  @override
  Future<List<Upload>> loadData() async{
    return await MakingFriendsApi.fetchUpload(paths);
  }

  @override
  onCompleted(List<Upload> data) {
    imageList.addAll(data);
    notifyListeners();
  }

  ///删除照片
  void del(Upload upload){
    imageList.removeWhere((item) => item.id == upload.id);
    notifyListeners();
  }

}