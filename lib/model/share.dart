import 'package:flutter/material.dart';

/// @description： 分享
/// @author：liuzhidong
/// @date：2020/3/28 13:28
/// @version：1.0

class Share {
  int id;
  int userId;
  String title;
  String titlepic;
  String content;
  int sharenum;
  String path;
  int type;
  int createTime;
  int postClassId;
  int shareId;
  int isopen;
  int status;

  Share(
      {this.id,
        this.userId,
        this.title,
        this.titlepic,
        this.content,
        this.sharenum,
        this.path,
        this.type,
        this.createTime,
        this.postClassId,
        this.shareId,
        this.isopen,
        this.status});

  Share.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    titlepic = json['titlepic'];
    content = json['content'];
    sharenum = json['sharenum'];
    path = json['path'];
    type = json['type'];
    createTime = json['create_time'];
    postClassId = json['post_class_id'];
    shareId = json['share_id'];
    isopen = json['isopen'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['titlepic'] = this.titlepic;
    data['content'] = this.content;
    data['sharenum'] = this.sharenum;
    data['path'] = this.path;
    data['type'] = this.type;
    data['create_time'] = this.createTime;
    data['post_class_id'] = this.postClassId;
    data['share_id'] = this.shareId;
    data['isopen'] = this.isopen;
    data['status'] = this.status;
    return data;
  }
}
