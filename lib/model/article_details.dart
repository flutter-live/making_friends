import '../model/share.dart';
import '../model/user.dart';

/// @description： 文章详情
/// @author：liuzhidong
/// @date：2020/3/28 12:52
/// @version：1.0

class ArticleDetails {
  String id;
  String userId;
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
  int dingCount;
  int caiCount;
  int commentCount;
  User user;
  List<Images> images;
  Share share;
  List<Support> support;
  DataProcessing processing;

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
      this.dingCount,
      this.caiCount,
      this.user,
      this.images,
      this.share,
      this.support,
      this.commentCount,
      this.processing,
      });

  ArticleDetails.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    userId = json['user_id']?.toString();
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
    dingCount = json['ding_count'];
    caiCount = json['cai_count'];
    commentCount = json['comment_count'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    share = json['share'] != null ? new Share.fromJson(json['share']) : null;
    if (json['support'] != null) {
      support = new List<Support>();
      json['support'].forEach((v) {
        support.add(new Support.fromJson(v));
      });
    }
    processing = json['data_processing'] != null ? new DataProcessing.fromJson(json['data_processing']) : null;
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
    data['ding_count'] = this.dingCount;
    data['cai_count'] = this.caiCount;
    data['comment_count'] = this.commentCount;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.share != null) {
      data['share'] = this.share.toJson();
    }
    if (this.support != null) {
      data['support'] = this.support.map((v) => v.toJson()).toList();
    }
    if (this.processing != null) {
      data['data_processing'] = this.processing.toJson();
    }
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


class Support {
  int id;
  int userId;
  int postId;
  int type;
  int createTime;
  int supportCount;
  int unsupportCount;

  Support({this.id, this.userId, this.postId, this.type, this.createTime});

  Support.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    type = json['type'];
    createTime = json['create_time'];
    supportCount = json['support_count'];
    unsupportCount = json['unsupport_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['type'] = this.type;
    data['create_time'] = this.createTime;
    data['support_count'] = this.supportCount;
    data['unsupport_count'] = this.unsupportCount;
    return data;
  }
}

class DataProcessing {
  String id;
  int userId;
  int postId;
  int type;
  int createTime;
  int supportCount;
  int unsupportCount;
  int commentCount;
  bool isFollow;

  DataProcessing({this.id, this.userId, this.postId, this.type, this.createTime, this.commentCount});

  DataProcessing.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    userId = json['user_id'];
    postId = json['post_id'];
    type = json['type'];
    createTime = json['create_time'];
    supportCount = json['support_count'];
    unsupportCount = json['unsupport_count'];
    commentCount = json['comment_count'];
    isFollow = json['is_follow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['type'] = this.type;
    data['create_time'] = this.createTime;
    data['support_count'] = this.supportCount;
    data['unsupport_count'] = this.unsupportCount;
    data['comment_count'] = this.commentCount;
    data['is_follow'] = this.isFollow;
    return data;
  }
}

