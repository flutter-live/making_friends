/// @description： 热门话题 搜索话题
/// @author：liuzhidong
/// @date：2020/3/28 12:42
/// @version：1.0

class HotTopic {
  int id;
  String title;
  String titlepic;
  String desc;
  int type;
  int createTime;
  int topicClassId;
  int postCount;
  int todaypostCount;

  HotTopic(
      {this.id,
        this.title,
        this.titlepic,
        this.desc,
        this.type,
        this.createTime,
        this.topicClassId,
        this.postCount,
        this.todaypostCount});

  HotTopic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titlepic = json['titlepic'];
    desc = json['desc'];
    type = json['type'];
    createTime = json['create_time'];
    topicClassId = json['topic_class_id'];
    postCount = json['post_count'];
    todaypostCount = json['todaypost_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['titlepic'] = this.titlepic;
    data['desc'] = this.desc;
    data['type'] = this.type;
    data['create_time'] = this.createTime;
    data['topic_class_id'] = this.topicClassId;
    data['post_count'] = this.postCount;
    data['todaypost_count'] = this.todaypostCount;
    return data;
  }
}