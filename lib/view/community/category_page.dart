import 'package:flutter/material.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/viewModel/global_state_model.dart';
import 'package:makingfriends/viewModel/tab/community_v_m.dart';
import 'package:makingfriends/widgets/article_skeleton.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:makingfriends/widgets/skeleton.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description： 社区首页
/// @author：liuzhidong
/// @date：2020/3/29 17:21
/// @version：1.0

class CommunityListPage extends StatefulWidget {
  final int id;

  const CommunityListPage({Key key, this.id}) : super(key: key);

  @override
  _CommunityListPageState createState() => _CommunityListPageState();
}

class _CommunityListPageState extends State<CommunityListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<CommunityListPageVM>(
      model: CommunityListPageVM(),
      onModelReady: (model) {
        model.id = widget.id;
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
        if (model.isEmpty) {
          return ViewStateEmptyWidget(
            message: '没有话题哦',
            buttonTextData: '刷新',
            onPressed: (){
              model.initData();
            },
          );
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
