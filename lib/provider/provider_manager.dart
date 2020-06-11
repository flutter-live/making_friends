import 'package:makingfriends/viewModel/global_state_model.dart';
import 'package:makingfriends/viewModel/infromation/web_socket_chat.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
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
  ),
  ChangeNotifierProvider<UserVM>(
    create: (context) => UserVM(),
  ),
  ChangeNotifierProvider<GlobalStateModel>(
    create: (context) => GlobalStateModel(),
  ),
  //链接websocket
  ChangeNotifierProvider<WebSocketChat>(
    create: (context) => WebSocketChat(),
  ),

];
