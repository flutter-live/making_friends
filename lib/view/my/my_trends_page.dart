import 'package:flutter/material.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/viewModel/my_invitation_v_m.dart';
import 'package:makingfriends/viewModel/user_counts_v_m.dart';
import 'package:makingfriends/widgets/article_skeleton.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:makingfriends/widgets/skeleton.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description： 我的动态
/// @author：liuzhidong
/// @date：2020/4/4 20:03
/// @version：1.0

class MyTrendsPage extends StatefulWidget {
  final Function(bool, int) control;
  final String id;

  const MyTrendsPage({Key key, this.control, this.id}) : super(key: key);

  @override
  _MyTrendsPageState createState() => _MyTrendsPageState();
}

class _MyTrendsPageState extends State<MyTrendsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
      Key("Tab1"),
      Builder(
        builder: (context) => NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              if (scrollNotification.metrics.pixels == 0.0) {
                widget.control(true, 1);
              } else {
                widget.control(false, 1);
              }
            }
            return true;
          },
          child: ProviderWidget<MyInvitationVM>(
            model: MyInvitationVM(id: widget.id),
            onModelReady: (model) {
              model.initData();
            },
            builder: (context, model, child) {
              if (model.isBusy) {
                return Skeleton(
                  betweeChild: (BuildContext context, int index) =>
                      ArticleSkeleton(),
                );
              }
              if (model.isError) {
                return ViewStateErrorWidget(
                    error: model.viewStateError, onPressed: model.initData);
              }
              if (model.isEmpty) {
                return ViewStateEmptyWidget(
                  message: '没有文章哦',
                  buttonTextData: '刷新',
                  onPressed: () {
                    model.initData();
                  },
                );
              }

              return SmartRefresher(
                controller: model.refreshController,
                header: WaterDropMaterialHeader(),
                footer: ClassicFooter(),
                enablePullDown: false,
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                enablePullUp: true,
                child: CustomScrollView(
                  physics: ClampingScrollPhysics(),
                  slivers: <Widget>[
                    SliverList(
                      key: PageStorageKey("Tab1"),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return ListItem(
                            article: model.list[index],
                            onTap: (flag, value) {
                              UserCountsVM u = Provider.of<UserCountsVM>(context, listen: false);
                              u.getAssignUserCounts(widget.id);
                            },
                          );
                        },
                        childCount: model.list.length,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
