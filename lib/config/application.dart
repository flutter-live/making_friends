import 'package:fluro/fluro.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @description： 描述
/// @author：liuzhidong
/// @date：2020/3/28 16:01
/// @version：1.0

class Application{
  ///全局路由
  static Router router;

  /// app全局配置 eg:theme
  static SharedPreferences sharedPreferences;

  /// 初始化
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}