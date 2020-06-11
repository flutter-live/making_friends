import 'dart:convert';
import 'package:makingfriends/config/application.dart';
import 'package:makingfriends/config/cache.dart';
import 'package:makingfriends/model/chat_list_model.dart';
import 'package:makingfriends/model/chat_model.dart';
import 'package:makingfriends/model/user.dart';
import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:makingfriends/service/makng_friends_api.dart';
import 'package:makingfriends/utils/date_utils.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/io.dart';

/// @description： 描述
/// @author：liuzhidong
/// @date：2020/6/7 11:16
/// @version：1.0

class WebSocketChat extends ViewStateProvider {
  User user = User();

  ///聊天列表
  List<ChatModel> _chats = List<ChatModel>();
  List<ChatModel> get chats => _chats;
  set chats(List<ChatModel> l) {
    _chats = l;
    notifyListeners();
  }

  List<ChatListModel> _listChat = List<ChatListModel>();
  List<ChatListModel> get listChat => _listChat;
  set listChat(List<ChatListModel> l) {
    _listChat = l;
    notifyListeners();
  }

  ChatListModel chatListModel = ChatListModel();

  ///获取总数
  int _total = 0;
  int get total => _total;
  set total(int i) {
    _total = i;
    notifyListeners();
  }

  WebSocketChat() {
    //初始信息
    init();
  }

  ///初始化信息
  Future init() async {
    //获取用户信息
    await this.getUser();
    //链接websocket
    await this.openSocket();
  }

  ///获取用户信息
  Future getUser() async {
    var userStr =
        Application.sharedPreferences.getString(CacheKey.keyLoginName);
    user = userStr != null && userStr.isNotEmpty
        ? User.fromJson(jsonDecode(userStr))
        : null;
  }

  ///链接websocket
  Future openSocket() async {
    final channel =
        await IOWebSocketChannel.connect("wss://ceshi2.dishait.cn/wss");
    channel.stream.listen((data) {
      Map<String, dynamic> msg = jsonDecode(data);
      print('链接成功:::$msg');
      if (msg['type'] == 'bind') {
        //绑定用户
        this.userBind(msg['data']);
      }
      if (msg['type'] != 'text') return;
      //处理会话列表
      this.handleChatMessage(ChatModel.fromJson(msg));
    });
  }

  ///用户绑定
  Future userBind(clientId) async {
    var res = await MakingFriendsApi.fetchUserBind(clientId);
    print('绑定用户:::$res');
    if (res['status'] && res['type'] == 'bind') {
      //获取未读信息
      await this.getUnreadMessages();
      //初始化列表
      await this.initChatList();
    }
  }

  ///初始化会话列表
  Future initChatList() async {
    listChat = await this.getChatList();
    await updateTabbarBadge();
  }

  ///处理接受到的消息
  Future handleChatMessage(ChatModel data) async {
    if (data != null) {
      print('处理接受到的消息:::${data.toJson()}');
      // 存储到chatdetail
      await this.updateChatDetailToUser(model: data, send: false);
      //更新会话列表
      await this.updateChatList(data: data, send: false);
    }
  }

  ///获取未读信息
  Future getUnreadMessages() async {
    List<ChatModel> list = await MakingFriendsApi.fetchGetUnreadMessages();
    list.forEach((item) {
      this.handleChatMessage(item);
    });
  }

  ///更新会话列表
  Future updateChatList({ChatModel data, bool send}) async {
    chatListModel = chatListModel ?? ChatListModel();
    //获取之前的会话
    listChat = await getChatList();
    int b = listChat.indexWhere((item) =>
        item.userId == int.parse(data.toId) || item.userId == data.fromId);
    if (b == -1) {
      // 接收到的消息转会话
      ChatListModel listModel = ChatListModel(
          userId: send ? chatListModel.userId : data.fromId,
          avatar: send ? chatListModel.avatar : data.fromUserpic,
          username: send ? chatListModel.username : data.fromUsername,
          updateTime: data.time,
          time: data.time,
          data: data.data);
      // 忽略本人发送
      if (!send) {
        listModel.noread = 1;
      }
      print('不存在当前会话,创建:::${listModel.toJson()}');
      // 追加头部
      listChat.insert(0, listModel);
    } else {
      ChatListModel ele = listChat.elementAt(b);
      listChat.map((e) {
        if (ele.userId == e.userId) {
          ele.time = data.time;
          ele.type = data.type;
          ele.data = data.data;
          ele.noread = !send && chatListModel.userId != ele.userId
              ? ++ele.noread
              : ele.noread;
          return ele;
        } else {
          return e;
        }
      }).toList();
    }
    // 存储到本地存储
    this.saveChatList(listChat);
    // 不处于聊天当中,更新未读数
    if (data.fromId != chatListModel.userId && !send) {
      this.updateTabbarBadge();
    }
  }

