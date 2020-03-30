import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
    options.connectTimeout = 3000;
    options.receiveTimeout = 3000;
    return options;
  }
}