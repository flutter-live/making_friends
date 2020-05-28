import 'package:flutter/material.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/viewModel/setting/about_v_m.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:makingfriends/widgets/image_setting.dart';
import 'package:oktoast/oktoast.dart';
import '../../config/string.dart';

/// @description： 关于
/// @author：liuzhidong
/// @date：2020/4/6 14:58
/// @version：1.0

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleConfig.ABOUT_PAGE_TITLR),
      ),
      body: ProviderWidget<AboutVM>(
        model: AboutVM(),
        onModelReady: (model) async{
          await model.initPackageInfo();
        },
        builder: (_, model, child) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Container(
                    width: 250,
                    height: 250,
                    child: HttpImage(
                      url: 'nothing.png',
                      errUrl: 'assets/nothing.png',
                      borderRadius: 100,
                      placeholderWidth: 10,
                      placeholderHeight: 10,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text('version ${model.packageInfo.version}'),
                ),
                Divider(
                    height: 0.5,
                    color: Colors.black38
                ),
                HeadLine(
                  title: Text('新版本检测'),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  onTop: () {
                    showToast('已是最新版本');
                  },
                ),
                Divider(
                    height: 0.5,
                    color: Colors.black38
                ),
                HeadLine(
                  title: Text('社区用户协议'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  onTop: () {},
                ),
                Divider(
                    height: 0.5,
                    color: Colors.black38
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
