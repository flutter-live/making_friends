import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:makingfriends/view/community/category_page.dart';
import 'package:makingfriends/view/search/search_page.dart';
import 'package:makingfriends/widgets/cirle_avatar_image.dart';
import 'package:provider/provider.dart';
import '../../provider/provider_widget.dart';
import '../../view_model/community_v_m.dart';
import '../community/drawer_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 社区
/// @author：liuzhidong
/// @date：2020/3/28 17:29
/// @version：1.0

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  ValueNotifier<int> valueNotifier;

  TabController tabController;

  @override
  void initState() {
    valueNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<CommunityVM>(
      model: CommunityVM(),
      onModelReady: (communityVM) {},
      builder: (context, communityVM, child) {
        return ValueListenableProvider<int>.value(
            value: valueNotifier,
            child: DefaultTabController(
              length: communityVM.map.length,
              initialIndex: valueNotifier.value,
              child: Builder(builder: (context) {
                if (tabController == null) {
                  tabController = DefaultTabController.of(context);
                  tabController.addListener(() {
                    valueNotifier.value = tabController.index;
                  });
                }
                return Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    title: GestureDetector(
                      onTap: (){
                        showSearch(context: context, delegate: DefaultSearchDelegate());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setSp(10))),
                          color: Colors.white70,
                        ),
                        width: ScreenUtil().setWidth(750),
                        height: ScreenUtil().setHeight(50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: Colors.black26,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                '搜索帖子',
                                style: TextStyle(
                                    color: Colors.black26,
                                    fontSize: ScreenUtil().setSp(24)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      tabs: communityVM.map
                          .map((v) => Tab(text: v['title']))
                          .toList(),
                    ),
                    leading: GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                        ),
                        child: CircleAvatarImage(),
                      ),
                      onTap: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.local_offer,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  drawer: DrawerPage(),
                  body: TabBarView(
                    children: communityVM.map.map((v) => CommunityListPage()).toList(),
                  ),
                );
              }),
            ));
      },
    );
  }
}
