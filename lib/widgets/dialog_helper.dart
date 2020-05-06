import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makingfriends/config/application.dart';

class DialogHelper {
  static showLoginDialog(String title) async {
    return await showCupertinoDialog(
      context: Application.context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              '取消',
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
  }
}
