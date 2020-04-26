/// @description： 上传图片
/// @author：liuzhidong
/// @date：2020/4/24 22:57
/// @version：1.0

class Upload {
  String url;
  int userId;
  int createTime;
  int updateTime;
  String id;

  Upload({this.url, this.userId, this.createTime, this.updateTime, this.id});

  Upload.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    userId = json['user_id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['user_id'] = this.userId;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['id'] = this.id;
    return data;
  }
}