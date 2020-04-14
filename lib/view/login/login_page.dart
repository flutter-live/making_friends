import 'package:flutter/material.dart';

/// @description：登陆页
/// @author：liuzhidong
/// @date：2020/4/14 20:08
/// @version：1.0

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.clear), onPressed: (){}),
        ),
        body: Container(),
      ),
    );
  }
}
