import 'package:flutter/material.dart';
import 'package:makingfriends/model/chat_list_model.dart';
import 'package:makingfriends/model/chat_model.dart';
import 'package:makingfriends/provider/view_state_refresh.dart';
import 'package:makingfriends/viewModel/infromation/web_socket_chat.dart';

/// @description：聊天列表
/// @author：liuzhidong
/// @date：2020/5/24 09:56
/// @version：1.0

class ChatVM extends ViewStateRefresh<ChatModel>{
  final WebSocketChat webSocketChat;
  final ChatListModel chatListModel; 

  ChatVM(this.webSocketChat, this.chatListModel);

  ScrollController scrollController = new ScrollController();

  @override
  Future<List<ChatModel>> loadData({int pageFirst}) async{
    return await webSocketChat.getChatDetailToUser();
  }
  
  
  
  
  
  
}