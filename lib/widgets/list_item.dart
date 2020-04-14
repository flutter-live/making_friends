import 'package:flutter/material.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makingfriends/utils/date_utils.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
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
                  leadingWidget: Container(
                    width: 40,
                    height: 40,
                    child: HttpImage(
                      url: article.user.userpic == null || article.user.userpic.isEmpty ? 'nothing.png' : article.user.userpic,
                      errUrl: 'assets/nothing.png',
                      borderRadius: 100,
                      placeholderWidth: 10,
                      placeholderHeight: 10,
                    ),
                  ),
                  title: Text(article.user.username),
                  titleWidget: Container(
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.pinkAccent,
                    ),
                    child: Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.mars,
                          size: 12,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5,),
                        Text(
                          article.user.userinfo.sex == 0 ? '男' : '女',
                          style:
                              TextStyle(fontSize: 12, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  subtitle: DateUtils.instance.getFormartData(timeSamp: article.createTime, format: 'yyyy-MM-dd hh:mm:ss'),
                  trailingWidget: Material(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          '关注',
                          style: TextStyle(
                              letterSpacing: 5, color: Colors.white),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(article.title, style: TextStyle(fontSize: 18),),
                ),
                article.titlepic.isEmpty
                    ? Container()
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: CommonImage(
                          height: 150,
                          image: article.titlepic,
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Operation(),
                ),
              ],
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class Operation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Icon(Icons.thumb_up),
              SizedBox(
                width: 5,
              ),
              Text('顶'),
            ],
          ),
        ),
        FlatButton(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Icon(Icons.thumb_down),
              SizedBox(
                width: 5,
              ),
              Text('踩'),
            ],
          ),
        ),
        FlatButton(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Icon(Icons.message),
              SizedBox(
                width: 5,
              ),
              Text('1'),
            ],
          ),
        ),
        FlatButton(
          onPressed: () {
            Share.share('check out my website https://example.com');
          },
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
  }
}
