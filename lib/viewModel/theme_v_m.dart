import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @description： 主题 字体
/// @author：liuzhidong
/// @date：2020/3/28 16:25
/// @version：1.0

class ThemeVM with ChangeNotifier {
  themeData(){
    return ThemeData(
      primaryColor: Colors.pinkAccent,
      primaryColorBrightness: Brightness.dark,
      accentColor: Colors.pinkAccent,
      accentColorBrightness: Brightness.dark,
      buttonColor: Colors.pinkAccent
    );
  }

}