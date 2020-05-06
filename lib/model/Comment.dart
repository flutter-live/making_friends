import 'package:makingfriends/model/user.dart';

/// @description：评论
/// @author：liuzhidong
/// @date：2020/5/3 12:39
/// @version：1.0

class Comment {
  int id;
  int userId;
  int fid;
  int fnum;
  String data;
  int createTime;
  int postId;
  User user;

  Comment(
      {this.id,
        this.userId,
        this.fid,
        this.fnum,
        this.data,
        this.createTime,
        this.postId,
        this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fid = json['fid'];
    fnum = json['fnum'];
    data = json['data'];
    createTime = json['create_time'];
    postId = json['post_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['fid'] = this.fid;
    data['fnum'] = this.fnum;
    data['data'] = this.data;
    data['create_time'] = this.createTime;
    data['post_id'] = this.postId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

