import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:makingfriends/config/global.dart';
import 'package:flutter/cupertino.dart';

/// @description 加载框
/// @author: liuzhidong
/// @data: 2020-02-23 06:28
/// @version: 1.0 

enum Category{
  DoubleBounce,
  Wave,
  FadingFour,
  ThreeBounce,
  PumpingHeart,
  DualRing,
  Ring,
}


///加载框
class ProgressDialog {
  static bool _isShowing = false;
  static BuildContext context = navigatorKey.currentState.overlay.context;

  ///展示
  static void showProgress({
    Widget child,
    Color maskColor = Colors.transparent,
    Color titleColor = Colors.grey,
    String title,
    double titlePadding = 20.0,
    Category category = Category.PumpingHeart,
    Color spinKitColor,
  }) {
    if (!_isShowing) {
      _isShowing = true;
      Navigator.push(
        context,
        _PopRoute(
          child: _Progress(
            child: child,
            maskColor: maskColor,
            title: title,
            titleColor: titleColor,
            titlePadding: titlePadding,
            dismiss: dismiss,
            category: category,
            spinKitColor: spinKitColor ?? Theme.of(context).primaryColor,
          ),
        ),
      );
    }
  }

  ///隐藏
  static void dismiss() {
    BuildContext context = navigatorKey.currentState.overlay.context;
    if (_isShowing) {
      Future.delayed(Duration(milliseconds: 0), () => Navigator.of(context).pop());
      _isShowing = false;
    }
  }
}

///Widget
class _Progress extends StatelessWidget {
  final Widget child;
  final String title;
  final Color maskColor;
  final Color titleColor;
  final Color spinKitColor;
  final double titlePadding;
  final Function dismiss;
  final Category category;

  _Progress({
    Key key,
    this.child,
    this.dismiss,
    this.title,
    this.maskColor,
    this.titleColor = Colors.white,
    this.titlePadding = 20.0,
    this.category,
    this.spinKitColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Material(
        color: maskColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _widget(),
        ),
      ),
      onWillPop: (){
        return Future.value(true);
      },
    );
  }

  List<Widget> _widget() {
    List<Widget> listWidget = [];
    Widget widget;
    if(child == null){
      if(Category.PumpingHeart == category){
        widget = SpinKitPumpingHeart(color: spinKitColor,);
      }else if(Category.DoubleBounce == category){
        widget = SpinKitDoubleBounce(color: spinKitColor,);
      }else if(Category.Wave == category){
        widget = SpinKitWave(color: spinKitColor,);
      }else if(Category.DualRing == category){
        widget = SpinKitDualRing(color: spinKitColor);
      }else if(Category.FadingFour == category){
        widget = SpinKitFadingFour(color: spinKitColor,);
      }else if(Category.Ring == category){
        widget = SpinKitRing(color: spinKitColor);
      }else if(Category.ThreeBounce == category){
        widget = SpinKitThreeBounce(color: spinKitColor,);
      }
      listWidget.add(widget);
    }
    if (title != null && title.isNotEmpty) {
      Widget titleWidget = Padding(
        padding: EdgeInsets.only(top: titlePadding),
        child: Text(
          title,
          style: TextStyle(color: titleColor),
        ),
      );
      listWidget.add(titleWidget);
    }
    return listWidget;
  }
}

///Route
class _PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 200);
  Widget child;

  _PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
