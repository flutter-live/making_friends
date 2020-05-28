import 'dart:convert';

import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/config/cache.dart';
import 'package:makingfriends/model/upload.dart';
import 'package:makingfriends/provider/view_state_list.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import 'package:makingfriends/widgets/list_item.dart';

/// @description： 上传图片
/// @author：liuzhidong
/// @date：2020/4/24 20:01
/// @version：1.0

class UploadVN extends ViewStateList<Upload> {
  List<Upload> imageList = [];
  List<String> paths = [];

  UploadVN() {
    getDraft();
  }

  @override
  Future<List<Upload>> loadData() async {
    return await MakingFriendsApi.fetchUpload(paths);
  }

  @override
  onCompleted(List<Upload> data) {
    imageList.addAll(data);
    notifyListeners();
  }

  ///删除照片
  void del(Upload upload) {
    imageList.removeWhere((item) => item.id == upload.id);
    notifyListeners();
  }

  ///保存草稿图片
  void saveDraft() {
    Application.sharedPreferences
        .setString(CacheKey.keyImage, jsonEncode(imageList));
  }

  ///获取草稿
  void getDraft() {
    String d = Application.sharedPreferences.getString(CacheKey.keyImage);
    if (d != null) {
      List<dynamic> draft = jsonDecode(d);
      imageList = draft.length == 0
          ? []
          : draft.map<Upload>((item) => Upload.fromJson(item)).toList();
      notifyListeners();
    }
  }

  ///取消草稿
  void clearDraft() {
    Application.sharedPreferences.remove(CacheKey.keyImage);
  }
}
