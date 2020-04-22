import 'package:flutter/material.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view/trends/tocpic_page.dart';
import 'package:makingfriends/view/trends/trends_list_page.dart';
import 'package:makingfriends/viewModel/trends_v_m.dart';

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TrendsVM>(
      model: TrendsVM(),
      builder: (context, model, child) {
        return  DefaultTabController(
            length: model.map.length,
            child: Builder(builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: Container(
                    alignment: Alignment.center,
                    child: TabBar(
                      isScrollable: true,
                      tabs: model.map
                          .map((v) => Tab(text: v['title']))
                          .toList(),
                    ),
                  ),
                ),
                body: TabBarView(
                  children: model.map.map((v) => v['id'] == 1 ? TrendsListPage() : TocpicPage()).toList(),
                ),
              );
            }),
          );
      },
    );
  }
}
