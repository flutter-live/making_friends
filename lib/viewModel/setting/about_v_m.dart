import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:package_info/package_info.dart';

/// @description： 关于
/// @author：liuzhidong
/// @date：2020/5/23 20:39
/// @version：1.0

class AboutVM extends ViewStateProvider {

  PackageInfo packageInfo = PackageInfo();

  //获取版本号
  Future<void> initPackageInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo = info;
    notifyListeners();
  }
}
