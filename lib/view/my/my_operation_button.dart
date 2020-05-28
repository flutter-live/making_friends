import 'package:flutter/material.dart';
import 'package:makingfriends/model/article_details.dart';
import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/viewModel/global_state_model.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:provider/provider.dart';

/// @description：我的详细 操作按钮
/// @author：liuzhidong
/// @date：2020/5/17 18:05
/// @version：1.0

class MyOperationButton extends StatelessWidget {
  final User user;
  final bool isFollow;

  const MyOperationButton({Key key, this.user, this.isFollow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<GlobalStateModel, UserVM>(
        builder: (context, model, modelUser, child) {
      DataProcessing processing = model[user?.userinfo?.userId];
      bool isTypeFollow = processing?.isFollow ?? isFollow;
      bool type = modelUser.user.userinfo.userId == user.userinfo.userId;
      return Container(
        margin: EdgeInsets.only(top: 5, left: 100),
        child: Container(
          margin: EdgeInsets.only(left: 10),
          width: 150,
          child: RaisedButton(
            padding: EdgeInsets.all(0),
            color: Colors.white,
            onPressed: () {},
            child: type
                ? Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      '编辑资料',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          letterSpacing: 5),
                    ),
                  )
                : isTypeFollow
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.cancel,
                              color: Theme.of(context).accentColor),
                          Text(
                            '取消关注',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                letterSpacing: 5),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.add, color: Theme.of(context).accentColor),
                          Text(
                            '关注',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                letterSpacing: 5),
                          ),
                        ],
                      ),
          ),
        ),
      );
    });
  }
}
