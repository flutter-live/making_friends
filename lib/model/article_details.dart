import '../model/share.dart';
import '../model/user.dart';

/// @description： 文章详情
/// @author：liuzhidong
/// @date：2020/3/28 12:52
/// @version：1.0

class ArticleDetails {
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
  User user;
  List<Images> images;
  Share share;
  List<String> support;

  ArticleDetails(
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
      this.status,
      this.user,
      this.images,
      this.share,
      this.support});

  ArticleDetails.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    share = json['share'] != null ? new Share.fromJson(json['share']) : null;
    support = json['support'].cast<String>();
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
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.share != null) {
      data['share'] = this.share.toJson();
    }
    data['support'] = this.support;
    return data;
  }
}

class Images {
  String url;
  Pivot pivot;

  Images({this.url, this.pivot});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int id;
  int postId;
  int imageId;
  int createTime;

  Pivot({this.id, this.postId, this.imageId, this.createTime});

  Pivot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    imageId = json['image_id'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['image_id'] = this.imageId;
    data['create_time'] = this.createTime;
    return data;
  }
}

