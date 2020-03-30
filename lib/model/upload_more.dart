/// @description： 上传多图
/// @author：liuzhidong
/// @date：2020/3/28 12:46
/// @version：1.0

class UploadMore {
  String url;
  int userId;
  int createTime;
  int updateTime;
  String id;

  UploadMore(
      {this.url, this.userId, this.createTime, this.updateTime, this.id});

  UploadMore.fromJson(Map<String, dynamic> json) {
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