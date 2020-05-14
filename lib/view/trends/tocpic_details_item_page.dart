import 'package:flutter/material.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/viewModel/tocpic_details_v_m.dart';
import 'package:makingfriends/widgets/article_skeleton.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:makingfriends/widgets/skeleton.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description: 描述
/// @author: liuzhidong
/// @date: 2020/4/1 14:43
/// @version: 1.0

class TocpicDetailsItemPage extends StatefulWidget {
  final Function(bool, String) control;
  final String reality;
  final int id;

  const TocpicDetailsItemPage({Key key, this.control, this.reality, this.id})
      : super(key: key);

  @override
  _TocpicDetailsItemPageState createState() => _TocpicDetailsItemPageState();
}

class _TocpicDetailsItemPageState extends State<TocpicDetailsItemPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
      Key(widget.reality),
      Builder(
        builder: (context) => NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              if (scrollNotification.metrics.pixels == 0.0) {
                widget.control(true, widget.reality);
              } else {
                widget.control(false, widget.reality);
              }
            }
            return false;
          },
          child: ProviderWidget<TocpicDetailsItemVM>(
            model: TocpicDetailsItemVM(widget.id),
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
                      key: PageStorageKey(widget.reality),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return ListItem(article: model.list[index]);
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
  bool get wantKeepAlive => true;
}
