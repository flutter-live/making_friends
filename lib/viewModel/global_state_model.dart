import 'package:flutter/material.dart';
import 'package:makingfriends/model/article_details.dart';

/// @description： 全局踩.顶.聊天数量维护状态
/// @author：liuzhidong
/// @date：2020/5/2 12:54
/// @version：1.0

class GlobalStateModel extends ChangeNotifier {
  /// 将页面列表项中所有的收藏状态操作结果存储到集合中.
  ///
  /// [key]为Id,[value]为DataProcessing类型,代表操作数据
  ///
  /// 设置static的目的是,列表更新时,刷新该map中的值
  static final Map<String, DataProcessing> _map = Map();

  /// 列表数据刷新后,同步刷新该map数据
  ///
  /// 在其他终端(如PC端)收藏/取消收藏后,会导致两边状态不一致.
  /// 列表页面刷新后,应该将新的收藏状态同步更新到map
  static refresh(List<DataProcessing> list) {
    list.forEach((article) {
      if (_map.containsKey(article.id)) {
        _map[article.id] = article;
      }
    });
  }

  addFavourite(String id, DataProcessing item) {
    _map[id] = item;
    notifyListeners();
  }

  removeFavourite(String id, DataProcessing item) {
    _map[id] = item;
    notifyListeners();
  }

  operator [](String id) {
    return _map[id];
  }
}