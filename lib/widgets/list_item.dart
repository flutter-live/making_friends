import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/model/hot_topic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// @description： 话题列表
/// @author：liuzhidong
/// @date：2020/3/29 17:37
/// @version：1.0

class ListItem extends StatelessWidget {
  final HotTopic hotTopic;

  const ListItem({Key key, this.hotTopic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
          child: Material(
            child: InkWell(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Image.asset('assets/default.png'),
                      ),
                      title: Row(
                        children: <Widget>[
                          Text('18811475898'),
                         Container(
                           margin: EdgeInsets.only(left: 10),
                           padding: EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(22)),
                             color: Colors.pinkAccent,
                           ),
                           child: Row(
                             children: <Widget>[
                               FaIcon(FontAwesomeIcons.mars, size: ScreenUtil().setSp(25),color: Colors.white,),
                               Text('未知', style:TextStyle(fontSize: ScreenUtil().setSp(22), color: Colors.white),)
                             ],
                           ),
                         )

                        ],
                      ),
                      subtitle: Text('2019-06-30 下午 9：16'),
                      trailing: FlatButton(
                          color: Colors.pinkAccent,
                          onPressed: () {}, child: Text('关注', style: TextStyle(color: Colors.white, letterSpacing: 10),),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      child: Text('第一个项目'),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/3.jpg',
                          height: ScreenUtil().setHeight(300),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      child: Operation(),
                    ),
                  ],
                ),
              ),
              onTap: (){},
            ),
          )
        );
  }
}

class Operation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.thumb_up), onPressed: () {}),
              Text('顶'),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.thumb_down), onPressed: () {}),
              Text('踩'),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.message), onPressed: () {}),
              Text('1'),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.launch), onPressed: () {}),
              Text('分享'),
            ],
          ),
        ),
      ],
    );
  }
}
