import 'package:flutter/material.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/viewModel/community_details_post_v_m.dart';
import 'package:makingfriends/viewModel/global_state_model.dart';
import 'package:makingfriends/widgets/custom_comment.dart';
import 'package:makingfriends/widgets/custom_division_line.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:makingfriends/widgets/list_item.dart';
import 'package:makingfriends/widgets/view_state.dart';
import 'package:provider/provider.dart';

/// @description: 社区内容详情页
/// @author: liuzhidong
/// @date: 2020/4/2 10:40
/// @version: 1.0

class CommunityDetailsPage extends StatelessWidget {
  final ArticleDetails article;

  const CommunityDetailsPage({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ProviderWidget<CommentVM>(
          model: CommentVM(),
          onModelReady: (model) async{
            model.id = article.id;
            await model.initData();
            model.browseHistory(article);
          },
          builder: (context, model, child) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ListItem(
                        article: article,
                      ),
                      DivisionLine(),
                      CommentItem(
                        model: model,
                        id: article.id,
                        processing: article.processing,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            top:
                            BorderSide(width: 0.5, color: Colors.black87))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '留下你的精彩评论吧',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.send,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () async{
                    dynamic news = await Navigator.push(context, PopRoute(child: PopPage()));
                    if(news == null) return;
                    await model.comment(0, news, article.id);
                    if(model.isDef){
                      model.findData();
                      ++article.processing.commentCount;
                      GlobalStateModel globalStateModel = Provider.of<GlobalStateModel>(context, listen: false);
                      globalStateModel.addFavourite(article.id, article.processing);
                    }
                  },
                ),

              ],
            );
          }),
    );
  }
}


///评论
class CommentItem extends StatelessWidget {
  final CommentVM model;
  final int id;
  final DataProcessing processing;

  const CommentItem({Key key, this.id, this.model, this.processing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.isBusy) {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: ViewStateBusyWidget(),
      );
    }
    if (model.isError) {
      return ViewStateErrorWidget(
          error: model.viewStateError, onPressed: model.initData);
    }
    if (model.isEmpty) {
      return ViewStateEmptyWidget(
        message: '没有评论哦',
        buttonTextData: '刷新',
        onPressed: () {
          model.initData();
        },
      );
    }
    List<Widget> widgets = [];

    Widget handline = HeadLine(
      title: Text('最新评论 ${model.list.length}'),
      isIcon: false,
    );
    widgets.add(handline);

    List<Widget> items = model.list
        .map((item) => item.fid == 0
        ? Container(
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
      child: CustomComment(
        id: id,
        comment: item,
        processing: processing,
      ),
    )
        : Container(
      margin: EdgeInsets.only(
        left: 35,
        bottom: 10,
        right: 5,
      ),
      child: SecondComment(
        id: id,
        comment: item,
        processing: processing,
      ),
    ))
        .toList();

    widgets.addAll(items);
    return Container(
      child: Column(children: widgets),
    );
  }
}

///弹出评论框
// ignore: must_be_immutable
class PopPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String title;

    return Material(
        color: Colors.black12,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  child: ListView(),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                color: Colors.white,
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: '留下你的精彩评论吧',
                              border: InputBorder.none,
                          ),
                          onChanged: (value) => title = value,
                          onSubmitted: (value) => title = value,
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.black54,
                          ),
                          onPressed: () => Navigator.pop(context, title)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 200);
  final Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}