  ///获取所有会话列表
  Future<List<ChatListModel>> getChatList() async {
    if (user == null) return [];
    List<String> list =
        Application.sharedPreferences.getStringList('chatlist_${user.id}') ??
            [];
    return list.map((e) => ChatListModel.fromJson(jsonDecode(e))).toList();
  }

  ///储存会话列表
  Future saveChatList(List<ChatListModel> model) async {
    List<String> kList =
        model.map<String>((e) => json.encode(e.toJson())).toList();
    Application.sharedPreferences.setStringList('chatlist_${user.id}', kList);
  }

  ///更新未读数
  Future updateTabbarBadge() async {
    total = await totalNoread();
  }

  ///获取聊天总数
  Future<int> totalNoread() async {
    int all = 0;
    listChat.forEach((item) {
      all += item.noread;
    });
    return all;
  }

  ///存储到chatdetail
  Future updateChatDetailToUser({ChatModel model, bool send}) async {
    int toId = send ? chatListModel.userId : model.fromId;
    chats = await this.getChatDetailToUser(toId: toId)
      ..add(model);
    this.saveChatDetail(toId: toId, list: chats);
  }

  ///进入聊天页面初始化加载
  Future initChatDetailToUser({int toId = 0}) async {
    chats = await this.getChatDetailToUser(toId: toId);
  }

  /// 获取与某个用户聊天内容列表
  Future<List<ChatModel>> getChatDetailToUser({int toId = 0}) async {
    toId = toId == 0 ? chatListModel.userId : toId;
    String key = 'chatdetail_${user.id}_$toId';
    List<String> list = Application.sharedPreferences.getStringList(key) ?? [];
    return list.map((e) => ChatModel.fromJson(jsonDecode(e))).toList();
  }

  /// 存储与某个用户聊天内容列表
  Future saveChatDetail({int toId = 0, List<ChatModel> list}) async {
    toId = toId == 0 ? chatListModel.userId : toId;
    String key = 'chatdetail_${user.id}_$toId';
    List<String> kList =
        list.map<String>((e) => json.encode(e.toJson())).toList();
    Application.sharedPreferences.setStringList(key, kList);
  }

  ///清除会话列表
  Future clearChatList() async {
    Application.sharedPreferences.remove('chatlist_${user.id}');
    listChat.clear();
    notifyListeners();
    total = 0;
  }

  // 读取当前会话(去除未读数,更新tabbar)
  Future readChatMessage({ChatListModel chatListModel}) async {
    print('读取当前会话(去除未读数,更新tabbar)${chatListModel.toJson()}');
    // 没有未读信息
    if (chatListModel.noread == 0) return;
    // 拿到当前会话 设置未读数为0
    listChat = listChat.map((v) {
      if (v.userId == chatListModel.userId) {
        return v..noread = 0;
      } else {
        return v;
      }
    }).toList();
    // 存储
    this.saveChatList(listChat);
    // 更新未读数
    this.updateTabbarBadge();
  }

  ///发送消息
  Future sendChatMessage(String data) async {
    ChatModel chatModel = ChatModel(
        toId: chatListModel.userId.toString(),
        fromId: user.id,
        fromUsername: user.username,
        fromUserpic: user.userpic,
        type: 'text',
        data: data,
        time: int.parse(DateUtils.instance
            .getTimeStap(formartData: DateTime.now().toString())
            .toString()
            .substring(0, 10)));
    await this.updateChatDetailToUser(model: chatModel, send: true);
    await this.updateChatList(data: chatModel, send: true);
    await MakingFriendsApi.fetchSendChatMessages(chatModel.toJson());
  }
}
