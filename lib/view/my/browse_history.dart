import 'package:flutter/material.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/viewModel/my/browse_history_v_m.dart';
import 'package:makingfriends/widgets/article_skeleton.dart';
import 'package:makingfriends/widgets/dialog_helper.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:makingfriends/widgets/skeleton.dart';
import 'package:makingfriends/widgets/view_state.dart';

/// @description： 浏览历史
/// @author：liuzhidong
/// @date：2020/5/24 22:58
/// @version：1.0

class BrowseHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<BrowseHistoryVM>(
      model: BrowseHistoryVM(),
      onModelReady: (model) async {
        await model.getBrowseHistory();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('浏览历史'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.clear_all),
                onPressed: () async {
                  if (await DialogHelper.showLoginDialog('是否清除浏览历史？')) {
                    model.clearBrowseHistory();
                  }
                },
              )
            ],
          ),
          body: Builder(builder: (_) {
            if (model.isBusy) {
              return Skeleton(
                betweeChild: (BuildContext context, int index) =>
                    ArticleSkeleton(),
              );
            }
            if (model.isError) {
              return ViewStateErrorWidget(
                error: model.viewStateError,
                onPressed: () {
                  model.getBrowseHistory();
                },
              );
            }
            if (model.isEmpty) {
              return ViewStateEmptyWidget(
                message: '没有话题哦',
                buttonTextData: '刷新',
                onPressed: () {
                  model.getBrowseHistory();
                },
              );
            }
            return ListView.builder(
              itemCount: model.listDetails.length,
              itemBuilder: (context, index) {
                return ListItem(article: model.listDetails[index]);
              },
            );
          }),
        );
      },
    );
  }
}
