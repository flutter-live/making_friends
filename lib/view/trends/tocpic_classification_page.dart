import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:makingfriends/model/post_class.dart';
import 'package:makingfriends/view/trends/tocpic_classification_item_page.dart';
import 'package:makingfriends/viewModel/tocpic_class_v_m.dart';
import 'package:makingfriends/widgets/view_state.dart';
import '../../provider/provider_widget.dart';
import '../../config/string.dart';

/// @description: 话题分类
/// @author: liuzhidong
/// @date: 2020/3/31 14:00
/// @version: 1.0

class TocpicClassificationPage extends StatefulWidget {
  final int type;
  final int page;

  const TocpicClassificationPage({Key key, this.type = 1, this.page = 0}) : super(key: key); //"0" 选择话题

  @override
  _TocpicClassificationPageState createState() =>
      _TocpicClassificationPageState();
}

class _TocpicClassificationPageState extends State<TocpicClassificationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TocpicClassVM>(
      model: TocpicClassVM(),
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
        if(model.isEmpty){
          return ViewStateEmptyWidget(
            message: '没有话题哦',
          );
        }
        List<PostClass> listPostClass = model.list;
        return DefaultTabController(
          initialIndex: widget.page,
          length: listPostClass.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text(TitleConfig.TC_TITLE),
              bottom: TabBar(
                tabs: listPostClass
                    .map((item) => Tab(text: item.classname))
                    .toList(),
              ),
            ),
            body: TabBarView(
              children: listPostClass
                  .map((item) => TocpicClassificationItemPage(id: item.id, type: widget.type,))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
