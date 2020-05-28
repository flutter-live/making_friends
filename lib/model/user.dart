/// @description： 用户
/// @author：liuzhidong
/// @date：2020/3/28 13:27
/// @version：1.0

class User {
  int id;
  String username;
  String userpic;
  bool password;
  String phone;
  String email;
  int status;
  int createTime;
  String logintype;
  String token;
  Userinfo userinfo;
  List<Fens> fens;
  List<String> blacklist;

  User(
      {this.id,
        this.username,
        this.userpic,
        this.password,
        this.phone,
        this.email,
        this.status,
        this.createTime,
        this.logintype,
        this.token,
        this.userinfo,
        this.fens,
        this.blacklist});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    userpic = json['userpic'];
    password = json['password'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    createTime = json['create_time'];
    logintype = json['logintype'];
    token = json['token'];
    userinfo = json['userinfo'] != null
        ? new Userinfo.fromJson(json['userinfo'])
        : null;
    if (json['fens'] != null) {
      fens = new List<Fens>();
      json['fens'].forEach((v) {
        fens.add(new Fens.fromJson(v));
      });
    }
    //blacklist = json['blacklist'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['userpic'] = this.userpic;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['create_time'] = this.createTime;
    data['logintype'] = this.logintype;
    data['token'] = this.token;
    if (this.userinfo != null) {
      data['userinfo'] = this.userinfo.toJson();
    }
    if (this.fens != null) {
      data['fens'] = this.fens.map((v) => v.toJson()).toList();
    }
    data['blacklist'] = this.blacklist;
    return data;
  }
}

class Userinfo {
  int id;
  int userId;
  int age;
  int sex;
  int qg;
  String job;
  String path;
  String birthday;
  String name;

  Userinfo(
      {this.id,
        this.userId,
        this.age,
        this.sex,
        this.qg,
        this.job,
        this.path,
        this.birthday,
        this.name,
      });

  Userinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    age = json['age'];
    sex = json['sex'];
    qg = json['qg'];
    job = json['job'];
    path = json['path'];
    birthday = json['birthday'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['age'] = this.age;
    data['sex'] = this.sex;
    data['qg'] = this.qg;
    data['job'] = this.job;
    data['path'] = this.path;
    data['birthday'] = this.birthday;
    data['name'] = this.name;
    return data;
  }
}

class Fens {
  int id;
  String username;
  String userpic;
  String phone;
  String email;
  int status;
  int createTime;
  Pivot pivot;

  Fens(
      {this.id,
        this.username,
        this.userpic,
        this.phone,
        this.email,
        this.status,
        this.createTime,
        this.pivot});

  Fens.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    userpic = json['userpic'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    createTime = json['create_time'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['userpic'] = this.userpic;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['create_time'] = this.createTime;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int id;
  int followId;
  int userId;
  int createTime;

  Pivot({this.id, this.followId, this.userId, this.createTime});

  Pivot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    followId = json['follow_id'];
    userId = json['user_id'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['follow_id'] = this.followId;
    data['user_id'] = this.userId;
    data['create_time'] = this.createTime;
    return data;
  }
}