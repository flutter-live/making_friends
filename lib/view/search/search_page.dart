import 'package:flutter/material.dart';
import 'package:makingfriends/view/search/historical_record_page.dart';
import 'package:makingfriends/view/search/search_content_page.dart';

/// @description: 搜索页面
/// @author: liuzhidong
/// @date: 2020/4/2 15:31
/// @version: 1.0

class DefaultSearchDelegate extends SearchDelegate<String> {


  //清空按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "", //搜索值为空
      )
    ];
  }

  //搜到内容后的展现
  @override
  Widget buildResults(BuildContext context) {
    return SearchContent();
  }

  //设置默认内容
  @override
  Widget buildSuggestions(BuildContext context) {
    return HistoricalRecordPage();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }


}
