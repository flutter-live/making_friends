import 'package:flutter/material.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view/information/user_item_page.dart';
import 'package:makingfriends/viewModel/infromation/find_friends_fens_v_m.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description： 粉丝
/// @author：liuzhidong
/// @date：2020/5/24 22:12
/// @version：1.0

class FindFriendsFensPage extends StatefulWidget {
  @override
  _FindFriendsFensPageState createState() => _FindFriendsFensPageState();
}

class _FindFriendsFensPageState extends State<FindFriendsFensPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<FindFriendsFensVM>(
      model: FindFriendsFensVM(),
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
