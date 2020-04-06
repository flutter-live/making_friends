import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/model/hot_topic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makingfriends/widgets/cirle_avatar_image.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:share/share.dart';

/// @description： 话题列表
/// @author：liuzhidong
/// @date：2020/3/29 17:37
/// @version：1.0

class ListItem extends StatelessWidget {
  final HotTopic hotTopic;
  final Function onTap;

  const ListItem({Key key, this.hotTopic, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: Material(
          child: InkWell(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeadLine(
                    isIcon: false,
                    leadingWidget: CircleAvatarImage(
                      width: 80,
                    ),
                    title: '18811475898',
                    titleWidget: Container(
                      margin: EdgeInsets.only(left: 20.w),
                      padding: EdgeInsets.only(
                        left: 10.w,
                        right: 10.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.w)),
                        color: Colors.pinkAccent,
                      ),
                      child: Row(
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.mars,
                            size: 25.sp,
                            color: Colors.white,
                          ),
                          Text(
                            '未知',
                            style:
                                TextStyle(fontSize: 22.sp, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    subtitle: '2019-06-30 下午 9：16',
                    trailingWidget: Material(
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      color: Theme.of(context).primaryColor,
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.w),
                          child: Text(
                            '关注',
                            style: TextStyle(
                                letterSpacing: 10.w, color: Colors.white),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                    child: Text('第一个项目'),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.w),
                      child: Image.asset(
                        'assets/3.jpg',
                        height: 300.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                    child: Operation(),
                  ),
                ],
              ),
            ),
            onTap: onTap,
          ),
        ));
  }
}

class Operation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: FlatButton(
            onPressed: () {
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.thumb_up),
                SizedBox(
                  width: 10.w,
                ),
                Text('顶'),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: FlatButton(
            onPressed: () {
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.thumb_down),
                SizedBox(
                  width: 10.w,
                ),
                Text('踩'),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: FlatButton(
            onPressed: () {
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.message),
                SizedBox(
                  width: 10.w,
                ),
                Text('1'),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: FlatButton(
            onPressed: () {
              Share.share('check out my website https://example.com');
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.launch),
                SizedBox(
                  width: 10.w,
                ),
                Text('分享'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
