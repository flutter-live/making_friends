import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/view/my/my_basic_page.dart';
import 'package:makingfriends/view/my/my_invitation_page.dart';
import 'package:makingfriends/view/my/my_operation_button.dart';
import 'package:makingfriends/view/my/my_relation_page.dart';
import 'package:makingfriends/view/my/my_trends_page.dart';
import 'package:makingfriends/viewModel/user_counts_v_m.dart';
import 'package:makingfriends/viewModel/user_info_v_m.dart';
import 'package:makingfriends/widgets/custom_image.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:provider/provider.dart';

/// @description： 我的详细页面
/// @author：liuzhidong
/// @date：2020/4/4 16:35
/// @version：1.0

class MyDetailsPage extends StatefulWidget {
  final int id;
  final bool isFollow;

  const MyDetailsPage({Key key, this.id, this.isFollow}) : super(key: key);

  @override
  _MyDetailsPageState createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  double extraPicHeight = 0;
  double prevDy = 0;
  AnimationController animationController;
  Animation<double> anim;
  double expanedHeight = 350; //初始高度350
  bool T = true;
  bool D = true;
  bool X = true;
  TabController primaryTC;
  String title = ''; //标题 设置动态标题 初始为空 当滑动一定高度显示

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

  ///解决手势冲突
  ///tab 左右滑动会产生上下滚动，因此此方法来判断滑动的方向，此方法并不严谨 待优化
  control(bool b, int type) {
    if (type == 0) {
      T = b;
    } else {
      D = b;
    }
    tabControlerListener();
  }

  void tabControlerListener() {
    X = primaryTC.index == 0 ? X = T : X = D;
  }

  ///下拉动画
  updatePicHeight(changed) {
    if ((expanedHeight + extraPicHeight) > 400) return;

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
        child: ProviderWidget2<UserInfo, UserCountsVM>(
          model1: UserInfo(),
          model2: UserCountsVM(),
          onModelReady: (model, model1) {
            model.user.id = widget.id;
            model.initData();
            model1.getAssignUserCounts(widget.id);
          },
          builder: (context, model, model1, child) {
            if (model.isBusy) {
              return ViewStateBusyWidget();
            }
            if (model.isError) {
              return ViewStateErrorWidget(
                  error: model.viewStateError,
                  onPressed: () {
                    model.initData();
                    model1.getAssignUserCounts(widget.id);
                  });
            }
            if (model.isEmpty) {
              return ViewStateEmptyWidget(
                message: '没有话题哦',
                buttonTextData: '刷新',
                onPressed: () {
                  model.initData();
                  model1.getAssignUserCounts(widget.id);
                },
              );
            }

            return NestedScrollView(
              physics: ClampingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    expandedHeight:
                        (expanedHeight + extraPicHeight) - statusBarHeight,
                    title: Text(title),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.more_horiz), onPressed: () {}),
                    ],
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        constraints.biggest.height < 140.0
                            ? title = model.user.username
                            : title = '';
                        return FlexibleSpaceBar(
                          background: ComputeMyDetailsHead(
                            comtupeHeight: comtupeHeight,
                            extraPicHeight: extraPicHeight,
                            isFollow: widget.isFollow,
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
                      Tab(child: Text('帖子')),
                      Tab(child: Text('动态')),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: primaryTC,
                      children: <Widget>[
                        MyInvitationPage(
                            control: control, id: model.user.userinfo.userId),
                        MyTrendsPage(
                          control: control,
                          id: widget.id,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

///自动计算头部高度
class ComputeMyDetailsHead extends StatefulWidget {
  final Function comtupeHeight;
  final double extraPicHeight;
  final bool isFollow;

  const ComputeMyDetailsHead(
      {Key key, this.comtupeHeight, this.extraPicHeight, this.isFollow})
      : super(key: key);

  @override
  _ComputeMyDetailsHeadState createState() => _ComputeMyDetailsHeadState();
}

class _ComputeMyDetailsHeadState extends State<ComputeMyDetailsHead>
    with AfterLayoutMixin<ComputeMyDetailsHead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyDetailsHead(height: widget.extraPicHeight, isFollow: widget.isFollow,),
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

///头部内容信息
class MyDetailsHead extends StatelessWidget {
  final double height;
  final bool isFollow;

  const MyDetailsHead({
    Key key,
    this.height,
    this.isFollow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserInfo, UserCountsVM>(
      builder: (context, model, model1, child) {
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
                    width: double.infinity,
                    isType: false,
                    isFilter: true,
                  ),

                  ///按钮
                  MyOperationButton(user: model.user, isFollow: isFollow),

                  ///个人详细基本信息
                  MyBasicPage(user: model.user),

                  ///其他关联信息
                  MyRelation(userCounts: model1.userCounts)
                ],
              ),
              Positioned(
                top: 130 + height,
                left: 10,
                child: MyAvatarPage(user: model.user),
              ),
            ],
          ),
        );
      },
    );
  }
}
