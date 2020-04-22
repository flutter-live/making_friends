import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// @description： provider封装类
/// @author：liuzhidong
/// @date：2020/3/27 18:31
/// @version：1.0

class ProviderWidget<A extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<A> builder;
  final A model;
  final Widget child;
  final Function(A model) onModelReady;
  final bool autoDispose;

  const ProviderWidget(
      {Key key,
      @required this.model,
      @required this.builder,
      this.onModelReady,
      this.autoDispose: true,
      this.child})
      : super(key: key);

  @override
  _ProviderWidgetState<A> createState() => _ProviderWidgetState<A>();
}

class _ProviderWidgetState<A extends ChangeNotifier>
    extends State<ProviderWidget<A>> {
  A model;

  @override
  void initState() {
    // TODO: implement initState
    model = widget.model;
    widget.onModelReady?.call(model);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (widget.autoDispose) model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<A>.value(
      value: model,
      child: Consumer<A>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
      builder;
  final A model1;
  final B model2;
  final Widget child;
  final Function(A model1, B model2) onModelReady;
  final bool autoDispose;

  const ProviderWidget2({
    Key key,
    @required this.model1,
    @required this.model2,
    @required this.builder,
    this.onModelReady,
    this.autoDispose: true,
    this.child,
  }) : super(key: key);

  @override
  _ProviderWidgetState2<A, B> createState() => _ProviderWidgetState2<A, B>();
}

class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  A model1;
  B model2;

  @override
  void initState() {
    // TODO: implement initState
    model1 = widget.model1;
    model2 = widget.model2;
    widget.onModelReady?.call(model1, model2);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (widget.autoDispose) {
      model1.dispose();
      model2.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>.value(value: model1),
        ChangeNotifierProvider<B>.value(value: model2),
      ],
      child: Consumer2<A, B>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}


class ProviderWidget3<A extends ChangeNotifier, B extends ChangeNotifier, C extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, C model3, Widget child)
  builder;
  final A model1;
  final B model2;
  final C model3;
  final Widget child;
  final Function(A model1, B model2, C model3) onModelReady;
  final bool autoDispose;

  const ProviderWidget3({
    Key key,
    @required this.model1,
    @required this.model2,
    @required this.model3,
    @required this.builder,
    this.onModelReady,
    this.autoDispose: true,
    this.child,
  }) : super(key: key);

  @override
  _ProviderWidgetState3<A, B, C> createState() => _ProviderWidgetState3<A, B, C>();
}

class _ProviderWidgetState3<A extends ChangeNotifier, B extends ChangeNotifier, C extends ChangeNotifier>
    extends State<ProviderWidget3<A, B, C>> {
  A model1;
  B model2;
  C model3;

  @override
  void initState() {
    // TODO: implement initState
    model1 = widget.model1;
    model2 = widget.model2;
    model3 = widget.model3;
    widget.onModelReady?.call(model1, model2, model3);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (widget.autoDispose) {
      model1.dispose();
      model2.dispose();
      model3.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>.value(value: model1),
        ChangeNotifierProvider<B>.value(value: model2),
        ChangeNotifierProvider<C>.value(value: model3),
      ],
      child: Consumer3<A, B, C>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}