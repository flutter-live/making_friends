import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/view_model/tocpic_v_m.dart';
import 'package:makingfriends/widgets/custom_division_line.dart';
import 'package:makingfriends/widgets/custom_image.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:makingfriends/widgets/tocpic_list_item.dart';
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
          child: SmartRefresher(
            controller: model.refreshController,
            header: WaterDropMaterialHeader(),
            footer: ClassicFooter(),
            //onRefresh: model.refresh,
            //  onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView(
              children: <Widget>[
                HeadLine(title: '热门推荐', trailing: '更多', onTop: (){
                  Jump.push('view/trends/tocpic_classification_page');
                },),

                ///热门推荐
                TocpicRecommendation(),

                ///分割线
                Divider(height: 1, color: Colors.grey),

                ///搜索
                TocpicSearch(),

                ///图片
                CommonImage(
                  image: 'assets/3.jpg',
                  height: 250,
                  margin: EdgeInsets.only(left: 10, right: 10),
                ),

                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),

                ///分割线
                DivisionLine(),

                HeadLine(
                  title: '最近更新',
                  isIcon: false,
                ),

                TocpicListItem(
                  title: '#话题名称###',
                  subtitle: '话题描述',
                  devDayNumber: 1,
                  devNumber: 0,
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                TocpicListItem(
                  title: '#话题名称###',
                  subtitle: '话题描述',
                  devDayNumber: 1,
                  devNumber: 0,
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                TocpicListItem(
                  title: '#话题名称###',
                  subtitle: '话题描述',
                  devDayNumber: 1,
                  devNumber: 0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

///热门推荐
class TocpicRecommendation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      scrollDirection: Axis.horizontal,
      child: ButtonBar(
        buttonPadding: EdgeInsets.all(0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: RaisedButton(
                child: Text(
                  '关注',
                  style: TextStyle(color: Colors.black54, letterSpacing: 5),
                ),
                onPressed: () {}),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: RaisedButton(
                child: Text(
                  '推荐',
                  style: TextStyle(color: Colors.black54, letterSpacing: 5),
                ),
                onPressed: () {}),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: RaisedButton(
                child: Text(
                  '体育',
                  style: TextStyle(color: Colors.black54, letterSpacing: 5),
                ),
                onPressed: () {}),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: RaisedButton(
                child: Text(
                  '热点',
                  style: TextStyle(color: Colors.black54, letterSpacing: 5),
                ),
                onPressed: () {}),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: RaisedButton(
                child: Text(
                  '财经',
                  style: TextStyle(color: Colors.black54, letterSpacing: 5),
                ),
                onPressed: () {}),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: RaisedButton(
                child: Text(
                  '娱乐',
                  style: TextStyle(color: Colors.black54, letterSpacing: 5),
                ),
                onPressed: () {}),
          ),
        ],
      ),
    );
  }
}

///搜索
class TocpicSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[300],
            ),
            height: ScreenUtil().setHeight(60),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.black45,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    '搜索帖子',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: ScreenUtil().setSp(30)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
