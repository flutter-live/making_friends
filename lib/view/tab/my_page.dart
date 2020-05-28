import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/view/my/land_page.dart';
import 'package:makingfriends/view/my/my_head_page.dart';
import 'package:makingfriends/view/my/my_list_item_page.dart';
import 'package:makingfriends/viewModel/my_v_m.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/custom_image.dart';
import 'package:provider/provider.dart';

/// @description： 我的
/// @author：liuzhidong
/// @date：2020/3/28 17:46
/// @version：1.0

class MyPage extends StatelessWidget {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    return ProviderWidget<MyVM>(
      model: MyVM(top: top),
      builder: (context, model, child) {
        return CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {
                      Jump.push('setting/setting_page');
                    }),
              ],
              expandedHeight: model.expandedHeight,
              flexibleSpace: MyHeadContent(),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: CommonImage(
                          borderRadius: 5,
                          image: 'assets/3.jpg',
                          isType: false,
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyListItemPage(),
                    ],
                  ),
                );
              }, childCount: 1),
            )
          ],
        );
      },
    );
  }
}

///头部主要内容
class MyHeadContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MyVM, UserVM>(builder: (context, model1, model2, child) {
      return Container(
        child: Stack(
          children: <Widget>[
            ///图片
            CommonImage(
              image: 'assets/1.jpg',
              isType: false,
              width: double.infinity,
              height: model1.expandedHeight + model1.top,
              isFilter: true,
              borderRadius: 0,
            ),
            Positioned(
              top: model1.top,
              child: Container(
                width: 750.w,
                child: model2.user == null ? LandPageHeight() : MyHeadHeight(),
              ),
            )
          ],
        ),
      );
    });
  }
}

class LandPageHeight extends StatefulWidget {
  @override
  _LandPageHeightState createState() => _LandPageHeightState();
}

class _LandPageHeightState extends State<LandPageHeight>
    with AfterLayoutMixin<LandPageHeight> {
  @override
  Widget build(BuildContext context) {
    return LandPage();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RenderBox box = context.findRenderObject();
    double height =
        box.getMaxIntrinsicHeight(MediaQuery.of(context).size.height);
    MyVM myVM = Provider.of<MyVM>(context, listen: false);
    myVM.height = height;
  }
}

class MyHeadHeight extends StatefulWidget {
  @override
  _MyHeadHeightState createState() => _MyHeadHeightState();
}

class _MyHeadHeightState extends State<MyHeadHeight>
    with AfterLayoutMixin<MyHeadHeight> {
  @override
  Widget build(BuildContext context) {
    return MyHead();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RenderBox box = context.findRenderObject();
    double height =
        box.getMaxIntrinsicHeight(MediaQuery.of(context).size.height);
    MyVM myVM = Provider.of<MyVM>(context, listen: false);
    myVM.height = height;
  }
}
