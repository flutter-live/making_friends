import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/view/my/my_invitation_page.dart';
import 'package:makingfriends/view/my/my_trends_page.dart';
import 'package:makingfriends/widgets/custom_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 我的详细页面
/// @author：liuzhidong
/// @date：2020/4/4 16:35
/// @version：1.0

class MyDetailsPage extends StatefulWidget {
  final int type;

  const MyDetailsPage({Key key, this.type: 0}) : super(key: key);

  @override
  _MyDetailsPageState createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage>
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
  control(bool b, int type) {
    if (type == 0) {
      T = b;
    } else {
      D = b;
    }
    tabControlerListener();
  }

  ///下拉动画
  updatePicHeight(changed) {
    if((expanedHeight + extraPicHeight) > 500) return;

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
                expandedHeight: (expanedHeight + extraPicHeight) - statusBarHeight,
                title: Text(title),
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
                ],
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    constraints.biggest.height < 140.0
                        ? title = '刘志东'
                        : title = '';
                    return FlexibleSpaceBar(
                      background: ComputeMyDetailsHead(
                        type: widget.type,
                        comtupeHeight: comtupeHeight,
                        extraPicHeight: extraPicHeight,
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
                  Tab(child: Text('帖子 2011')),
                  Tab(child: Text('动态 296')),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: primaryTC,
                  children: <Widget>[
                    MyInvitationPage(control: control),
                    MyTrendsPage(control: control)
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

class ComputeMyDetailsHead extends StatefulWidget {
  final Function comtupeHeight;
  final double extraPicHeight;
  final int type;

  const ComputeMyDetailsHead(
      {Key key, this.comtupeHeight, this.extraPicHeight, this.type})
      : super(key: key);

  @override
  _ComputeMyDetailsHeadState createState() => _ComputeMyDetailsHeadState();
}

class _ComputeMyDetailsHeadState extends State<ComputeMyDetailsHead>
    with AfterLayoutMixin<ComputeMyDetailsHead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyDetailsHead(
        type: widget.type,
        height: widget.extraPicHeight,
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RenderBox box = context.findRenderObject();
    double height =
        box.getMaxIntrinsicHeight(MediaQuery.of(context).size.height);
    widget.comtupeHeight(height);
  }
}

class MyDetailsHead extends StatelessWidget {
  final int type;
  final double height;

  const MyDetailsHead({
    Key key,
    this.height,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CommonImage(
                image: 'assets/3.jpg',
                height: 150 + height,
                borderRadius: 0,
              ),

              ///按钮
              MyDetailsButton(
                type: type,
              ),

              Padding(
                padding: EdgeInsets.only(top: 20.w, left: 20.w),
                child: Text(
                  '刘志东',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 42.sp,
                      letterSpacing: 2,
                      color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.w),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20.w, right: 30.w),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '14.9亿',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32.sp,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            '获赞',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 40.w),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32.sp,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            '关注',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20.w),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '4719.1W',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32.sp,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            '粉丝',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 130 + height,
            left: 20.w,
            child: Container(
              height: 130.w,
              width: 130.w,
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Theme.of(context).accentColor,
              ),
//              child: Container(
//                width: 60,
//                height: 60,
//                child: HttpImage(
//                  url: article.user.userpic == null || article.user.userpic.isEmpty ? 'nothing.png' : article.user.userpic,
//                  imageType: article.user.userpic == null || article.user.userpic.isEmpty ? ImageType.assets : ImageType.normal,
//                  errUrl: 'assets/nothing.png',
//                  borderRadius: 100,
//                  placeholderWidth: 10,
//                  placeholderHeight: 10,
//                ),
//              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDetailsButton extends StatelessWidget {
  final int type;

  const MyDetailsButton({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20.w, left: 180.w),
        child: Row(
          children: <Widget>[
            Container(
              width: 300.w,
              child: RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Jump.push('setting/setting_page');
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    type == 0
                        ? Container()
                        : Icon(Icons.add, color: Theme.of(context).accentColor),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        type == 0 ? '编辑资料' : '关注',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            letterSpacing: 5.w),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w),
              width: 150.w,
              child: type == 0
                  ? RaisedButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.white,
                      onPressed: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.add, color: Theme.of(context).accentColor),
                          Text(
                            '好友',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                letterSpacing: 5.w),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            )
          ],
        ));
  }
}
