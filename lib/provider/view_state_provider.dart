import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:makingfriends/provider/view_state.dart';

/// @description： provider 更新状态码
/// @author：liuzhidong
/// @date：2020/3/27 19:49
/// @version：1.0


class ViewStateProvider with ChangeNotifier {

  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  ViewState _viewState;

  ViewStateProvider({ViewState viewState}) : _viewState = viewState ?? ViewState.busy;


  ViewState get viewState => _viewState;


  set viewState(ViewState viewState){
    _viewState = viewState;
    notifyListeners();
  }

  /// ViewStateError
  ViewStateError _viewStateError;

  ViewStateError get viewStateError => _viewStateError;

  bool get isDel => viewState == ViewState.def;

  bool get isBusy => viewState == ViewState.busy;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;


  void setDef(){
    viewState = ViewState.def;
  }

  void setBusy(){
    viewState = ViewState.busy;
  }

  void setEmpty(){
    viewState = ViewState.empty;
  }


  /// [e]分类Error和Exception两种
  void setError(e, stackTrace, {String message}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;

    /// 见https://github.com/flutterchina/dio/blob/master/README-ZH.md#dioerrortype
    if (e is DioError) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.SEND_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        // timeout
        errorType = ViewStateErrorType.networkTimeOutError;
        message = e.error;
      } else if (e.type == DioErrorType.RESPONSE) {
        // incorrect status, such as 404, 503...
        message = e.error;
      } else if (e.type == DioErrorType.CANCEL) {
        // to be continue...
        message = e.error;
      } else {
        // dio将原error重新套了一层
        e = e.error;
//        if (e is UnAuthorizedException) {
//          stackTrace = null;
//          errorType = ViewStateErrorType.unauthorizedError;
//        } else if (e is NotSuccessException) {
//          stackTrace = null;
//          message = e.message;
//        } else if (e is SocketException) {
//          errorType = ViewStateErrorType.networkTimeOutError;
//          message = e.message;
//        } else {
//          message = e.message;
//        }
      }
    }
    viewState = ViewState.error;
    _viewStateError = ViewStateError(
      errorType,
      message: message,
      errorMessage: e.toString(),
    );
    //printErrorStack(e, stackTrace);
    onError(viewStateError);
  }

  void onError(ViewStateError viewStateError) {}

  /// 显示错误消息
  showErrorMessage(context, {String message}) {
    if (viewStateError != null || message != null) {
      if (viewStateError.isNetworkTimeOut) {
        //message ??= S.of(context).viewStateMessageNetworkError;
      } else {
        message ??= viewStateError.message;
      }
//      Future.microtask(() {
//        showToast(message, context: context);
//      });
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    debugPrint('view_state_model dispose -->$runtimeType');
    super.dispose();
  }

}