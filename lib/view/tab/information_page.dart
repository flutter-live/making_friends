import 'package:flutter/material.dart' hide showSearch;
import 'package:makingfriends/flutter/search.dart';
import 'package:makingfriends/model/chat_list_model.dart';
import 'package:makingfriends/routes/jump.dart';
import 'package:makingfriends/utils/date_utils.dart';
import 'package:makingfriends/utils/fluro_convert_utils.dart';
import 'package:makingfriends/view/search/search_page.dart';
import 'package:makingfriends/viewModel/infromation/web_socket_chat.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'package:makingfriends/widgets/dialog_helper.dart';
import 'package:makingfriends/widgets/image_setting.dart';
import 'package:provider/provider.dart';
import '../../config/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description： 消息
/// @author：liuzhidong
/// @date：2020/3/28 17:45
/// @version：1.0

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).padding.top;
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.person_add),
          onPressed: () {
            Jump.push('information/find_friends_page');
          },
        ),
        title: Text(TitleConfig.INFORMATION_TITLE),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () async{
              if(await DialogHelper.showLoginDialog('是否要清除会话列表？')){
                  WebSocketChat webSocketChat = Provider.of<WebSocketChat>(context, listen: false);
                  webSocketChat.clearChatList();
              }
            },
            // onPressed: () => showMenu(
            //   context: context,
            //   position: RelativeRect.fromLTRB(750.w, h, 0.0, 0.0),
            //   items: <PopupMenuItem<String>>[
            //     PopupMenuItem<String>(
            //       child: ListTile(
            //         leading: const Icon(Icons.search),
            //         title: const Text('添加好友'),
            //         onTap: () => showSearch(
            //             context: context,
            //             delegate: DefaultSearchDelegate(
            //                 hintText: '搜索好友', type: 'user')),
            //       ),
            //     ),
            //     PopupMenuItem<String>(
            //       child: ListTile(
            //         leading: const Icon(Icons.delete),
            //         title: const Text('清除列表'),
            //         onTap: (){
            //           WebSocketChat webSocketChat = Provider.of<WebSocketChat>(context, listen: false);
            //           webSocketChat.clearChatList();
            //           Navigator.of(context).pop();
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ],
      ),
      body: Consumer<WebSocketChat>(builder: (context, model, child) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: const BoxDecoration(
                border: const Border(
                    bottom: BorderSide(color: Colors.black38, width: 0.5)),
              ),
              child: HeadLine(
                isIcon: false,
                leadingWidget: Container(
                  width: 40,
                  height: 40,
                  child: HttpImage(
                    url: model.listChat[index].avatar,
                    errUrl: 'assets/nothing.png',
                    borderRadius: 100,
                    placeholderWidth: 10,
                    placeholderHeight: 10,
                  ),
                ),
                title: Text(model.listChat[index].username),
                subtitle: model.listChat[index].data,
                trailingWidget: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        DateUtils.instance.getFormartData(
                          timeSamp: model.listChat[index].time,
                          format: 'yyyy-MM-dd hh:mm',
                        ),
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 12),
                      ),
                      Visibility(
                        visible: model.listChat[index].noread != 0,
                        replacement: Container(height: 20,),
                        child: Container(
                        margin: EdgeInsets.only(top: 3),
                        padding: const EdgeInsets.all(1),
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 15,
                          minHeight: 15,
                        ),
                        child: Text(
                          model.listChat[index].noread.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),)
                      
                    ],
                  ),
                ),
                onTop: () {
                  String item = FluroConvertUtils.object2string<ChatListModel>(model.listChat[index]);
                  Jump.push('information/chat_page?item=$item');
                  model.readChatMessage(chatListModel: model.listChat[index]);
                },
              ),
            );
          },
          itemCount: model.listChat.length,
        );
      }),
    );
  }
}
