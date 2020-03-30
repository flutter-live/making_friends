/// @description： 描述
/// @author：liuzhidong
/// @date：2020/3/28 13:36
/// @version：1.0


class NumberUser {
  int postCount;
  int commentsCount;
  int todayPostsCount;
  int withfollowCount;
  int withfenCount;
  int totalDingCount;
  int friendCount;

  NumberUser(
      {this.postCount,
        this.commentsCount,
        this.todayPostsCount,
        this.withfollowCount,
        this.withfenCount,
        this.totalDingCount,
        this.friendCount});

  NumberUser.fromJson(Map<String, dynamic> json) {
    postCount = json['post_count'];
    commentsCount = json['comments_count'];
    todayPostsCount = json['today_posts_count'];
    withfollowCount = json['withfollow_count'];
    withfenCount = json['withfen_count'];
    totalDingCount = json['total_ding_count'];
    friendCount = json['friend_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_count'] = this.postCount;
    data['comments_count'] = this.commentsCount;
    data['today_posts_count'] = this.todayPostsCount;
    data['withfollow_count'] = this.withfollowCount;
    data['withfen_count'] = this.withfenCount;
    data['total_ding_count'] = this.totalDingCount;
    data['friend_count'] = this.friendCount;
    return data;
  }
}