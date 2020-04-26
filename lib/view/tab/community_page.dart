import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makingfriends/model/post_class.dart';
import 'package:makingfriends/view/community/category_page.dart';
import 'package:makingfriends/view/search/search_page.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/image_setting.dart';
import 'package:makingfriends/widgets/view_state.dart';
import '../../provider/provider_widget.dart';
import '../../viewModel/tab/community_v_m.dart';
import '../community/drawer_page.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget2<CommunityVM, UserVM>(
      model1: CommunityVM(),
      model2: UserVM(),
      onModelReady: (model, model1) {
        model.initData();
      },
      builder: (context, model, model1, child) {
        if(model.isBusy){
          return ViewStateBusyWidget();
        }
        if(model.isError){
          return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
        }
        if (model.isEmpty) {
          return ViewStateEmptyWidget(
            message: '没有话题哦',
            buttonTextData: '刷新',
            onPressed: (){
              model.initData();
            },
          );
        }
        List<PostClass> list = model.list;
        return DefaultTabController(
          length: list.length,
          child: Builder(
            builder: (context) {
              return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  title: GestureDetector(
                    onTap: () {
                      showSearch(
                          context: context, delegate: DefaultSearchDelegate());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(5)),
                        color: Colors.white70,
                      ),
                      width: 1000,
                      height: 30,
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
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    tabs: list.map((item) => Tab(text: item.classname)).toList(),
                  ),
                  leading: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                          child: HttpImage(
                            url: model1.user?.userpic ?? 'assets/wb.png',
                            errUrl: 'assets/wb.png',
                            borderRadius: 100,
                            placeholderWidth: 10,
                            placeholderHeight: 10,
                          ),
                        ),
                    ),
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                ),
                drawer: DrawerPage(),
                body: TabBarView(
                  children: list.map((item) => CommunityListPage(id: item.id,)).toList(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
