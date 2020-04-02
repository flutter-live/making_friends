import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/widgets/cirle_avatar_image.dart';
import 'package:makingfriends/widgets/custom_image.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';

/// @description： 我的
/// @author：liuzhidong
/// @date：2020/3/28 17:46
/// @version：1.0

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  double extraPicHeight = 0;
  double prevDy = 0;
  double rpx;
  AnimationController animationController;
  Animation<double> anim;
  TabController tabController;
  double expanedHeight = 300;

  @override
  void initState() {
    super.initState();
    prevDy = 0;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  updatePicHeight(changed) {
    if (prevDy == 0) {
      prevDy = changed;
    }
    extraPicHeight += changed - prevDy;
    setState(() {
      prevDy = changed;
      extraPicHeight = extraPicHeight;
    });
  }

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

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Listener(
        onPointerMove: (result) {
          updatePicHeight(result.position.dy);
        },
        onPointerUp: (_) {
          runAnimate();
          animationController.forward(from: 0);
        },
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
                primary: false,
                floating: true,
                pinned: false,
                snap: false,
                expandedHeight: expanedHeight.h + extraPicHeight.h,
                flexibleSpace: MyHeadContent(
                  height: _height,
                  extraPicHeight: extraPicHeight,
                )
            ),
            SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  child: ListView(
                    children: <Widget>[
                      HeadLine(title: 'MVP', titleWidget: Icon(Icons.beenhere, color: Colors.pinkAccent,),)
                    ],
                  ),
                )

            ),
          ],
        ),


      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

///头部主要内容
class MyHeadContent extends StatelessWidget {
  final double height;
  final double extraPicHeight;

  const MyHeadContent({Key key, this.height, this.extraPicHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(extraPicHeight);
    //print(350 + extraPicHeight);
    double _imageHeight = 300 + extraPicHeight;
    return Stack(
      children: <Widget>[
        ///图片
        CommonImage(
          image: 'assets/1.jpg',
          height: _imageHeight > 0 ? _imageHeight : 0,
          isFilter: true,
          margin: EdgeInsets.all(0),
          borderRadius: 0,
        ),
        Positioned(
          top: height.h + extraPicHeight.h,
          child: Container(
            width: 750.w,
            child: Column(
              children: <Widget>[
                HeadLine(
                  leadingWidget: CircleAvatarImage(
                    width: 100,
                    height: 100,
                  ),
                  title: '18811475898',
                  subtitle: '2019-06-30 下午 9：16',
                  isIcon: false,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '帖子',
                            style: TextStyle(
                              fontSize: 28.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '帖子',
                            style: TextStyle(
                              fontSize: 28.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '帖子',
                            style: TextStyle(
                              fontSize: 28.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '帖子',
                            style: TextStyle(
                              fontSize: 28.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
