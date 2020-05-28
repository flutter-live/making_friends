import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/view/information/user_item_page.dart';
import 'package:makingfriends/viewModel/search/search_history_v_m.dart';
import 'package:makingfriends/viewModel/search/user_search_content_v_m.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:makingfriends/widgets/image_setting.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description： 搜索用户
/// @author：liuzhidong
/// @date：2020/5/24 10:02
/// @version：1.0

class UserSearchContent extends StatelessWidget {
  final String query;
  final SearchHistoryVM searchHistoryVM;

  const UserSearchContent({Key key, this.query, this.searchHistoryVM})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<UserSearchContentVM>(
      model: UserSearchContentVM(query: query, searchHistoryVM: searchHistoryVM),
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
            message: '没有查找到好友哦',
            buttonTextData: '刷新',
            onPressed: () {
              model.initData();
            },
          );
        }

        return Container(
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
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black38, width: 0.5)),
                  ),
                  child: UserItem(user: model.list[index])
                );
              },
            ),
          ),
        );
      },
    );
  }
}
