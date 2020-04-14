import 'package:flutter/material.dart';
import 'package:makingfriends/widgets/image_setting.dart';

/// @description： 未登陆
/// @author：liuzhidong
/// @date：2020/4/14 20:38
/// @version：1.0

class LandPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text('登陆社区，体验更多功能', style: TextStyle(fontSize: 18),),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: Image.asset(
                  'assets/wx.png',
                  width: 58,
                  height: 58,
                ),
                onTap: () {},
              ),
              GestureDetector(
                child: Image.asset(
                  'assets/QQ.png',
                  width: 50,
                  height: 50,
                ),
                onTap: () {},
              ),
              GestureDetector(
                child: Image.asset(
                  'assets/wb.png',
                  width: 50,
                  height: 50,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('账号/邮箱/手机登陆', style: TextStyle(color: Colors.black87),),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(Icons.chevron_right),
              ),
            ],
          ),
        )
      ],
    );
  }
}
