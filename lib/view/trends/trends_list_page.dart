import 'package:flutter/material.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/model/hot_topic.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/viewModel/trends_v_m.dart';
import 'package:makingfriends/widgets/article_skeleton.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:makingfriends/widgets/skeleton.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description： guanzhu
/// @author：liuzhidong
/// @date：2020/3/29 23:36
/// @version：1.0

class TrendsListPage extends StatefulWidget {
  @override
  _TrendsListPageState createState() => _TrendsListPageState();
}

class _TrendsListPageState extends State<TrendsListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TrendsVM>(
      model: TrendsVM(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
        if(model.isBusy){
          return Skeleton(
            betweeChild: (BuildContext context, int index) => ArticleSkeleton(),
          );
        }
        if(model.isError){
          return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
        }
        List<ArticleDetails> list = model.list;
        return Container(
          color: Color.fromRGBO(245, 245, 245, 1),
          child: SmartRefresher(
            controller: model.refreshController,
            header: WaterDropMaterialHeader(),
            footer: ClassicFooter(),
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListItem(
                  article: list[index],
                  onTap: (){
                    Jump.push('view/community/community_details_page');
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
