import 'package:flutter/material.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view/search/historical_record_page.dart';
import 'package:makingfriends/view/search/search_content_page.dart';
import 'package:makingfriends/viewModel/historical_record_v_m.dart';

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

  DefaultSearchDelegate({this.hintText, this.type}) : super(
    searchFieldLabel: hintText,
  );

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
        }
      )
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
      return SearchContent(query: query,);
    }
    return SizedBox.shrink();
  }

  //设置默认内容
  @override
  Widget buildSuggestions(BuildContext context) {
    return ProviderWidget<HistoricalRecordVM>(
        model: HistoricalRecordVM(),
        builder: (context, model, child){
          return HistoricalRecordPage();
        }
    );


  }


}
