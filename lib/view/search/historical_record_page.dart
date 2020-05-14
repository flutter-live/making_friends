import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:makingfriends/flutter/search.dart';
import 'package:makingfriends/viewModel/search/search_history_v_m.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:provider/provider.dart';

/// @description： 历史记录
/// @author：liuzhidong
/// @date：2020/4/2 18:39
/// @version：1.0

class HistoricalRecordPage extends StatefulWidget {
  final SearchDelegate delegate;

  const HistoricalRecordPage({Key key, this.delegate}) : super(key: key);

  @override
  _HistoricalRecordPageState createState() => _HistoricalRecordPageState();
}

class _HistoricalRecordPageState extends State<HistoricalRecordPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<SearchHistoryVM>(context, listen: false).initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchHistoryVM>(
      builder: (context, model, child) {
        return Container(
          child: Column(
            children: <Widget>[
              HeadLine(
                title: Text('历史记录'),
                isIcon: false,
                trailingWidget: FlatButton(
                  onPressed: () => model.clearHistory(),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.clear, size: 18, color: Colors.grey,),
                      SizedBox(
                        width: 2,
                      ),
                      Text('清空', style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: model.list.map((item) =>
                      Material(
                        child: InkWell(
                          child: Container(
                            child: Text(item),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)),
                              border: Border.all(
                                  width: 1, color: Colors.grey[300]),
                            ),
                          ),
                          onTap: () {
                            widget.delegate.query = item;
                            widget.delegate.showResults(context);
                          },
                        ),
                      ),).toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

