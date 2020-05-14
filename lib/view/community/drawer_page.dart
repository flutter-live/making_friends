import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:makingfriends/view/my/my_head_page.dart';
import 'package:makingfriends/view/my/my_list_item_page.dart';
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
      child: Column(
        children: <Widget>[
          Head(height: _height),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: CommonImage(
              image: 'assets/2.jpg',
              isType: false,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MyListItemPage(),
        ],
      ),
    );
  }
}

class Head extends StatefulWidget {
  final double height;

  const Head({Key key, this.height}) : super(key: key);

  @override
  _HeadState createState() => _HeadState();
}

class _HeadState extends State<Head> {
  double h = 100;

  comtupeHeight(double l) {
    setState(() {
      h = l;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          CommonImage(
            image: 'assets/1.jpg',
            height: h,
            width: double.infinity,
            borderRadius: 0,
            isFilter: true,
            isType: false,
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: widget.height,
              ),
              Container(
                  child: Hqgd(
                comtupeHeight: comtupeHeight,
                height: widget.height,
              ))
            ],
          )
        ],
      ),
    );
  }
}

class Hqgd extends StatefulWidget {
  final Function comtupeHeight;
  final double height;

  const Hqgd({Key key, this.comtupeHeight, this.height}) : super(key: key);

  @override
  _HqgdState createState() => _HqgdState();
}

class _HqgdState extends State<Hqgd> with AfterLayoutMixin<Hqgd> {
  @override
  Widget build(BuildContext context) {
    return MyHead();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RenderBox box = context.findRenderObject();
    double height = box.getMaxIntrinsicHeight(MediaQuery.of(context).size.height);
    widget.comtupeHeight(height + widget.height + 10);
  }
}
