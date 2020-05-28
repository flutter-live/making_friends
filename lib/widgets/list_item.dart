import 'package:flutter/material.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/utils/date_utils.dart';
import 'package:makingfriends/utils/fluro_convert_utils.dart';
import 'package:makingfriends/viewModel/global_state_model.dart';
import 'package:makingfriends/viewModel/tab/community_v_m.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'custom_image.dart';
import 'image_setting.dart';

/// @description： 话题列表
/// @author：liuzhidong
/// @date：2020/3/29 17:37
/// @version：1.0

class ListItem extends StatelessWidget {
  final ArticleDetails article;
  final Function onTap;

  const ListItem({Key key, this.article, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<GlobalStateModel, UserVM>(
      builder: (context, model, userModel, child) {
        if (model[article?.id] != null) {
          article..processing = model[article?.id];
        }
        if (userModel.user.userinfo.userId == article.userId) {
          article..processing.isFollow = true;
        }
        if (model[article?.userId] == null) {
          return child;
        }
        DataProcessing processing = model[article?.userId];
        bool isFollow = processing?.isFollow ?? article.processing.isFollow;
        article..processing.isFollow = isFollow;

        return ListItemMenu(
          article: article,
          onTap: onTap,
        );
      },
      child: ListItemMenu(article: article, onTap: onTap),
    );
  }
}

///主要内容
class ListItemMenu extends StatelessWidget {
  final ArticleDetails article;
  final Function onTap;

  const ListItemMenu({Key key, this.article, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      child: Material(
        child: InkWell(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HeadLine(
                    isIcon: false,
                    leadingWidget: GestureDetector(
                      onTap: () => Jump.push(
                          'view/my/my_details_page?id=${article.user.id}&&isFollow=${article.processing.isFollow}'),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: HttpImage(
                          url: article.user.userpic == null ||
                                  article.user.userpic.isEmpty
                              ? 'nothing.png'
                              : article.user.userpic,
                          errUrl: 'assets/nothing.png',
                          borderRadius: 100,
                          placeholderWidth: 10,
                          placeholderHeight: 10,
                        ),
                      ),
                    ),
                    title: Text(article.user.username),
                    titleWidget: Container(
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        color: Colors.pinkAccent,
                      ),
                      child: Text(
                        article.user.userinfo.qg == 0
                            ? '保密'
                            : (article.user.userinfo.qg == 1
                            ? '未婚'
                            : '已婚'),
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    subtitle: DateUtils.instance.getFormartData(
                        timeSamp: article.createTime,
                        format: 'yyyy-MM-dd hh:mm:ss'),
                    trailingWidget: Follow(
                      article: article,
                      onTap: onTap,
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    article.title,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                article.titlepic.isEmpty
                    ? Container()
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: CommonImage(
                          height: 150,
                          image: article.titlepic,
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Operation(article: article),
                ),
              ],
            ),
          ),
          onTap: () {
            String item = FluroConvertUtils.object2string(article);
            Jump.push('view/community/community_details_page?article=$item');
          },
        ),
      ),
    );
  }
}

///关注操作
class Follow extends StatelessWidget {
  final ArticleDetails article;
  final Function onTap;

  const Follow({Key key, this.article, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FollowVM>(
      model: FollowVM(),
      builder: (context, model, child) {
        return article.processing.isFollow
            ? Container()
            : Material(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      '关注',
                      style: TextStyle(letterSpacing: 5, color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    await model.loadData(article);
                    onTap ?? null;
                  },
                ),
              );
      },
    );
  }
}

///操作栏
class Operation extends StatelessWidget {
  final ArticleDetails article;

  const Operation({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TopStepVM>(
      model: TopStepVM(),
      builder: (context, model, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TopListItem(article: article),
            StopListItem(article: article),
            FlatButton(
              onPressed: () {},
              child: Row(
                children: <Widget>[
                  Icon(Icons.message),
                  SizedBox(
                    width: 5,
                  ),
                  Text(article.processing.commentCount.toString()),
                ],
              ),
            ),
            FlatButton(
              onPressed: () =>
                  Share.share('${article.title} /n ${article.titlepic}'),
              child: Row(
                children: <Widget>[
                  Icon(Icons.launch),
                  SizedBox(
                    width: 5,
                  ),
                  Text('分享'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

///顶
class TopListItem extends StatelessWidget {
  final ArticleDetails article;

  const TopListItem({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProcessing processing = article.processing;
    return Consumer<TopStepVM>(
      builder: (context, model, child) {
        String supportStr = processing.supportCount > 0
            ? processing.supportCount.toString()
            : '顶';
        return FlatButton(
          onPressed: () async {
            await model.loadData(article, 0);
          },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                color: processing.type == 0
                    ? Theme.of(context).primaryColor
                    : null,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                supportStr,
                style: TextStyle(
                    color: processing.type == 0
                        ? Theme.of(context).primaryColor
                        : null),
              ),
            ],
          ),
        );
      },
    );
  }
}

///踩
class StopListItem extends StatelessWidget {
  final ArticleDetails article;

  const StopListItem({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProcessing processing = article.processing;
    return Consumer<TopStepVM>(
      builder: (context, model, child) {
        String unsupportStr = processing.unsupportCount > 0
            ? processing.unsupportCount.toString()
            : '踩';
        return FlatButton(
          onPressed: () async {
            await model.loadData(article, 1);
          },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.thumb_down,
                color: processing.type == 1
                    ? Theme.of(context).primaryColor
                    : null,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                unsupportStr,
                style: TextStyle(
                    color: processing.type == 1
                        ? Theme.of(context).primaryColor
                        : null),
              ),
            ],
          ),
        );
      },
    );
  }
}
