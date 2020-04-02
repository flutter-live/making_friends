import 'package:flutter/material.dart';
import 'package:makingfriends/model/hot_topic.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/view_model/community_v_m.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description： 社区首页
/// @author：liuzhidong
/// @date：2020/3/29 17:21
/// @version：1.0

class CommunityListPage extends StatefulWidget {
  @override
  _CommunityListPageState createState() => _CommunityListPageState();
}

class _CommunityListPageState extends State<CommunityListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<CommunityListPageVM>(
      model: CommunityListPageVM(),
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Container(
          color: Color.fromRGBO(245, 245, 245, 1),
          child: SmartRefresher(
            controller: model.refreshController,
            header: WaterDropMaterialHeader(),
            footer: ClassicFooter(),
            //onRefresh: model.refresh,
            //  onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                // HotTopic item = model.list[index];
                HotTopic item = HotTopic();
                return ListItem(
                  hotTopic: item,
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
