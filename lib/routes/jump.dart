import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:makingfriends/config/global.dart';

/// @description：路由参数配置
/// @author：liuzhidong
/// @date：2020/3/27 23:50
/// @version：1.0



class Jump {
  final router = Router();
  final BuildContext context = navigatorKey.currentState.overlay.context;
  push(String path,
      { bool token = true,
        bool replace = false,
        bool clearStack = false,
        String clearAppointStack,
        TransitionType transition = TransitionType.inFromRight,
        Duration transitionDuration = const Duration(milliseconds: 250),
        RouteTransitionsBuilder transitionBuilder}) async {
    if (token) {
      return router.navigateTo(context, path,
          replace: replace,
          clearStack: clearStack,
          transition: transition,
          transitionDuration: transitionDuration);
    } else {
      //跳转到登陆页面
    }
  }

}