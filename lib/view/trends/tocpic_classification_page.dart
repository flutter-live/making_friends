import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:makingfriends/view/community/category_page.dart';
import 'package:makingfriends/view/trends/tocpic_classification_item_page.dart';
import 'package:makingfriends/view_model/tocpic_v_m.dart';
import 'package:provider/provider.dart';
import '../../provider/provider_widget.dart';
import '../../config/string.dart';

/// @description: 描述
/// @author: liuzhidong
/// @date: 2020/3/31 14:00
/// @version: 1.0

class TocpicClassificationPage extends StatefulWidget {
  @override
  _TocpicClassificationPageState createState() =>
      _TocpicClassificationPageState();
}

class _TocpicClassificationPageState extends State<TocpicClassificationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ValueNotifier<int> valueNotifier;

  TabController tabController;

  @override
  void initState() {
    valueNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TocpicVM>(
      model: TocpicVM(),
      onModelReady: (communityVM) {},
      builder: (context, model, child) {
        return ValueListenableProvider<int>.value(
            value: valueNotifier,
            child: DefaultTabController(
              length: model.map.length,
              initialIndex: valueNotifier.value,
              child: Builder(builder: (context) {
                if (tabController == null) {
                  tabController = DefaultTabController.of(context);
                  tabController.addListener(() {
                    valueNotifier.value = tabController.index;
                  });
                }
                return Scaffold(
                  appBar: AppBar(
                    title: Text(TitleConfig.TC_TITLE),
                    bottom: TabBar(
                      tabs: model.map
                          .map((v) => Tab(text: v['title']))
                          .toList(),
                    ),
                  ),
                  body: TabBarView(
                    children: model.map
                        .map((v) => TocpicClassificationItemPage())
                        .toList(),
                  ),
                );
              }),
            ));
      },
    );
  }
}



