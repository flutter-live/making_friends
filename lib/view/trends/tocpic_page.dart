import 'package:flutter/material.dart' hide showSearch;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:makingfriends/flutter/search.dart';
import 'package:makingfriends/model/post_class.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/utils/fluro_convert_utils.dart';
import 'package:makingfriends/view/search/search_page.dart';
import 'package:makingfriends/viewModel/tocpic_class_v_m.dart';
import 'package:makingfriends/viewModel/tocpic_v_m.dart';
import 'package:makingfriends/widgets/article_skeleton.dart';
import 'package:makingfriends/widgets/custom_division_line.dart';
import 'package:makingfriends/widgets/custom_image.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:makingfriends/widgets/skeleton.dart';
import 'package:makingfriends/widgets/tocpic_list_item.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:provider/provider.dart';

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
    return ProviderWidget2<TocpicVM, TocpicClassVM>(
      model1: TocpicVM(),
      model2: TocpicClassVM(),
      onModelReady: (model, model2) {
        model2.initData();
        model.initData();
      },
      builder: (context, model, model2, child) {
        if (model2.isBusy) {
          return ViewStateBusyWidget();
        }
        if (model.isBusy) {
          return Skeleton(
            betweeChild: (BuildContext context, int index) => ArticleSkeleton(),
          );
        }
        if (model.isError) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        }
        return Container(
          child: ListView(
            children: <Widget>[
              HeadLine(
                title: Text('热门推荐'),
                trailing: '更多',
                onTop: () {
                  Jump.push('view/trends/tocpic_classification_page');
                },
              ),

              ///热门推荐
              TocpicRecommendation(),

              ///分割线
              Divider(height: 1, color: Colors.grey),

              ///搜索
              TocpicSearch(),

              ///轮播图
              TocpicSwiper(),

              SizedBox(height: 10),

              ///分割线
              DivisionLine(),

              HeadLine(
                title: Text('最近更新'),
                isIcon: false,
              ),

              ///最近话题
              LateTocpic(),
            ],
          ),
        );
      },
    );
  }
}

///轮播广告栏
class TocpicSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TocpicVM>(
      builder: (context, model, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: 150,
          child: Swiper(
            loop: true,
            autoplay: true,
            autoplayDelay: 5000,
            pagination: SwiperPagination(),
            itemCount: model.listAdsense.length,
            itemBuilder: (BuildContext context, int index) {
              return CommonImage(
                width: double.infinity,
                height: 150,
                image: model.listAdsense[index].src,
              );
            },
          ),
        );
      },
    );
  }
}

///最近话题
class LateTocpic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TocpicVM>(
      builder: (context, model, child) {
        return Column(
          children: model.listHotTopic.map((item) {
            return Container(
              margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
              child: TocpicListItem(
                title: item.title,
                subtitle: item.desc,
                devDayNumber: item.todaypostCount,
                devNumber: item.postCount,
                image: item.titlepic,
                onTap: () {
                  String hotTopic = FluroConvertUtils.object2string(item);
                  Jump.push(
                      'view/trends/tocpic_details_page?hotTopic=$hotTopic');
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

///热门推荐
class TocpicRecommendation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TocpicClassVM>(
      builder: (context, model, child) {
        List<PostClass> list = model.list;
        return SingleChildScrollView(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          scrollDirection: Axis.horizontal,
          child: ButtonBar(
            buttonPadding: EdgeInsets.all(0),
            children: List.generate(
              list.length,
              (index) => Padding(
                padding: EdgeInsets.only(right: 10),
                child: RaisedButton(
                    child: Text(
                      list[index].classname,
                      style: TextStyle(color: Colors.white, letterSpacing: 5),
                    ),
                    onPressed: () => Jump.push(
                        'view/trends/tocpic_classification_page?page=$index')),
              ),
            ),
          ),
        );
      },
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
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[200],
              ),
              height: 35,
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
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => showSearch(
              context: context,
              delegate: DefaultSearchDelegate(
                hintText: '搜索话题',
                type: 'topic',
              ),
            ),
          )
        ],
      ),
    );
  }
}
