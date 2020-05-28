import 'package:makingfriends/provider/view_state_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @description： 历史记录
/// @author：liuzhidong
/// @date：2020/5/8 21:03
/// @version：1.0

class SearchHistoryVM extends ViewStateList<String> {
  String keyHistory;

  clearHistory() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(keyHistory);
    list.clear();
    setEmpty();
  }

  addHistory(String keyword) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var histories = sharedPreferences.getStringList(keyHistory) ?? [];
    histories
      ..remove(keyword)
      ..insert(0, keyword);
    await sharedPreferences.setStringList(keyHistory, histories);
    notifyListeners();
  }

  @override
  Future<List<String>> loadData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getStringList(keyHistory));
    return sharedPreferences.getStringList(keyHistory) ?? [];
  }
}
