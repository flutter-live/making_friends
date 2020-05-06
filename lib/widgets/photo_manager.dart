import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makingfriends/config/application.dart';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';

/// @description： 图片获取
/// @author：liuzhidong
/// @date：2020/4/24 18:34
/// @version：1.0

class CustomPhotoManager with LoadingDelegate {
  @override
  Widget buildBigImageLoading(
      BuildContext context, AssetEntity entity, Color themeColor) {
    // TODO: implement buildBigImageLoading
    return null;
  }

  @override
  Widget buildPreviewLoading(
      BuildContext context, AssetEntity entity, Color themeColor) {
    // TODO: implement buildPreviewLoading
    return null;
  }

  // ignore: missing_return
  static Future<List<String>> pickAsset({
    PickType pickType = PickType.onlyImage,
    RequestType requestType = RequestType.image,
    int maxSelected = 9,
  }) async {
    var pathList = await PhotoManager.getAssetPathList(type: RequestType.image);

    List<AssetEntity> imgList = await PhotoPicker.pickAsset(
      // BuildContext required
      context: Application.context,

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
      maxSelected: maxSelected,
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
      // if you want to build custom loading widget,extends LoadingDelegate, [see example/lib/main.dart]
      badgeDelegate: const DurationBadgeDelegate(),
      // badgeDelegate to show badge widget
      pickType: pickType,
      photoPathList: pathList,
    );

    if (imgList == null || imgList.isEmpty) {
      return [];
    } else {
      List<String> r = [];
      for (var e in imgList) {
        var file = await e.file;
        r.add(file.absolute.path);
      }
      return r;
    }
  }

  ///拍照获取
  // ignore: missing_return
  static Future<String> photoPath({
    ImageSource source = ImageSource.camera,
  }) async {
    var image = await ImagePicker.pickImage(source: source);
    if(image != null){
      return image.absolute.path;
    }else{
      return null;
    }
  }
}
