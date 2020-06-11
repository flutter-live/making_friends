/// @description： 聊天model
/// @author：liuzhidong
/// @date：2020/6/7 13:58
/// @version：1.0

class ChatModel {
  String toId;
  int fromId;
  String fromUsername;
  String fromUserpic;
  String type;
  String data;
  int time;

  ChatModel(
      {this.toId,
        this.fromId,
        this.fromUsername,
        this.fromUserpic,
        this.type,
        this.data,
        this.time,
      });

  ChatModel.fromJson(Map<String, dynamic> json) {
    toId = json['to_id'];
    fromId = json['from_id'];
    fromUsername = json['from_username'];
    fromUserpic = json['from_userpic'];
    type = json['type'];
    data = json['data'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to_id'] = this.toId;
    data['from_id'] = this.fromId;
    data['from_username'] = this.fromUsername;
    data['from_userpic'] = this.fromUserpic;
    data['type'] = this.type;
    data['data'] = this.data;
    data['time'] = this.time;
    return data;
  }
}