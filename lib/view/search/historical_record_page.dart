import 'package:flutter/material.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 历史记录
/// @author：liuzhidong
/// @date：2020/4/2 18:39
/// @version：1.0

class HistoricalRecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          HeadLine(
            title: Text('历史记录'),
            isIcon: false,
            trailingWidget: FlatButton(
              onPressed: () {},
              child: Row(
                children: <Widget>[
                  Icon(Icons.clear, size: 26.sp, color: Colors.grey,),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text('清空', style: TextStyle(color: Colors.grey),),
                ],
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Wrap(
              spacing: 20.w,
              runSpacing: 20.w,
              children: <Widget>[
                Material(
                  child: InkWell(
                    child: Container(
                      child: Text('Flutter 社区交友'),
                      padding: EdgeInsets.only(bottom: 10.w, top: 10.w, left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        border: Border.all(width: 1, color: Colors.grey[300]),
                      ),
                    ),
                    onTap: (){},
                  ),
                ),

                Material(
                  child: InkWell(
                    child: Container(
                      child: Text('Flutter 社区交友'),
                      padding: EdgeInsets.only(bottom: 10.w, top: 10.w, left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        border: Border.all(width: 1, color: Colors.grey[300]),
                      ),
                    ),
                    onTap: (){},
                  ),
                ),

                Material(
                  child: InkWell(
                    child: Container(
                      child: Text('Flutter 社区交友'),
                      padding: EdgeInsets.only(bottom: 10.w, top: 10.w, left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        border: Border.all(width: 1, color: Colors.grey[300]),
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
