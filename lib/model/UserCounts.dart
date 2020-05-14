/// @description： 用户相关信息
/// @author：liuzhidong
/// @date：2020/5/9 17:59
/// @version：1.0

class UserCounts {
  int postCount;
  int commentsCount;
  int todayPostsCount;
  int withfollowCount;
  int withfenCount;
  int totalDingCount;
  int friendCount;

  UserCounts({
    this.postCount = 0,
    this.commentsCount = 0,
    this.todayPostsCount = 0,
    this.withfollowCount = 0,
    this.withfenCount = 0,
    this.totalDingCount = 0,
    this.friendCount = 0,
  });

  UserCounts.fromJson(Map<String, dynamic> json) {
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
