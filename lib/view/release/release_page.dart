import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/model/making_friends_code.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/view/release/photo_item.dart';
import 'package:makingfriends/viewModel/create_v_m.dart';
import 'package:makingfriends/viewModel/tocpic_class_v_m.dart';
import 'package:makingfriends/viewModel/upload_v_m.dart';
import 'package:makingfriends/widgets/cupertion_bottom_sheet.dart';
import 'package:makingfriends/widgets/custom_picker.dart';
import 'package:makingfriends/widgets/dialog_helper.dart';
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
      child: ProviderWidget3<UploadVN, TocpicClassVM, CreateVM>(
        model1: UploadVN(),
        model2: TocpicClassVM(),
        model3: CreateVM(),
        onModelReady: (model, model2, model3) {
          model3.titleContoller.text = model3.title;
          model2.initData();
        },
        builder: (context, model, model2, model3, child) {
          return WillPopScope(
            onWillPop: () async{
              if (await DialogHelper.showLoginDialog('是否保存草稿？')) {
                model3.saveDraft();
                model.saveDraft();
                Navigator.of(context).pop(true);
              } else {
                model.clearDraft();
                model3.clearDraft();
                Navigator.of(context).pop(false);
              }
              return false;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () async {
                      if (await DialogHelper.showLoginDialog('是否保存草稿？')) {
                        model3.saveDraft();
                        model.saveDraft();
                        Navigator.of(context).pop(true);
                      } else {
                        model.clearDraft();
                        model3.clearDraft();
                        Navigator.of(context).pop(false);
                      }
                    }),
                elevation: 0,
                title: Text('发布'),
                actions: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: MaterialButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Theme.of(Application.context).primaryColor,
                      onPressed: () => setCreate(context),
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
                        controller: model3.titleContoller,
                        textInputAction: TextInputAction.done,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: '发布新鲜事...',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => model3.title = value,
                        onSubmitted: (value) => model3.title = value,
                      ),
                    ),
                    _UploadPhoto(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ReleaseButton(
                                icon: Icons.local_offer,
                                title: model3.makingFriendsCode?.name ?? '添加分类',
                                onPressed: () {
                                  List<MakingFriendsCode> list = model2.list
                                      .map((item) => MakingFriendsCode(
                                          code: item.id, name: item.classname))
                                      .toList();
                                  CustomPicker.showPicker(
                                      data: list,
                                      onConfirm: (picker, selected) {
                                        model3.makingFriendsCode = picker;
                                      });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ReleaseButton(
                                icon: Icons.category,
                                title: model3.hotTopic?.title ?? '添加话题',
                                onPressed: () async {
                                  var item = await Jump.push(
                                      'view/trends/tocpic_classification_page?type=0');
                                  model3.hotTopic = item;
                                },
                              ),
                            ],
                          ),
                          Container(
                            child: ReleaseButton(
                              width: 60,
                              icon: Icons.open_with,
                              title: model3.isopen == 0 ? '私有' : '公开',
                              onPressed: () {
                                model3.isopen == 0
                                    ? model3.isopen = 1
                                    : model3.isopen = 0;
                              },
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
        },
      ),
    );
  }
}

///发布话题
void setCreate(BuildContext context) {
  CreateVM createVM = Provider.of<CreateVM>(context, listen: false);
  if (verification(createVM)) {
    createVM.save();
  }
}

bool verification(CreateVM createVM) {
  if (createVM.title == null || createVM.title.isEmpty) {
    showToast('发布一些新鲜事吧');
    return false;
  }
  if (createVM.imageList == null || createVM.imageList.length == 0) {
    showToast('发布一些图片吧');
    return false;
  }
  if (createVM.hotTopic == null) {
    showToast('请添加话题');
    return false;
  }
  if (createVM.makingFriendsCode == null) {
    showToast('请添加分类');
    return false;
  }
  return true;
}

///按钮
class ReleaseButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final double width;
  final Function onPressed;

  const ReleaseButton(
      {Key key, this.icon, this.title, this.onPressed, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      padding: EdgeInsets.symmetric(horizontal: 10),
      hoverElevation: 0,
      highlightElevation: 0,
      height: 30,
      elevation: 0,
      minWidth: width,
      color: Colors.grey[300],
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 16,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12),
          )
        ],
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
            onTap: () => uploadType(model, context),
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

///选择上传图片类型
void uploadType(UploadVN model, BuildContext context) {
  CreateVM createVM = Provider.of<CreateVM>(context, listen: false);
  cupertinoBottomSheet(
    data: [
      MakingFriendsCode(code: 0, name: '拍照'),
      MakingFriendsCode(code: 1, name: '从相册获取'),
    ],
    onConfirm: (MakingFriendsCode item) async {
      if (item.code == 0) {
        var path = await CustomPhotoManager.photoPath();
        if (path != null) {
          model.paths = [path];
          await model.initData();
          createVM.imageList = model.imageList;
        }
      } else if (item.code == 1) {
        List<String> paths = await CustomPhotoManager.pickAsset();
        if (paths != null && paths.isNotEmpty && paths.length > 0) {
          model.paths = paths;
          await model.initData();
          createVM.imageList = model.imageList;
        }
      }
    },
  );
}
