import 'package:makingfriends/provider/view_state.dart';
import 'package:makingfriends/provider/view_state_provider.dart';

/// @description： 保存数据 对于对象使用
/// @author：liuzhidong
/// @date：2020/3/27 21:48
/// @version：1.0

abstract class ViewStateBasic<T> extends ViewStateProvider {
  ///初始化加载
  initData({Map map}) async {
    setBusy();
    findData(map: map);
  }

  ///查询数据
  Future<T> findData({Map map}) async {
    try {
      T data = await find(data: map);
      if (data == null) {
        setEmpty();
      } else {
        onCompleted(data, ViewFunction.find);
        setDef();
      }
      return data;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }

  ///上传数据
  Future<T> saveData({Map map}) async {
    try {
      T data = await save(data: map);
      if (data == null) {
        setEmpty();
      } else {
        onCompleted(data, ViewFunction.save);
        setDef();
      }
      return data;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }

  ///修改数据
  Future<T> updateData({Map map}) async {
    try {
      T data = await update(data: map);
      if (data == null) {
        setEmpty();
      } else {
        onCompleted(data, ViewFunction.update);
        setDef();
      }
      return data;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }

  Future<T> find({Map data});

  Future<T> save({Map data});

  Future<T> update({Map data});

  onCompleted(T data, ViewFunction type) {}
}
