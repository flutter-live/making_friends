import 'package:flutter/material.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/viewModel/search/search_history_v_m.dart';
import 'package:makingfriends/viewModel/search/search_post_result_v_m.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description： 搜索到的内容
/// @author：liuzhidong
/// @date：2020/4/2 18:41
/// @version：1.0

class SearchContent extends StatelessWidget {
  final String query;
  final SearchHistoryVM searchHistoryVM;

  const SearchContent({Key key, this.query, this.searchHistoryVM})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SearchPostResultVM>(
        model:
            SearchPostResultVM(query: query, searchHistoryVM: searchHistoryVM),
        onModelReady: (model) {
          model.initData();
        },
        builder: (context, model, child) {
          if (model.isBusy) {
            return ViewStateBusyWidget();
          }
          if (model.isError) {
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          }
          if (model.isEmpty) {
            return ViewStateEmptyWidget(
              message: '没有话题哦',
              buttonTextData: '刷新',
              onPressed: () {
                model.initData();
              },
            );
          }

          return Container(
            color: Color.fromRGBO(245, 245, 245, 1),
            child: SmartRefresher(
              controller: model.refreshController,
              header: WaterDropMaterialHeader(),
              footer: ClassicFooter(),
              enablePullDown: false,
              onRefresh: model.refresh,
              onLoading: model.loadMore,
              enablePullUp: true,
              child: ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (context, index) {
                  return ListItem(article: model.list[index]);
                },
              ),
            ),
          );
        });
  }
}
