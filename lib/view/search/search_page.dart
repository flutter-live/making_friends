import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:makingfriends/flutter/search.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view/search/historical_record_page.dart';
import 'package:makingfriends/view/search/search_content_page.dart';
import 'package:makingfriends/viewModel/historical_record_v_m.dart';
import 'package:makingfriends/viewModel/search/search_history_v_m.dart';
import 'package:provider/provider.dart';

/// @description: 搜索页面
/// @author: liuzhidong
/// @date: 2020/4/2 15:31
/// @version: 1.0

class DefaultSearchDelegate extends SearchDelegate<String> {
  final String hintText; //提示词
  //"post" 搜索文章
  //"user" 搜索用户
  //"topic" 搜索话题
  final String type;

  DefaultSearchDelegate({this.hintText, this.type})
      : super(
          searchFieldLabel: hintText,
        );

  SearchHistoryVM _searchHistory = SearchHistoryVM();

  //清空按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          })
    ];
  }

  //搜索框左侧按钮
  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  //搜到内容后的展现
  @override
  Widget buildResults(BuildContext context) {
    if (query.length > 0) {
      switch (type) {
        case 'post':
          return SearchContent(
            query: query,
            searchHistoryVM: _searchHistory,
          );
        case 'user':
          return null;
        case 'topic':
          return null;
      }
    }
    return SizedBox.shrink();
  }

  //设置默认内容
  @override
  Widget buildSuggestions(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchHistoryVM>.value(value: _searchHistory..keyHistory = type)
      ],
      child: HistoricalRecordPage(delegate: this),
    );
  }

  @override
  void close(BuildContext context, result) {
    _searchHistory.dispose();
    super.close(context, result);
  }
}
