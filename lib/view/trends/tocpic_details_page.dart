import 'package:flutter/material.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view/trends/tocpic_classification_item_page.dart';
import 'package:makingfriends/view_model/tocpic_details_v_m.dart';
import 'package:makingfriends/widgets/custom_image.dart';

/// @description: 话题详情
/// @author: liuzhidong
/// @date: 2020/3/31 16:21
/// @version: 1.0

class TocpicDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TabController tabController;

    return ProviderWidget<TocpicDetailsVM>(
      model: TocpicDetailsVM(),
      onModelReady: (model) {
        tabController = TabController(length: 0,);
      },
      builder: (context, model, child) {
        return Scaffold(
              body: ListView(
                children: <Widget>[
                  Container(
                    child: CommonImage(
                        image: 'assets/3.jpg',
                        height: 250,
                        margin: EdgeInsets.all(0),
                        borderRadius: 0),
                  ),
                  Container(
                    child: TabBar(
                      controller: tabController,
                      tabs: model.map
                          .map((v) => Tab(text: v['title']))
                          .toList(),
                    ),
                  )
                ],
              ),
            );
      },
    );
  }
}
