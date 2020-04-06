import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/utils/fluro_convert_utils.dart';
import 'package:makingfriends/widgets/cirle_avatar_image.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
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
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
          children: <Widget>[
            HeadLine(
              title: '头像',
              titleSize: 30,
              trailingWidget: CircleAvatarImage(
                width: 60,
                height: 60,
              ),
              onTop: () {
              },
            ),
            HeadLine(
              title: '昵称',
              trailing: '六枝顶',
              titleSize: 30,
              onTop: () {
                String title = FluroConvertUtils.fluroCnParamsEncode('昵称');
                String hintText = FluroConvertUtils.fluroCnParamsEncode('请填写昵称');
                Jump.push('setting/editing_from_page?title=$title&&hintText=$hintText');
              },
            ),
            HeadLine(
              title: '性别',
              trailing: '男',
              titleSize: 30,
              onTop: () {
              },
            ),
            HeadLine(
              title: '生日',
              trailing: '1994-09-18',
              titleSize: 30,
              onTop: () {
              },
            ),
            HeadLine(
              title: '情感',
              trailing: '保密',
              titleSize: 30,
              onTop: () {
                String title = FluroConvertUtils.fluroCnParamsEncode('情感');
                String hintText = FluroConvertUtils.fluroCnParamsEncode('请填写情感');
                Jump.push('setting/editing_from_page?title=$title&&hintText=$hintText');
              },
            ),
            HeadLine(
              title: '职业',
              trailing: '保密',
              titleSize: 30,
              onTop: () {
                String title = FluroConvertUtils.fluroCnParamsEncode('职业');
                String hintText = FluroConvertUtils.fluroCnParamsEncode('请填写职业');
                Jump.push('setting/editing_from_page?title=$title&&hintText=$hintText');
              },
            ),
            HeadLine(
              title: '家乡',
              trailing: '保密',
              titleSize: 30,
              onTop: () {
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  '完成',
                  style: TextStyle(
                    fontSize: 32.sp,
                    letterSpacing: 5.w,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

