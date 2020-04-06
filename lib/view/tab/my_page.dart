import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/view/my/my_head_page.dart';
import 'package:makingfriends/view/my/my_list_item_page.dart';
import 'package:makingfriends/widgets/custom_image.dart';

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
  double expanedHeight = 400;

  @override
  void initState() {
    super.initState();
    prevDy = 0;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  updatePicHeight(changed) {
    if(changed - prevDy > 0){
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
    return Listener(
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
                  actions: <Widget>[
                    IconButton(icon: Icon(Icons.more_horiz), onPressed: (){
                      Jump.push('view/my/my_details_page');
                    }),
                  ],
                  expandedHeight: expanedHeight.h + extraPicHeight.h - 50,
                  flexibleSpace: MyHeadContent(
                    height: _height,
                    extraPicHeight: extraPicHeight,
                  )),
              SliverList(
                delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 20.w),
                    child: Column(
                      children: <Widget>[
                        CommonImage(
                          image: 'assets/3.jpg',
                          height: 180,
                          margin: EdgeInsets.only(left: 20.w, right: 20.w),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        MyListItemPage(),
                      ],
                    ),
                  );
                }, childCount: 1),
              )
            ],
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
    double _imageHeight = 500 + extraPicHeight;
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
          top: height.h + extraPicHeight.h + 100.h,
          child: Container(
            width: 750.w,
            child: MyHead(),
          ),
        )
      ],
    );
  }
}
