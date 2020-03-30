import 'package:flutter/material.dart';
import 'package:makingfriends/model/hot_topic.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view_model/trends_v_m.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description： 描述
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TrendsListPageVM>(
      model: TrendsListPageVM(),
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
