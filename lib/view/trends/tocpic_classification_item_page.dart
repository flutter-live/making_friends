import 'package:flutter/material.dart';
import 'package:makingfriends/model/hot_topic.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/viewModel/tocpic_classification_v_m.dart';
import 'package:makingfriends/widgets/article_skeleton.dart';
import 'package:makingfriends/widgets/skeleton.dart';
import 'package:makingfriends/widgets/tocpic_list_item.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description: 话题分类
/// @author: liuzhidong
/// @date: 2020/3/31 14:47
/// @version: 1.0

class TocpicClassificationItemPage extends StatefulWidget {
  final int id;

  const TocpicClassificationItemPage({Key key, this.id}) : super(key: key);

  @override
  _TocpicClassificationItemPageState createState() =>
      _TocpicClassificationItemPageState();
}

class _TocpicClassificationItemPageState
    extends State<TocpicClassificationItemPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TocpicClassificationVM>(
      model: TocpicClassificationVM(),
      onModelReady: (model) {
        model.id = widget.id;
        model.initData();
      },
      builder: (context, model, child) {
        if (model.isBusy) {
          return Skeleton(
            betweeChild: (BuildContext context, int index) => ArticleSkeleton(),
          );
        }
        if (model.isError) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        }
        if (model.isEmpty) {
          return ViewStateEmptyWidget(
            message: '没有话题哦',
            buttonTextData: '刷新',
            onPressed: (){
              model.initData();
            },
          );
        }
        List<HotTopic> list = model.list;
        return Container(
          child: SmartRefresher(
            controller: model.refreshController,
            header: WaterDropMaterialHeader(),
            footer: ClassicFooter(),
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TocpicListItem(
                    title: '#${list[index].title}#',
                    subtitle: list[index].desc,
                    image: list[index].titlepic,
                    devDayNumber: list[index].todaypostCount,
                    devNumber: list[index].postCount,
                    onTap: () {
                      Jump.push('view/trends/tocpic_details_page');
                    },
                  ),
                );
              },
              itemCount: list.length,
            ),
          ),
        );
      },
    );
  }
}
