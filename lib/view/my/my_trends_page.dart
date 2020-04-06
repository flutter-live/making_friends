import 'package:flutter/material.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

/// @description： 我的动态
/// @author：liuzhidong
/// @date：2020/4/4 20:03
/// @version：1.0

class MyTrendsPage extends StatefulWidget {
  final Function(bool, int) control;

  const MyTrendsPage({Key key, this.control}) : super(key: key);

  @override
  _MyTrendsPageState createState() => _MyTrendsPageState();
}

class _MyTrendsPageState extends State<MyTrendsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
      Key("Tab1"),
      Builder(
        builder: (context) => NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              if (scrollNotification.metrics.pixels == 0.0) {
                  widget.control(true, 1);
              } else {
                  widget.control(false, 1);
              }
            }
            return true;
          },
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                key: PageStorageKey("Tab1"),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListItem();
                  },
                  childCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
