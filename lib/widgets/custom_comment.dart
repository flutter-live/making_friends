import 'package:flutter/material.dart';
import 'package:makingfriends/model/Comment.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/utils/date_utils.dart';
import 'package:makingfriends/view/community/community_details_page.dart';
import 'package:makingfriends/viewModel/community_details_post_v_m.dart';
import 'package:makingfriends/viewModel/global_state_model.dart';
import 'package:provider/provider.dart';
import 'image_setting.dart';

/// @description: 评论
/// @author: liuzhidong
/// @date: 2020/4/2 11:04
/// @version: 1.0

class CustomComment extends StatelessWidget {
  final int id;
  final Comment comment;
  final DataProcessing processing;

  const CustomComment({Key key, this.comment, this.id, this.processing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () async{
          CommentVM model = Provider.of<CommentVM>(context, listen: false);
          GlobalStateModel model2 = Provider.of<GlobalStateModel>(context, listen: false);
          dynamic news = await Navigator.push(context, PopRoute(child: PopPage()));
          if(news == null) return;
          await model.comment(comment.id, news, id);
          if(model.isDef){
            model.findData();
            ++processing.commentCount;
            model2.addFavourite(id, processing);
          }
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ///头像
              Container(
                width: 30,
                height: 30,
                child: HttpImage(
                  url: comment.user.userpic == null ||
                          comment.user.userpic.isEmpty
                      ? 'nothing.png'
                      : comment.user.userpic,
                  errUrl: 'assets/nothing.png',
                  borderRadius: 100,
                  placeholderWidth: 10,
                  placeholderHeight: 10,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      comment.user.username,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5, top: 5),
                    child: Text(
                      comment.data,
                      style: TextStyle(
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      DateUtils.instance.getFormartData(
                          timeSamp: comment.createTime,
                          format: 'yyyy-MM-dd hh:mm:ss'),
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  // CustomComment(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

///二级聊天
class SecondComment extends StatelessWidget {
  final int id;
  final Comment comment;
  final DataProcessing processing;

  const SecondComment({Key key, this.comment, this.id, this.processing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () async{
          CommentVM model = Provider.of<CommentVM>(context, listen: false);
          GlobalStateModel model2 = Provider.of<GlobalStateModel>(context, listen: false);
          dynamic news = await Navigator.push(context, PopRoute(child: PopPage()));
          if(news == null) return;
          await model.comment(comment.id, news, id);
          if(model.isDef){
            model.findData();
            ++processing.commentCount;
            model2.addFavourite(id, processing);
          }
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ///头像
                  Container(
                    width: 20,
                    height: 20,
                    child: HttpImage(
                      url: comment.user.userpic == null ||
                              comment.user.userpic.isEmpty
                          ? 'nothing.png'
                          : comment.user.userpic,
                      errUrl: 'assets/nothing.png',
                      borderRadius: 100,
                      placeholderWidth: 10,
                      placeholderHeight: 10,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 5,
                    ),
                    child: Text(
                      comment.user.username,
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 25, bottom: 5, top: 5),
                child: Text(
                  comment.data,
                  style: TextStyle(letterSpacing: 1, fontSize: 13),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25),
                child: Text(
                  DateUtils.instance.getFormartData(
                      timeSamp: comment.createTime,
                      format: 'yyyy-MM-dd hh:mm:ss'),
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ),
              // CustomComment(),
            ],
          ),
        ),
      ),
    );
  }
}
