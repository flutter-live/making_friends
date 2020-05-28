import 'package:flutter/material.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/utils/fluro_convert_utils.dart';
import 'package:makingfriends/viewModel/search/search_history_v_m.dart';
import 'package:makingfriends/viewModel/search/topic_search_content_v_m.dart';
import 'package:makingfriends/widgets/tocpic_list_item.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description： 话题搜索
/// @author：liuzhidong
/// @date：2020/5/15 19:12
/// @version：1.0

class TopicSearchContent extends StatelessWidget {
  final String query;
  final SearchHistoryVM searchHistoryVM;

  const TopicSearchContent({Key key, this.query, this.searchHistoryVM})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TopicSearchResultVM>(
        model: TopicSearchResultVM(query: query, searchHistoryVM: searchHistoryVM),
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
                  return TocpicListItem(
                    title: '#${model.list[index].title}#',
                    subtitle: model.list[index].desc,
                    image: model.list[index].titlepic,
                    devDayNumber: model.list[index].todaypostCount,
                    devNumber: model.list[index].postCount,
                    onTap: () {
                      String item = FluroConvertUtils.object2string(model.list[index]);
                      Jump.push('view/trends/tocpic_details_page?hotTopic=$item');
                    },
                  );
                },
              ),
            ),
          );
        });
  }
}
