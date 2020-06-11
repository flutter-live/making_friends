import 'dart:async';
import 'package:flutter/material.dart';
import 'package:makingfriends/model/chat_list_model.dart';
import 'package:makingfriends/model/chat_model.dart';
import 'package:makingfriends/provider/provider_widget.dart';
import 'package:makingfriends/view/information/triangle_custom_painter_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingfriends/viewModel/infromation/chat_v_m.dart';
import 'package:makingfriends/viewModel/infromation/web_socket_chat.dart';
import 'package:makingfriends/widgets/custom_list_title.dart';
import 'dart:math' as math;
import 'package:makingfriends/widgets/image_setting.dart';
import 'package:provider/provider.dart';

/// @description： 聊天
/// @author：liuzhidong
/// @date：2020/4/7 21:00
/// @version：1.0
class ChatPage extends StatelessWidget {
  final ChatListModel chatListModel;
  const ChatPage({Key key, this.chatListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).padding.bottom;
    return ProviderWidget<ChatVM>(
        model: ChatVM(Provider.of<WebSocketChat>(context), chatListModel),
        onModelReady: (model) {
          model.webSocketChat.chatListModel = chatListModel;
          model.webSocketChat.initChatDetailToUser();
        },
        onDispose: (model) {
          model.webSocketChat.chatListModel = null;
        },
        builder: (context, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(chatListModel.username),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.list), onPressed: () {})
              ],
            ),
            body: SafeArea(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(child: _ListMain()),
                    Container(
                      height: 80.h,
                      child: ChatInputVBOX(chatListModel: chatListModel),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _ListMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<WebSocketChat, ChatVM>(
        builder: (context, model, model2, child) {
      Timer(
          Duration(milliseconds: 0),
          () => model2.scrollController
              .jumpTo(model2.scrollController.position.maxScrollExtent));
      return ListView.builder(
        itemCount: model.chats.length,
        controller: model2.scrollController,
        padding: EdgeInsets.only(top: 40.w),
        itemBuilder: (context, index) {
          return model.chats[index].fromId == model.user.userinfo.userId
              ? _RightChat(model: model.chats[index])
              : _LeftChat(model: model.chats[index]);
        },
      );
    });
  }
}

///左侧聊天
class _LeftChat extends StatelessWidget {
  final ChatModel model;

  const _LeftChat({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HeadLine(
          leadingWidgetRight: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          isIcon: false,
          leadingWidget: Container(
            width: 40,
            height: 40,
            child: HttpImage(
              url: model.fromUserpic,
              errUrl: 'assets/nothing.png',
              borderRadius: 100,
              placeholderWidth: 10,
              placeholderHeight: 10,
            ),
          ),
          title: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10, bottom: 10),
                child: CustomPaint(
                  painter: TriangleCustomPainter(color: Colors.grey[300]),
                ),
              ),
              Container(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(10.w))),
                  child: Text(model.data),
                ),
              )
            ],
          )),
    );
  }
}

///右侧聊天
class _RightChat extends StatelessWidget {
  final ChatModel model;

  const _RightChat({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HeadLine(
        crossAxisAlignment: CrossAxisAlignment.start,
        isIcon: false,
        title: Container(),
        trailingWidget: Container(
          child: Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.w, horizontal: 10.w),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.w))),
                      child: Text(
                        model.data,
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.w,
                            fontSize: 32.sp),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 10.w),
                child: Transform.rotate(
                  angle: math.pi,
                  child: Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    child: CustomPaint(
                      painter: TriangleCustomPainter(
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                child: HttpImage(
                  url: model.fromUserpic,
                  errUrl: 'assets/nothing.png',
                  borderRadius: 100,
                  placeholderWidth: 10,
                  placeholderHeight: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///输入框
class ChatInputVBOX extends StatelessWidget {
  final ChatListModel chatListModel;
  const ChatInputVBOX({Key key, this.chatListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    String data = '';
    return Consumer<WebSocketChat>(builder: (context, model, child) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  right: 20.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.grey[300],
                ),
                height: 50.h,
                child: TextField(
                  controller: controller,
                  scrollPadding: EdgeInsets.all(0),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(bottom: 30.w, left: 30.w, top: 5.w),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    data = value;
                  },
                  onChanged: (value) {
                    data = value;
                  },
                ),
              ),
            ),
            Container(
              child: MaterialButton(
                color: Theme.of(context).primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                minWidth: 110.w,
                height: 50.h,
                onPressed: () async {
                  await model.sendChatMessage(data);
                  controller.text = '';
                  data = '';
                },
                child: Text(
                  '发送',
                  style: TextStyle(color: Colors.white, fontSize: 26.sp),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
