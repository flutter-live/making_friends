import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view/trends/tocpic_details_item_page.dart';
import 'package:makingfriends/viewModel/tocpic_details_v_m.dart';
import 'package:makingfriends/widgets/custom_division_line.dart';
import 'package:makingfriends/widgets/custom_image.dart';
import 'package:after_layout/after_layout.dart';

/// @description: 话题详情
/// @author: liuzhidong
/// @date: 2020/3/31 16:21
/// @version: 1.0

class TocpicDetailsPage extends StatefulWidget {
  final int type;

  const TocpicDetailsPage({Key key, this.type: 0}) : super(key: key);

  @override
  _TocpicDetailsPageState createState() => _TocpicDetailsPageState();
}

class _TocpicDetailsPageState extends State<TocpicDetailsPage>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  double extraPicHeight = 0;
  double prevDy = 0;
  AnimationController animationController;
  Animation<double> anim;
  double expanedHeight = 170;
  bool T = true;
  bool D = true;
  bool X = true;
  TabController primaryTC;
  String title = '';

  @override
  void initState() {
    super.initState();
    primaryTC = new TabController(length: 2, vsync: this);
    primaryTC.addListener(tabControlerListener);
    prevDy = 0;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  @override
  void dispose() {
    primaryTC.removeListener(tabControlerListener);
    primaryTC.dispose();
    animationController.dispose();
    super.dispose();
  }

  void tabControlerListener() {
    X = primaryTC.index == 0 ? X = T : X = D;
  }

  ///解决手势冲突
  control(bool b, String type) {
    if (type == 'Tab0') {
      T = b;
    } else {
      D = b;
    }
    tabControlerListener();
  }

  ///下拉动画
  updatePicHeight(changed) {
    if ((expanedHeight + extraPicHeight) > 500) return;

    if (changed - prevDy > 0 && X) {
      if (prevDy == 0) {
        prevDy = changed;
      }
      extraPicHeight += changed - prevDy;
      setState(() {
        prevDy = changed;
        extraPicHeight = extraPicHeight;
      });
    }
  }

  ///回弹动画
  runAnimate() {
    setState(() {
      anim = Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
        ..addListener(() {
          setState(() {
            extraPicHeight = anim.value;
          });
        });
      prevDy = 0;
    });
  }

  ///计算头高度
  comtupeHeight(double h) {
    setState(() {
      expanedHeight = h;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
    return Scaffold(
      body: Listener(
        onPointerMove: (result) {
          updatePicHeight(result.position.dy);
        },
        onPointerUp: (_) {
          runAnimate();
          animationController.forward(from: 0);
        },
        child: NestedScrollView(
          physics: ClampingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                title: Text(title),
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
                ],
                expandedHeight:
                    (expanedHeight + extraPicHeight) - statusBarHeight,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    constraints.biggest.height < 140.0
                        ? title = '话题详情'
                        : title = '';
                    return FlexibleSpaceBar(
                      background: TocpicDetailsHeadContent(
                        type: widget.type,
                        extraPicHeight: extraPicHeight,
                        comtupeHeight: comtupeHeight,
                      ),
                    );
                  },
                ),
              ),
            ];
          },
          pinnedHeaderSliverHeightBuilder: () {
            return pinnedHeaderHeight;
          },
          innerScrollPositionKeyBuilder: () {
            var index = "Tab";
            index += primaryTC.index.toString();
            return Key(index);
          },
          body: Column(
            children: <Widget>[
              TabBar(
                controller: primaryTC,
                labelColor: Theme.of(context).accentColor,
                indicatorColor: Theme.of(context).accentColor,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(child: Text('默认')),
                  Tab(child: Text('最新')),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: primaryTC,
                  children: <Widget>[
                    TocpicDetailsItemPage(control: control, reality: 'Tab0'),
                    TocpicDetailsItemPage(control: control, reality: 'Tab1'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TocpicDetailsHeadContent extends StatefulWidget {
  final Function comtupeHeight;
  final double extraPicHeight;
  final int type;


  const TocpicDetailsHeadContent({Key key, this.extraPicHeight, this.comtupeHeight, this.type}) : super(key: key);

  @override
  _TocpicDetailsHeadContentState createState() =>
      _TocpicDetailsHeadContentState();
}

class _TocpicDetailsHeadContentState extends State<TocpicDetailsHeadContent>
    with AfterLayoutMixin<TocpicDetailsHeadContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ///图片
              CommonImage(
                image: 'assets/3.jpg',
                height: 150 + widget.extraPicHeight,
                isFilter: true,
                borderRadius: 0,
              ),
              Container(
                margin: EdgeInsets.only(left: 190.w, top: 5),
                child: Text(
                  '#话题名称哈哈哈#',
                  style: TextStyle(fontSize: 30.sp),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, left: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '动态 42',
                        style: TextStyle(color: Colors.grey, fontSize: 26.sp),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        '今日 0',
                        style: TextStyle(color: Colors.grey, fontSize: 26.sp),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                child: Text(
                  '话题描述',
                  style: TextStyle(color: Colors.grey, fontSize: 30.sp),
                ),
              ),
              DivisionLine(),

              ///话题
              HotTocpicDetails(),

              DivisionLine(),
            ],
          ),
          Positioned(
            left: 10,
            top: 110 + widget.extraPicHeight,
            child: CommonImage(
              image: 'assets/3.jpg',
              height: 80,
              width: 80,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RenderBox box = context.findRenderObject();
    double height = box.getMaxIntrinsicHeight(MediaQuery.of(context).size.height);
    widget.comtupeHeight(height);
  }
}

///热门话题
class HotTocpicDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]))),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.publish,
                    color: Theme.of(context).primaryColor,
                  ),
                  width: ScreenUtil().setWidth(40),
                  height: ScreenUtil().setWidth(40),
                ),
                Container(
                  width: ScreenUtil().setWidth(660),
                  child: Text(
                    '【新人必读】 Flutter实战第一季仿社区交友app，走过路过不要错过',
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.publish,
                    color: Theme.of(context).primaryColor,
                  ),
                  width: ScreenUtil().setWidth(40),
                  height: ScreenUtil().setWidth(40),
                ),
                Container(
                  width: ScreenUtil().setWidth(660),
                  child: Text(
                    '【新人必读】 Flutter实战第一季仿社区交友app，走过路过不要错过',
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
