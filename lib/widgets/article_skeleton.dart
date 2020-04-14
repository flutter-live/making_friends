import 'package:flutter/material.dart';
import 'package:makingfriends/widgets/skeleton.dart';

/// @description： 自定义骨架屏样式
/// @author：liuzhidong
/// @date：2020/4/12 14:01
/// @version：1.0

class ArticleSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: <Widget>[
          ListTitleSkeleton(),
          SizedBox(height: 10,),
          Container(
            width: 100,
            height: 5,
          ),
          Container(
            width: double.infinity,
            height: 120,
            decoration: SkeletonDecoration(isCircle: false, isDark: false),
          ),
          SizedBox(height: 15,),
          OperationSkeleton(),
          SizedBox(height: 20,),
          Divider(height: 1, color: Colors.grey,)
        ],
      ),
    );
  }
}

class ListTitleSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            //头像
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                height: 30,
                width: 30,
                decoration: SkeletonDecoration(isCircle: true, isDark: false),
              ),
            ),
            //基本信息
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 10,
                      decoration: SkeletonDecoration(isCircle: false, isDark: false),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: 20,
                      height: 10,
                      decoration: SkeletonDecoration(isCircle: false, isDark: false),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Container(
                  width: 120,
                  height: 5,
                  decoration: SkeletonDecoration(isCircle: false, isDark: false),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 40,
          height: 20,
          decoration: SkeletonDecoration(isCircle: false, isDark: false),
        ),
      ],
    );
  }
}

///操作栏
class OperationSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 50,
            height: 20,
            decoration: SkeletonDecoration(isCircle: false, isDark: false),
          ),
          Container(
            width: 50,
            height: 20,
            decoration: SkeletonDecoration(isCircle: false, isDark: false),
          ),
          Container(
            width: 50,
            height: 20,
            decoration: SkeletonDecoration(isCircle: false, isDark: false),
          ),
          Container(
            width: 50,
            height: 20,
            decoration: SkeletonDecoration(isCircle: false, isDark: false),
          ),
        ],
      ),
    );
  }
}

