import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @description： 发布
/// @author：liuzhidong
/// @date：2020/4/11 16:42
/// @version：1.0

class ReleasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text('发布'),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                minWidth: 70,
                child: Text(
                  '发布',
                  style: TextStyle(color: Colors.white, letterSpacing: 2),
                ),
              ),
            )
          ],
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: '发布新鲜事...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 250,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                            size: 42,
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Chip(
                          avatar: Icon(Icons.local_offer, size: 16,),
                          label: Text('添加分类', style: TextStyle(fontSize: 12),),
                          labelPadding: EdgeInsets.only(right: 5),
                        ),
                        SizedBox(width: 10,),
                        Chip(
                          avatar: Icon(Icons.category, size: 16,),
                          label: Text('添加话题', style: TextStyle(fontSize: 12),),
                          labelPadding: EdgeInsets.only(right: 5),
                        ),
                      ],
                    ),
                    Container(
                      child: Chip(
                        avatar: Icon(Icons.open_with, size: 16,),
                        label: Text('公开', style: TextStyle(fontSize: 12),),
                        labelPadding: EdgeInsets.only(right: 5),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
