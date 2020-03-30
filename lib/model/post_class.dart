/// @description：文章分类 话题分类
/// @author：liuzhidong
/// @date：2020/3/28 00:32
/// @version：1.0

class PostClass {
  int id;
  String classname;

  PostClass({this.id, this.classname});

  PostClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classname = json['classname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['classname'] = this.classname;
    return data;
  }
}