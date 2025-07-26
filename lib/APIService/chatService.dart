import 'dart:async';
import 'dart:io';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:rxdart/rxdart.dart';

import 'package:grpc/grpc.dart';

import '../DataClasses/chatData.dart';
import '../DataClasses/file.dart';
import '../env.dart';
import '../eventStore.dart';
import '../generated/chats.pbgrpc.dart';

class ChatService {
  dynamic channel = ClientChannel(Env.defaultServer,
      port: Env.defaultPort,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));
  BehaviorSubject<UpdateDTO> eventController = BehaviorSubject();
  ChatService(String serverAddress, int portServer) {
    if (config.isWeb) {
      channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
          host: serverAddress, port: portServer, transportSecure: false);
    } else {
      channel = ClientChannel(serverAddress,
          port: portServer,
          options:
              const ChannelOptions(credentials: ChannelCredentials.insecure()));
    }
    stubChat = ChatsRpcClient(channel);
  }

  ChatsRpcClient stubChat = ChatsRpcClient(ClientChannel(Env.defaultServer,
      port: Env.defaultPort,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure())));

  updateApi(String serverAddress, int portServer) {
    if (config.isWeb) {
      channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
          host: serverAddress, port: portServer, transportSecure: false);
    } else {
      channel = ClientChannel(serverAddress,
          port: portServer,
          options:
              const ChannelOptions(credentials: ChannelCredentials.insecure()));
    }
    stubChat = ChatsRpcClient(channel);
  }

  late ResponseStream<UpdateDTO> updateEvent;

  createChat(String name, List members) async {
    String chatName = name;
    if (chatName == '') {
      chatName = 'default';
    }
    try {
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};

      ChatDto creating = ChatDto();
      creating.name = chatName;
      for (var element in members) {
        MemberDto i = MemberDto();
        i.memberUsername = element['userName'];
        i.memberImage = element['imageAvatar'];
        creating.members.add(i);
      }

      var res = await stubChat.createChat(creating,
          options: CallOptions(metadata: metadata));
      return {'status': res.message};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  viewAllChat() async {
    try {
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};
      RequestDto req = RequestDto();
      ListChatsDto res = await stubChat.fetchAllChats(req,
          options: CallOptions(metadata: metadata));
      return {'chats': res.chats};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  update() async {
    Map<String, String> metadata = {'access_token': userGlobal.accessToken};
    final request = RequestDto(); // создаем экземпляр запроса
    updateEvent = stubChat.listenEvent(request,
        options: CallOptions(
            metadata: metadata)); // отправляем запрос и получаем стрим
    listenServerEvent = updateEvent.listen((update) {
      // обрабатываем полученный UpdateDTO
      eventController.add(update);
    }, onDone: () async {
      //попытка переподключения через каждые 5 секунд
      print('UPDATE');
      bool check = await refreshTokens();
      print(check);
      return Future.delayed(const Duration(seconds: 5), () => update());
    });
  }

  viewMessagesChat(int idChat, int offset) async {
    try {
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};
      ChatDto req = ChatDto();
      req.id = idChat;
      req.name = offset.toString();
      var res = await stubChat.fetchChat(req,
          options: CallOptions(metadata: metadata));
      return {'chat': res};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  sendMessages(int idChat, String message, List<FileData> files,
      [int? sticker]) async {
    try {
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};
      List<String> typeContent = [];
      MessageDto req = MessageDto();
      for (var element in files) {
        typeContent.add(element.name);
        req.data.add(element.data);
      }
      if (sticker.runtimeType.toString() == 'int') {
        req.stickerContent = sticker!;
      }

      req.body = message;
      req.chatId = idChat;
      req.content.addAll(typeContent);

      var res = await stubChat.sendMessage(req,
          options: CallOptions(metadata: metadata));
      return {'status': res};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  removeChat(int idChat) async {
    try {
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};

      ChatDto req = ChatDto();
      req.id = idChat;

      var res = await stubChat.deleteChat(req,
          options: CallOptions(metadata: metadata));
      return {'status': res};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  removeMessage(Message mes) async {
    try {
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};
      MessageDto req = MessageDto(id: mes.id);
      var res = await stubChat.deleteMessage(req,
          options: CallOptions(metadata: metadata));
      return {'status': res};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  editGroupChat(ChatDto chat) async {
    try {
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};
      var res = await stubChat.editGroupChat(chat,
          options: CallOptions(metadata: metadata));
      return {'status': res};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  updateApp() async {
    String platform = '';
    if (Platform.isAndroid) {
      platform = 'apk';
    }
    if (Platform.isWindows) {
      platform = 'exe';
    }
    if (Platform.isLinux) {
      platform = 'out';
    }
    try {
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};
      UpdateAppRes res = await stubChat.updateApp(
          UpdateAppReq(version: Env.version, platform: platform),
          options: CallOptions(metadata: metadata));
      return {'data': res.data, 'name': res.name};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  notificationNewMessage(String accessToken) async {
    try {
      Map<String, String> metadata = {'access_token': accessToken};
      ResponseDto res = await stubChat.notification(RequestDto(),
          options: CallOptions(metadata: metadata));
      if (res.message == 'true') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  searchMessage(String searchKey, Chat chat)async
  {
    Map<String, String> metadata = {'access_token': userGlobal.accessToken};
    ChatDto res = await stubChat.searchMessage(
        SearchRequestDto(searchRequest: searchKey, chat: ChatDto(id:chat.id, name: chat.name, authorId: chat.authorId.toString(), chatImage: '', messages: [], members: [], image: [])),
        options: CallOptions(metadata: metadata));
    return res.messages;
  }

  sendReaction(ReactionMessage reaction) async {
    try {
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};
      ReactionMessageDto req = ReactionMessageDto(id: 0, body: reaction.body, authorId: userGlobal.id, authorName: userGlobal.userName, messageId: reaction.messageId, stickerContent: reaction.sticker, dateReaction: DateTime.now().toString());
      var res = await stubChat.reactionMessage(req,
          options: CallOptions(metadata: metadata));
      return {'status': res};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  forwardMessage(Chat chat, List<Message> m) async {
    try {
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};
      List<MessageDto> mes = [];

      for(Message m in m)
      {
        mes.add(MessageDto(id: m.id, body: m.body, authorId: m.authorId, authorName: m.authorName, delivered: m.delivered, content: [], stickerContent: 0, dateMessage: DateTime.now().toString(), reaction: [], forwarded: true, originalDate: DateTime.now().toString(), originalAuthor: m.originalAuthor));
      }
      ChatDto req = ChatDto(id: chat.id, name: chat.name, authorId: chat.authorId.toString(), chatImage: chat.chatImage, members: [], messages: mes);
      var res = await stubChat.forwardMessage(req,
          options: CallOptions(metadata: metadata));
      return {'status': res};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  removeReaction(ReactionMessage r)async
  {
    Map<String, String> metadata = {'access_token': userGlobal.accessToken};

    ReactionMessageDto req = ReactionMessageDto(id: r.id, body: r.body, authorId: r.authorId, authorName: r.authorName, messageId: r.messageId, stickerContent: r.sticker, dateReaction: r.date);
    ResponseDto res = await stubChat.deleteReactionMessage(req,
        options: CallOptions(metadata: metadata));
    return res.message;
  }



}
