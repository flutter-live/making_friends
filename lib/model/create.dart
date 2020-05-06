/// @description： 发布文章
/// @author：liuzhidong
/// @date：2020/4/27 23:26
/// @version：1.0

class Create {
  List<Imglist> imglist;
  String text;
  int isopen;
  int topicId;
  int postClassId;

  Create(
      {this.imglist, this.text, this.isopen, this.topicId, this.postClassId});

  Create.fromJson(Map<String, dynamic> json) {
    if (json['imglist'] != null) {
      imglist = new List<Imglist>();
      json['imglist'].forEach((v) {
        imglist.add(new Imglist.fromJson(v));
      });
    }
    text = json['text'];
    isopen = json['isopen'];
    topicId = json['topic_id'];
    postClassId = json['post_class_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.imglist != null) {
      data['imglist'] = this.imglist.map((v) => v.toJson()).toList();
    }
    data['text'] = this.text;
    data['isopen'] = this.isopen;
    data['topic_id'] = this.topicId;
    data['post_class_id'] = this.postClassId;
    return data;
  }
}

class Imglist {
  String id;

  Imglist({this.id});

  Imglist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}