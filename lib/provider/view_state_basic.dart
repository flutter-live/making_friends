import 'package:makingfriends/provider/view_state.dart';
import 'package:makingfriends/provider/view_state_provider.dart';

/// @description： 保存数据 对于对象使用
/// @author：liuzhidong
/// @date：2020/3/27 21:48
/// @version：1.0

abstract class ViewStateBasic extends ViewStateProvider {
  ///初始化加载
  initData({Map map}) async{
    setBusy();
    findData(map: map);
  }

  ///查询数据
  Future<Map> findData({Map map}) async{
    try{
      Map data = await loadData(data: map);
      if(data.isEmpty || data == null){
        setEmpty();
      }else{
        await onCompleted(data, ViewFunction.find);
        setDef();
      }
      return data;
    }catch(e, s){
      setError();
      return null;
    }
  }

  ///上传数据
  Future<Map> saveData({Map map}) async{
    try{
      Map data = await loadData(data: map);
      if(data.isEmpty || data == null){
        setEmpty();
      }else{
        await onCompleted(data, ViewFunction.save);
        setDef();
      }
      return data;
    }catch(e, s){
      setError();
      return null;
    }
  }


  Future<Map> loadData({Map data});

  Future<void> onCompleted(Map data, ViewFunction type);

}