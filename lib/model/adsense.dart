/// @description： 广告
/// @author：liuzhidong
/// @date：2020/3/28 13:31
/// @version：1.0

class Adsense {
  int id;
  String src;
  String url;
  int type;
  int createTime;

  Adsense({this.id, this.src, this.url, this.type, this.createTime});

  Adsense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    src = json['src'];
    url = json['url'];
    type = json['type'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
    data['url'] = this.url;
    data['type'] = this.type;
    data['create_time'] = this.createTime;
    return data;
  }
}