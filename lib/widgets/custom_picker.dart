import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/model/making_friends_code.dart';

/// @description： 自定义选择框
/// @author：liuzhidong
/// @date：2020/3/27 23:28
/// @version：1.0

class CustomPicker {
  ///级联多选框
  static showPicker({
    @required List<MakingFriendsCode> data, //显示的数据
    double itemExtent = 40, //每一项的高
    double height = 250, //底部弹出层的高
    List<int> selected, //默认选中的值
    @required void Function(MakingFriendsCode picker, List<int> selected) onConfirm, //选中回调函数
    void Function() onCancel, //取消回调函数
    void Function(Map<String, dynamic> picker, int index, List<int> selected)
    onSelect, //选中值回调
    Widget cancel, //自定义取消样式
    Widget confirm, //自定义确认样式
    String cancelText = '取消', //取消文本
    String confirmText = '确认', //确认文本
    TextStyle cancelTextStyle =
    const TextStyle(color: Colors.grey, fontSize: 20), //取消样式
    TextStyle confirmTextStyle, //确认样式
  }) {
    Picker(
      itemExtent: itemExtent,
      height: height,
      selecteds: selected,
      cancel: cancel,
      confirm: confirm,
      cancelText: cancelText,
      confirmText: confirmText,
      cancelTextStyle: cancelTextStyle,
      confirmTextStyle: confirmTextStyle,
      adapter: PickerDataAdapter(data: arrangement(value: data)),
      onConfirm: (Picker picker, List<int> selected) =>
          onConfirm(picker.adapter.getSelectedValues()[0], selected),
      onCancel: onCancel,
      onSelect: (Picker picker, int index, List<int> selected) => onSelect ==
          null
          ? null
          : onSelect(picker.adapter.getSelectedValues()[0], index, selected),
    ).showModal(Application.context);
  }

  //梳理返回数据
  static List<PickerItem> arrangement(
      {@required List<MakingFriendsCode> value}) {
    List<PickerItem> listItem = List();
    value.forEach((MakingFriendsCode map) {
      List<MakingFriendsCode> children =
          map.children ?? List<MakingFriendsCode>();
      if (children?.length > 0) {
        listItem.add(
          PickerItem(
            text: Container(
              alignment: Alignment.center,
              child: Text(map.name),
            ),
            value: map,
            children: arrangement(value: children),
          ),
        );
      } else {
        listItem.add(
          PickerItem(
            text: Container(
              alignment: Alignment.center,
              child: Text(map.name),
            ),
            value: map,
          ),
        );
      }
    });
    return listItem;
  }

  ///级联时间选择框
  static showPickerDateTime({
    int type = PickerDateTimeType.kYMD_AP_HM, //时间类型
    bool isMinValue = true, //是否开启最小时间
    double itemExtent = 40, //每一项的高
    double height = 250, //底部弹出层的高
    List<int> selected, //默认选中的值
    @required void Function(String picker, List<int> selected) onConfirm, //选中回调函数
    void Function() onCancel, //取消回调函数
    void Function(String picker, int index, List<int> selected) onSelect, //选中值回调
    Widget cancel, //自定义取消样式
    Widget confirm, //自定义确认样式
    String cancelText = '取消', //取消文本
    String confirmText = '确认', //确认文本
    TextStyle cancelTextStyle = const TextStyle(color: Colors.grey, fontSize: 20), //取消样式
    TextStyle confirmTextStyle, //确认样式
    bool isNumberMonth = true, //是否显示数字中文
    String yearSuffix = '年', //自定义年文本
    String monthSuffix = '月', //自定义月文本
    String daySuffix = '日', //自定义日文本
    List<String> strAMPM = const ["上午", "下午"], //自定义上午下午
  }) {
    final List<PickerDelimiter> delimiter = [
      PickerDelimiter(column: 5, child: Container(
        width: 16.0,
        alignment: Alignment.center,
        child: Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
        color: Colors.white,
      ))
    ];

    Picker(
      adapter: new DateTimePickerAdapter(
        type: type,
        isNumberMonth: isNumberMonth,
        yearSuffix: yearSuffix,
        monthSuffix: monthSuffix,
        daySuffix: daySuffix,
        strAMPM: strAMPM,
        minValue: isMinValue ? DateTime.now() : null,
      ),
      delimiter: type == 10 ? delimiter : null,
      selecteds: selected,
      height: height,
      itemExtent: itemExtent,
      onConfirm: (Picker picker, List<int> selected) => onConfirm(picker.adapter.text, selected),
      onSelect: (Picker picker, int index, List<int> selected) => onSelect(picker.adapter.text, index, selected),
      cancel: cancel,
      confirm: confirm,
      cancelText: cancelText,
      confirmText: confirmText,
      cancelTextStyle: cancelTextStyle,
      confirmTextStyle: confirmTextStyle,
    ).showModal(Application.context);
  }
}

/// @description 地区底部选择框
/// @author: liuzhidong
/// @data: 2020-02-24 18:34
/// @version: 1.0
class CityPicker {
  static showCityPicker({
    double height = 250,
    ThemeData theme,
    String locationCode = '110000',
    ShowType showType = ShowType.pca,
    bool isSort = false,
    double barrierOpacity = 0.5,
    bool barrierDismissible = true,
    Map<String, dynamic> citiesData,
    Map<String, dynamic> provincesData,
    double itemExtent,
    Widget cancelWidget = const Text('取消'),
    Widget confirmWidget = const Text('确认'),
    Widget Function(dynamic item, List<dynamic> list, int index) itemBuilder,
    Function(Result result) onConfirm,
  }) async {
    Result result = await CityPickers.showCityPicker(
      context: Application.context,
      height: height,
      theme: theme,
      locationCode: locationCode,
      showType: showType,
      isSort: isSort,
      barrierOpacity: barrierOpacity,
      barrierDismissible: barrierDismissible,
      citiesData: citiesData,
      provincesData: provincesData,
      itemExtent: itemExtent,
      cancelWidget: cancelWidget,
      confirmWidget: confirmWidget,
      itemBuilder: itemBuilder,
    );
    if (result != null) {
      onConfirm(result);
    } else {
      onConfirm(null);
    }
  }
}