import 'package:flutter/material.dart';
import '../viewModel/theme_v_m.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// @description：provider 初始化配合
/// @author：liuzhidong
/// @date：2020/3/28 16:21
/// @version：1.0

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ThemeVM>(
    create: (context) => ThemeVM(),
  )

];
