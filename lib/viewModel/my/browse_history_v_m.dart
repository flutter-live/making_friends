import 'dart:convert';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/config/cache.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/provider/view_state_provider.dart';

/// @description：浏览历史
/// @author：liuzhidong
/// @date：2020/5/24 23:03
/// @version：1.0

class BrowseHistoryVM extends ViewStateProvider {

  List<ArticleDetails> _listDetails;

  List<ArticleDetails> get listDetails => _listDetails;

  set listDetails(List<ArticleDetails> item){
    _listDetails = item;
    notifyListeners();
  }

  ///获取浏览历史
  Future<List<ArticleDetails>> getBrowseHistory() async {
    setBusy();
    try{
      List<String> list = Application.sharedPreferences.getStringList(CacheKey.keyBrowseHistory) ?? [];
      listDetails = list.map<ArticleDetails>((e) => ArticleDetails.fromJson(jsonDecode(e))).toList();
      if(listDetails.length == 0){
        setEmpty();
      }else{
        setDef();
      }
    }catch(e, s){
      setError(e, s);
    }
    return listDetails;
  }
  ///清除浏览历史
  Future<List<ArticleDetails>> clearBrowseHistory() async {
    setBusy();
    try{
      Application.sharedPreferences.remove(CacheKey.keyBrowseHistory);
      listDetails.clear();
      setEmpty();
    }catch(e, s){
      setError(e, s);
    }
    return listDetails;
  }
}