import 'model/making_friends_code.dart';

/// @description： 选择类别
/// @author：liuzhidong
/// @date：2020/5/23 11:12
/// @version：1.0

class CategoryMakingJson {
  //性别
  static final List<MakingFriendsCode> sex = [
    MakingFriendsCode(name: '男', code: 1),
    MakingFriendsCode(name: '女', code: 2),
    MakingFriendsCode(name: '保密', code: 0),
  ];

  //情感
  static final List<MakingFriendsCode> emotion = [
    MakingFriendsCode(name: '已婚', code: 2),
    MakingFriendsCode(name: '未婚', code: 1),
    MakingFriendsCode(name: '保密', code: 0),
  ];

  //工作
  static final List<MakingFriendsCode> job = [
    MakingFriendsCode(name: 'IT'),
    MakingFriendsCode(name: '教师'),
    MakingFriendsCode(name: '码农'),
  ];
}
