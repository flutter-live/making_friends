import 'package:flutter/material.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
as extended;

/// @description: 描述
/// @author: liuzhidong
/// @date: 2020/4/1 14:43
/// @version: 1.0 

class TocpicDetailsItemPage extends StatefulWidget {
  final Function(bool, String) control;
  final String reality;

  const TocpicDetailsItemPage({Key key, this.control, this.reality}) : super(key: key);

  @override
  _TocpicDetailsItemPageState createState() => _TocpicDetailsItemPageState();
}

class _TocpicDetailsItemPageState extends State<TocpicDetailsItemPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
      Key(widget.reality),
      Builder(
        builder: (context) => NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              if (scrollNotification.metrics.pixels == 0.0) {
                widget.control(true, widget.reality);
              } else {
                widget.control(false, widget.reality);
              }
            }
            return false;
          },
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                key: PageStorageKey(widget.reality),
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
  bool get wantKeepAlive => true;
}


