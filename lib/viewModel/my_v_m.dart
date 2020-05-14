import 'package:makingfriends/provider/view_state_provider.dart';

/// @description： 我的
/// @author：liuzhidong
/// @date：2020/5/10 14:15
/// @version：1.0

class MyVM extends ViewStateProvider {
  final double top;

  MyVM({this.top});

  double _height = 150;

  double get height => _height;

  set height(double h) {
    _height = h;
    notifyListeners();
  }

  double get expandedHeight => height + 20;
}
