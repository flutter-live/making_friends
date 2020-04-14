import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/viewModel/tocpic_v_m.dart';
import 'package:makingfriends/widgets/tocpic_list_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description: 话题分类
/// @author: liuzhidong
/// @date: 2020/3/31 14:47
/// @version: 1.0 

class TocpicClassificationItemPage extends StatefulWidget {
  @override
  _TocpicClassificationItemPageState createState() => _TocpicClassificationItemPageState();
}

class _TocpicClassificationItemPageState extends State<TocpicClassificationItemPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TocpicVM>(
      model: TocpicVM(),
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Container(
          child: SmartRefresher(
            controller: model.refreshController,
            header: WaterDropMaterialHeader(),
            footer: ClassicFooter(),
            //onRefresh: model.refresh,
            //  onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView(
              children: <Widget>[
                TocpicListItem(
                  title: '#话题名称###',
                  subtitle: '话题描述',
                  devDayNumber: 1,
                  devNumber: 0,
                  onTap: (){
                    Jump.push('view/trends/tocpic_details_page');
                  },
                ),
                SizedBox(height: 10),

                TocpicListItem(
                  title: '#话题名称###',
                  subtitle: '话题描述',
                  devDayNumber: 1,
                  devNumber: 0,
                ),
                SizedBox(height: 10),

                TocpicListItem(
                  title: '#话题名称###',
                  subtitle: '话题描述',
                  devDayNumber: 1,
                  devNumber: 0,
                ),
                SizedBox(height: 10),

                TocpicListItem(
                  title: '#话题名称###',
                  subtitle: '话题描述',
                  devDayNumber: 1,
                  devNumber: 0,
                ),
                SizedBox(height: 10),

                TocpicListItem(
                  title: '#话题名称###',
                  subtitle: '话题描述',
                  devDayNumber: 1,
                  devNumber: 0,
                ),
                SizedBox(height: 10),

                TocpicListItem(
                  title: '#话题名称###',
                  subtitle: '话题描述',
                  devDayNumber: 1,
                  devNumber: 0,
                ),
                SizedBox(height: 10),

                TocpicListItem(
                  title: '#话题名称###',
                  subtitle: '话题描述',
                  devDayNumber: 1,
                  devNumber: 0,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }


}
