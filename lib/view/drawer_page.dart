import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:makingfriends/widgets/custom_image.dart';

/// @description： 抽屉
/// @author：liuzhidong
/// @date：2020/3/29 11:41
/// @version：1.0

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).padding.top;
    return Drawer(
      child:  Column(
        children: <Widget>[
          Head(height: _height),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),

          CommonImage(
            image: 'assets/3.jpg',
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          HeadLine(),
        ],
      ),
    );
  }
}

class Head extends StatelessWidget {
  final double height;

  const Head({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: height, bottom: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/1.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: CircleAvatar(
                child: Image.asset('assets/default.png'),
              ),
            ),
            title: Text('18811475898'),
            subtitle: Text('总帖子1 今日发贴0'),
            onTap: () {},
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(40),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '帖子',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(40),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '动态',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(40),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '评论',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(40),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '粉丝',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


class HeadLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.visibility, color: Colors.pinkAccent,),
            title: Text('浏览历史'),
            trailing: Icon(Icons.chevron_right),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.beenhere, color: Colors.pinkAccent,),
            title: Text('社区认证'),
            trailing: Icon(Icons.chevron_right),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books, color: Colors.pinkAccent,),
            title: Text('审核帖子'),
            trailing: Icon(Icons.chevron_right),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
      
    );
  }
}
