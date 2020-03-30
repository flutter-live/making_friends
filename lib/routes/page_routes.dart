import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../view/tab/tab_page.dart';

/// @description： 路由配置
/// @author：liuzhidong
/// @date：2020/3/27 23:36
/// @version：1.0

class PageRoutes {
  static setRouters(Router router){
    //没有找到页面
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params){
          print('================== 没有找到对应的页面 =======================');
          return;
        }
    );

    pageRouters.forEach((path, handler){
      router.define(path, handler: handler);
    });
  }
}

final Map<String, Handler> pageRouters = {
  '/': Handler(handlerFunc: (context, params) => TabPage()),
};

