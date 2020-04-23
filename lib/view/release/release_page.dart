import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';

/// @description： 发布
/// @author：liuzhidong
/// @date：2020/4/11 16:42
/// @version：1.0

class ReleasePage extends StatelessWidget with LoadingDelegate{
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
                      onTap: () async{
                        //File file = await FilePicker.getFile(type: FileType.image);
                        _testPhotoListParams(context);
                      },
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

  void _testPhotoListParams(BuildContext context) async {
    var assetPathList =
    await PhotoManager.getAssetPathList(type: RequestType.image);
    _pickAsset(PickType.all, context, pathList: assetPathList);
  }
  void _pickAsset(PickType type, BuildContext context, {List<AssetPathEntity> pathList}) async {
    /// context is required, other params is optional.
    /// context is required, other params is optional.
    /// context is required, other params is optional.
    List<AssetEntity> imgList = await PhotoPicker.pickAsset(
      // BuildContext required
      context: context,

      /// The following are optional parameters.
      themeColor: Colors.green,
      // the title color and bottom color

      textColor: Colors.white,
      // text color
      padding: 1.0,
      // item padding
      dividerColor: Colors.grey,
      // divider color
      disableColor: Colors.grey.shade300,
      // the check box disable color
      itemRadio: 0.88,
      // the content item radio
      maxSelected: 8,
      // max picker image count
      // provider: I18nProvider.english,
      provider: I18nProvider.chinese,
      // i18n provider ,default is chinese. , you can custom I18nProvider or use ENProvider()
      rowCount: 3,
      // item row count

      thumbSize: 150,
      // preview thumb size , default is 64
      sortDelegate: SortDelegate.common,
      // default is common ,or you make custom delegate to sort your gallery
      checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
        activeColor: Colors.white,
        unselectedColor: Colors.white,
        checkColor: Colors.green,
      ),
      // default is DefaultCheckBoxBuilderDelegate ,or you make custom delegate to create checkbox

      loadingDelegate: this,
      // if you want to build custom loading widget,extends LoadingDelegate, [see example/lib/main.dart]

      badgeDelegate: const DurationBadgeDelegate(),
      // badgeDelegate to show badge widget

      pickType: type,

      photoPathList: pathList,
    );

    if (imgList == null || imgList.isEmpty) {
      showToast("No pick item.");
      return;
    } else {
      List<String> r = [];
      for (var e in imgList) {
        var file = await e.file;
        r.add(file.absolute.path);
      }

      List<AssetEntity> preview = [];
      preview.addAll(imgList);
    }
  }

  @override
  Widget buildBigImageLoading(BuildContext context, AssetEntity entity, Color themeColor) {
    // TODO: implement buildBigImageLoading
    return null;
  }

  @override
  Widget buildPreviewLoading(BuildContext context, AssetEntity entity, Color themeColor) {
    // TODO: implement buildPreviewLoading
    return null;
  }
}



