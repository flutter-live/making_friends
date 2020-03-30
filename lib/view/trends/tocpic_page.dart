import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/model/hot_topic.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view_model/tocpic_v_m.dart';
import 'package:makingfriends/view_model/trends_v_m.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description： 话题
/// @author：liuzhidong
/// @date：2020/3/30 21:10
/// @version：1.0

class TocpicPage extends StatefulWidget {
  @override
  _TocpicPageState createState() => _TocpicPageState();
}

class _TocpicPageState extends State<TocpicPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TocpicVM>(
      model: TocpicVM(),
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Container(
          color: Color.fromRGBO(245, 245, 245, 1),
          child: SmartRefresher(
              controller: model.refreshController,
              header: WaterDropMaterialHeader(),
              footer: ClassicFooter(),
              //onRefresh: model.refresh,
              //  onLoading: model.loadMore,
              enablePullUp: true,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 5, left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('热门分类', style: TextStyle(fontSize: ScreenUtil().setSp(34)),),
                        Row(
                          children: <Widget>[
                            Text('更多', style: TextStyle(color: Colors.grey),),
                            Icon(Icons.chevron_right, color: Colors.grey,)
                          ],
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      scrollDirection: Axis.horizontal,
                      child: ButtonBar(
                        buttonPadding: EdgeInsets.all(0),
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 10), child: RaisedButton(
                              child: Text('关注', style: TextStyle(color: Colors.black54, letterSpacing: 5),),
                              onPressed: (){}),),
                          Padding(padding: EdgeInsets.only(right: 10), child: RaisedButton(
                              child: Text('推荐', style: TextStyle(color: Colors.black54, letterSpacing: 5),),
                              onPressed: (){}),),
                          Padding(padding: EdgeInsets.only(right: 10), child: RaisedButton(
                              child: Text('体育', style: TextStyle(color: Colors.black54, letterSpacing: 5),),
                              onPressed: (){}),),
                          Padding(padding: EdgeInsets.only(right: 10), child: RaisedButton(
                              child: Text('热点', style: TextStyle(color: Colors.black54, letterSpacing: 5),),
                              onPressed: (){}),),
                          Padding(padding: EdgeInsets.only(right: 10), child: RaisedButton(
                              child: Text('财经', style: TextStyle(color: Colors.black54, letterSpacing: 5),),
                              onPressed: (){}),),
                          Padding(padding: EdgeInsets.only(right: 10), child: RaisedButton(
                              child: Text('娱乐', style: TextStyle(color: Colors.black54, letterSpacing: 5),),
                              onPressed: (){}),),
                        ],
                          ),),
                  Divider(height: 1, color: Colors.grey,),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                          ),
                          height: ScreenUtil().setHeight(50),
                          width: double.infinity,
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
                        )
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
