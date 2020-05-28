import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/model/making_friends_code.dart';

/// @description： cupertino风格
/// @author：liuzhidong
/// @date：2020/4/27 21:58
/// @version：1.0

cupertinoBottomSheet({
   List<MakingFriendsCode> data,
   Function(MakingFriendsCode v) onConfirm,
}) async {
  var v = await showCupertinoModalPopup(
    context: Application.context,
    builder: (context) {
      return CupertinoActionSheet(
        actions: data
            .map(
              (item) => CupertinoActionSheetAction(
                child: Text(item.name),
                onPressed: () {
                  Navigator.pop(context, item);
                },
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: Text('取消'),
        ),
      );
    },
  );
  if(v == null) return;
  onConfirm(v);
}

