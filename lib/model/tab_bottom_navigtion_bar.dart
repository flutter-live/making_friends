import 'package:flutter/material.dart';

/// @description： 底部导航栏
/// @author：liuzhidong
/// @date：2020/4/12 11:15
/// @version：1.0

class TaBottomNavigtionBar {
  IconData icon;
  String name;

  TaBottomNavigtionBar({this.icon, this.name});

  TaBottomNavigtionBar.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['name'] = this.name;
    return data;
  }


}