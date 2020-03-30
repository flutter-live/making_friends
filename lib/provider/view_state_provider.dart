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

  void setError(){
    //viewState = ViewState.error;
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