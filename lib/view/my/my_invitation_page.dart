import 'package:flutter/material.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

/// @description： 我的帖子
/// @author：liuzhidong
/// @date：2020/4/4 20:03
/// @version：1.0

class MyInvitationPage extends StatefulWidget {
  final Function(bool, int) control;

  const MyInvitationPage({Key key, this.control}) : super(key: key);

  @override
  _MyInvitationPageState createState() => _MyInvitationPageState();
}

class _MyInvitationPageState extends State<MyInvitationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
      Key("Tab0"),
      Builder(
        builder: (context) => NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              if (scrollNotification.metrics.pixels == 0.0) {
                widget.control(true, 0);
              } else {
                widget.control(false, 0);
              }
            }
            return false;
          },
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                key: PageStorageKey("Tab0"),
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
