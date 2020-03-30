import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:makingfriends/config/net/base_http.dart';

/// @description：http
/// @author：liuzhidong
/// @date：2020/3/26 23:37
/// @version：1.0

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = '';
    interceptors..add(CustomInterceptors());
  }

}

class CustomInterceptors extends InterceptorsWrapper{

  @override
  Future onRequest(RequestOptions options) {
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {


    return super.onResponse(response);
  }
}
