import 'package:city_pickers/modal/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:makingfriends/category.dart';
import 'package:makingfriends/model/making_friends_code.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/utils/fluro_convert_utils.dart';
import 'package:makingfriends/viewModel/setting/editing_materials_v_m.dart';
import 'package:makingfriends/viewModel/user_v_m.dart';
import 'package:makingfriends/widgets/cupertion_bottom_sheet.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:makingfriends/widgets/custom_picker.dart';
import 'package:makingfriends/widgets/image_setting.dart';
import 'package:makingfriends/widgets/loading.dart';
import 'package:makingfriends/widgets/photo_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import '../../config/string.dart';

/// @description：编辑资料
/// @author：liuzhidong
/// @date：2020/4/6 14:55
/// @version：1.0

class EditingMaterials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleConfig.EDITING_MATERIALS_TITLE),
      ),
      body: ProviderWidget<EditingMaterialsVM>(
          model: EditingMaterialsVM(Provider.of<UserVM>(context)),
          builder: (_, model, child) {
            return Container(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 5),
                children: <Widget>[
                  HeadLine(
                    title: Text('头像'),
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    trailingWidget: GestureDetector(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: HttpImage(
                          url: model.user?.userpic == null ||
                                  model.user?.userpic.isEmpty
                              ? 'nothing.png'
                              : model.user?.userpic,
                          errUrl: 'assets/nothing.png',
                          borderRadius: 100,
                          placeholderWidth: 10,
                          placeholderHeight: 10,
                        ),
                      ),
                    ),
                    onTop: () => uploadType(context),
                  ),
                  Divider(height: 0.5, color: Colors.black38),
                  HeadLine(
                    title: Text('昵称'),
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    trailing: model.user.username,
                    onTop: () async {
                      String title = FluroConvertUtils.fluroCnParamsEncode(
                          model.user.username);
                      String hintText =
                          FluroConvertUtils.fluroCnParamsEncode('请填写昵称');
                      String res = await Jump.push(
                          'setting/editing_from_page?title=$title&&hintText=$hintText');
                      if (res == null) return;
                      model.user = model.user..username = res;
                    },
                  ),
                  Divider(height: 0.5, color: Colors.black38),
                  HeadLine(
                    title: Text('性别'),
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    trailing: model.user.userinfo.sex == 0
                        ? '保密'
                        : (model.user.userinfo.sex == 1 ? '男' : '女'),
                    onTop: () {
                      cupertinoBottomSheet(
                          data: CategoryMakingJson.sex,
                          onConfirm: (value) {
                            model.user = model.user..userinfo.sex = value.code;
                          });
                    },
                  ),
                  Divider(height: 0.5, color: Colors.black38),
                  HeadLine(
                    title: Text('生日'),
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    trailing: model.user.userinfo.birthday,
                    onTop: () {
                      CustomPicker.showPickerDateTime(
                          type: PickerDateTimeType.kYMD,
                          onConfirm: (value, select) {
                            model.user.userinfo.birthday =
                                value.substring(0, 10);
                            model.user = model.user..userinfo.birthday;
                          });
                    },
                  ),
                  Divider(height: 0.5, color: Colors.black38),
                  HeadLine(
                    title: Text('情感'),
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    trailing: model.user.userinfo.qg == 0
                        ? '保密'
                        : (model.user.userinfo.qg == 1 ? '未婚' : '已婚'),
                    onTop: () {
                      cupertinoBottomSheet(
                          data: CategoryMakingJson.emotion,
                          onConfirm: (value) {
                            model.user = model.user..userinfo.qg = value.code;
                          });
                    },
                  ),
                  Divider(height: 0.5, color: Colors.black38),
                  HeadLine(
                    title: Text('职业'),
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    trailing: model.user.userinfo.job,
                    onTop: () {
                      CustomPicker.showPicker(
                          data: CategoryMakingJson.job,
                          onConfirm: (value, select) {
                            model.user = model.user..userinfo.job = value.name;
                          });
                    },
                  ),
                  Divider(height: 0.5, color: Colors.black38),
                  HeadLine(
                    title: Text('家乡'),
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    trailing: model.user.userinfo.path ?? '无',
                    onTop: () {
                      CityPicker.showCityPicker(onConfirm: (Result result) {
                        if (result == null) return;
                        String path = result.provinceName +
                            result.cityName +
                            result.areaName;
                        model.user = model.user..userinfo.path = path;
                      });
                    },
                  ),
                  Divider(height: 0.5, color: Colors.black38),
                  RaisedButton(
                    child: Text(
                      '完成',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => update(model, context),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

///选择上传图片类型
void uploadType(BuildContext context) {
  UserVM model = Provider.of<UserVM>(context, listen: false);
  cupertinoBottomSheet(
    data: [
      MakingFriendsCode(code: 0, name: '拍照'),
      MakingFriendsCode(code: 1, name: '从相册获取'),
    ],
    onConfirm: (MakingFriendsCode item) async {
      if (item?.code == 0) {
        var path = await CustomPhotoManager.photoPath();
        if (path != null) {
          await model.editUserPic(path);
        }
      } else if (item?.code == 1) {
        List<String> paths = await CustomPhotoManager.pickAsset(maxSelected: 1);
        if (paths != null && paths.isNotEmpty && paths.length > 0) {
          await model.editUserPic(paths[0]);
        }
      }
    },
  );
}

///跟新
void update(EditingMaterialsVM editingMaterialsVM, BuildContext context) async {
  ProgressDialog.showProgress();
  UserVM model = Provider.of<UserVM>(context, listen: false);
  bool b = await model.update(editingMaterialsVM.user);
  ProgressDialog.dismiss();
  if (b) {
    showToast('修改成功');
  } else {
    showToast('修改失败');
  }
}
