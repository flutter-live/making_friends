/// @description： 描述
/// @author：liuzhidong
/// @date：2020/6/7 14:37
/// @version：1.0

class ChatListModel {
  String userId;
  String avatar;
  String username;
  int updateTime;
  String data;
  int noread;
  String type;
  int time;

  ChatListModel(
      {this.userId = '0',
        this.avatar,
        this.username,
        this.updateTime,
        this.data,
        this.noread,
        this.type,
        this.time,
      });

  ChatListModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id']?.toString();
    avatar = json['avatar'];
    username = json['username'];
    updateTime = json['update_time'];
    data = json['data'];
    noread = json['noread'];
    type = json['type'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    data['update_time'] = this.updateTime;
    data['data'] = this.data;
    data['noread'] = this.noread;
    data['type'] = this.type;
    data['time'] = this.time;
    return data;
  }
}