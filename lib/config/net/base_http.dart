import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:provider/provider.dart';
import '../application.dart';

/// @description： dio
/// @author：liuzhidong
/// @date：2020/3/26 23:37
/// @version：1.0


// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

abstract class BaseHttp extends DioForNative {
  BaseHttp(){
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors..add(HeaderInterceptor())
                ..add(LogInterceptor(responseBody: false));
    init();
  }
  void init();
}

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async{
    String token = Provider.of<UserVM>(Application.context, listen: false).user.token;
    options.connectTimeout = 3000;
    options.receiveTimeout = 3000;
    options.headers['token'] = token;
    return options;
  }
}


/// 子类需要重写
abstract class BaseResponseData {
  int code = 0;
  String message;
  dynamic data;

  bool get success;

  BaseResponseData({this.code, this.message, this.data});

  @override
  String toString() {
    return 'BaseRespData{code: $code, message: $message, data: $data}';
  }
}


/// 接口的code没有返回为true的异常
class NotSuccessException implements Exception {
  String message;

  NotSuccessException.fromRespData(BaseResponseData respData) {
    message = respData.message;
  }

  @override
  String toString() {
    return 'NotExpectedException{respData: $message}';
  }
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}