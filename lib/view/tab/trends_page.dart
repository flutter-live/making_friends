import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view/trends/tocpic_page.dart';
import 'package:makingfriends/view/trends/trends_list_page.dart';
import 'package:makingfriends/view_model/trends_v_m.dart';
import 'package:provider/provider.dart';

/// @description： 动态
/// @author：liuzhidong
/// @date：2020/3/28 17:30
/// @version：1.0

class TrendsPage extends StatefulWidget {
  @override
  _TrendsPageState createState() => _TrendsPageState();
}

class _TrendsPageState extends State<TrendsPage>
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
    return ProviderWidget<TrendsVM>(
      model: TrendsVM(),
      onModelReady: (model) {},
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
                  title: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            icon: Icon(Icons.local_offer), onPressed: () {}),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: TabBar(
                          isScrollable: true,
                          tabs: model.map
                              .map((v) => Tab(text: v['title']))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: model.map.map((v) => v['id'] == 1 ? TrendsListPage() : TocpicPage()).toList(),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
