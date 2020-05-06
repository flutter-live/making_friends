import 'package:flutter/material.dart';
import 'package:makingfriends/model/Comment.dart';
import 'package:makingfriends/model/article_details.dart';

/// @description： 描述
/// @author：liuzhidong
/// @date：2020/5/3 00:01
/// @version：1.0

class ClassUntils {
  ///列表
  static DataProcessing getProcessing(ArticleDetails item) {
    DataProcessing processing = DataProcessing();
    processing.id = item.id;
    processing.unsupportCount = item.caiCount;
    processing.supportCount = item.dingCount;
    processing.type = item.support.length > 0 ? item.support[0].type : 2;
    processing.commentCount = item.commentCount;
    processing.isFollow = item.user.fens.length > 0 ? true : false;
    return processing;
  }

  ///评论
  static List<Comment> commentdata = [];
  static List<Comment> getCommentData(List<Comment> list, {int id = 0, init = true}) {
    if(init) commentdata = [];

    list.forEach((item) {
      if (item.fid == id) {
        commentdata.add(item);
        getCommentData(list, id: item.id, init: false);
      }
    });
    return commentdata;
  }

}
