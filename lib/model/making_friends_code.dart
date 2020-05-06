/// @description： code码
/// @author：liuzhidong
/// @date：2020/4/27 23:10
/// @version：1.0

class MakingFriendsCode {
  int code;
  String name;
  List<MakingFriendsCode> children;

  MakingFriendsCode({this.code, this.name});

  MakingFriendsCode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    if (json['children'] != null) {
      children = new List<MakingFriendsCode>();
      json['children'].forEach((v) {
        children.add(new MakingFriendsCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
