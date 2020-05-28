import 'package:makingfriends/provider/view_state_provider.dart';

/// @description： 列表数据
/// @author：liuzhidong
/// @date：2020/3/27 22:08
/// @version：1.0

abstract class ViewStateList<T> extends ViewStateProvider{
  ///数据
  List<T> list = [];

  initData() async{
    setBusy();
    await findData();
  }

  Future<List<T>> findData() async{
    try{
      List<T> data = await loadData();
      if(data.isEmpty || data.length == 0){
        setEmpty();
        list.clear();
      }else{
        onCompleted(data);
        list.clear();
        list.addAll(data);
        setDef();
      }
      return data;
    }catch(e, s){
      list.clear();
      setError(e, s);
      return null;
    }
  }

  Future<List<T>> loadData();

  onCompleted(List<T> data){}
}