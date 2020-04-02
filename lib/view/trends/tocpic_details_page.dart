import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view/trends/tocpic_details_item_page.dart';
import 'package:makingfriends/view_model/tocpic_details_v_m.dart';
import 'package:makingfriends/widgets/custom_division_line.dart';
import 'package:makingfriends/widgets/custom_image.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

/// @description: 话题详情
/// @author: liuzhidong
/// @date: 2020/3/31 16:21
/// @version: 1.0

class TocpicDetailsPage extends StatefulWidget {
  @override
  _TocpicDetailsPageState createState() => _TocpicDetailsPageState();
}

class _TocpicDetailsPageState extends State<TocpicDetailsPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TocpicDetailsVM>(
      model: TocpicDetailsVM(),
      onModelReady: (model) {},
      builder: (context, model, child) {
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            body: NestedScrollView(
              physics: ClampingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    floating: false,
                    pinned: true,
                    snap: false,
                    title: Text('话题详情'),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.more_horiz), onPressed: () {}),
                    ],
                    expandedHeight: model.height,
                    flexibleSpace: FlexibleSpaceBar(
                      background: TocpicDetailsHeadContent(),
                    ),
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Material(
                          color: Colors.white,
                          child: TabBar(
                              labelColor: Colors.pinkAccent,
                              indicatorColor: Colors.pinkAccent,
                              unselectedLabelColor: Colors.black,
                              tabs: <Widget>[
                                Tab(
                                  text: '默认',
                                ),
                                Tab(
                                  text: '最新',
                                ),
                              ]),
                        )),
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  TocpicDetailsItemPage(),
                  TocpicDetailsItemPage()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TocpicDetailsHeadContent extends StatefulWidget {
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
                height: 300,
                isFilter: true,
                margin: EdgeInsets.all(0),
                borderRadius: 0,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: ScreenUtil().setWidth(190), top: 5),
                child: Text(
                  '#话题名称哈哈哈#',
                  style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, left: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '动态 42',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(26)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        '今日 0',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(26)),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                child: Text(
                  '话题描述',
                  style: TextStyle(
                      color: Colors.grey, fontSize: ScreenUtil().setSp(30)),
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
            top: ScreenUtil().setHeight(240),
            child: CommonImage(
              image: 'assets/3.jpg',
              height: 120,
              width: 150,
              margin: EdgeInsets.all(0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RenderBox box = context.findRenderObject();
    double height =
        box.getMaxIntrinsicHeight(MediaQuery.of(context).size.width);
    TocpicDetailsVM tocpicDetailsVMp = Provider.of(context, listen: false);
    tocpicDetailsVMp.setHeigth(height);
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
