import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view/release/photo_item.dart';
import 'package:makingfriends/viewModel/upload_v_m.dart';
import 'package:makingfriends/widgets/photo_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

/// @description： 发布
/// @author：liuzhidong
/// @date：2020/4/11 16:42
/// @version：1.0

class ReleasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.white),
      child: ProviderWidget<UploadVN>(
        model: UploadVN(),
        builder: (context, model, child) {
          return Scaffold(
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
                  _UploadPhoto(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Chip(
                              avatar: Icon(
                                Icons.local_offer,
                                size: 16,
                              ),
                              label: Text(
                                '添加分类',
                                style: TextStyle(fontSize: 12),
                              ),
                              labelPadding: EdgeInsets.only(right: 5),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Chip(
                              avatar: Icon(
                                Icons.category,
                                size: 16,
                              ),
                              label: Text(
                                '添加话题',
                                style: TextStyle(fontSize: 12),
                              ),
                              labelPadding: EdgeInsets.only(right: 5),
                            ),
                          ],
                        ),
                        Container(
                          child: Chip(
                            avatar: Icon(
                              Icons.open_with,
                              size: 16,
                            ),
                            label: Text(
                              '公开',
                              style: TextStyle(fontSize: 12),
                            ),
                            labelPadding: EdgeInsets.only(right: 5),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

///相片
// ignore: must_be_immutable
class _UploadPhoto extends StatelessWidget {
  List<String> paths;
  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadVN>(
      builder: (context, model, child) {
        List<Widget> netImage = model.imageList
            .map(
              (item) => Container(
                child: PhotoItem(
                  path: item.url,
                  del: () {
                    model.del(item);
                  },
                ),
              ),
            )
            .toList();
        widgets?.addAll(netImage);

        if (model.imageList.length < 9) {
          Widget assetImage = GestureDetector(
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
            onTap: () async {
              model.paths = await CustomPhotoManager.pickAsset();
              model.initData();
            },
          );
          widgets?.add(assetImage);
        }

        return Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 250,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            children: widgets,
          ),
        );
      },
    );
  }
}
