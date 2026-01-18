import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:schat2/DataClasses/chatData.dart';
import 'package:schat2/eventStore.dart';

import '../generated/chats.pb.dart';

class MessageProvider with ChangeNotifier {

  void _safeNotifyListeners() {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
      notifyListeners();
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
  
  void newMessageEvent(UpdateDTO item) {
    bool newChat = true;
    bool addNotification = true;
      UpdateDTO updateChat = item;
      if (updateChat.chat.authorId == '-1') {
        removeChatUpdate(updateChat.chat.id);
        return;
      }
      if(updateChat.chat.messages.isNotEmpty && updateChat.chat.messages.first.authorId == -1)
      {
        removeMessageUpdate(updateChat.chat.id, updateChat.chat.messages.first.id);
        return;
      }
      for (int i = 0; i < allChats.length; i++) {
        if (allChats[i].id == updateChat.chat.id) {
          newChat = false;
          if (updateChat.chat.messages.isNotEmpty) {
            for (MessageDto m in updateChat.chat.messages) {
              bool newMessage = true;
              for (int y = 0; y < allChats[i].messages.length; y++) {
                if (allChats[i].messages[y].id == m.id) {
                  newMessage = false;
                  allChats[i].messages[y] = Message(m);
                  allChats[i].messages[y].body =
                      '${allChats[i].messages[y].body} ';
                      if( updateChat.chat.messages.last.reaction.isNotEmpty&&updateChat.chat.messages.last.reaction.last.authorId==config.server.userGlobal.id)
                      {addNotification = false;}
                }
              }
              if (Message(m).authorId == config.server.userGlobal.id) {
                addNotification = false;
              }
              if (newMessage) {
                allChats[i].addMessage(m, true);
              }
            }
          } else {
            List<Message> m = allChats[i].messages;
            allChats[i] = Chat(
              ChatDto(
                name: updateChat.chat.name,
                chatImage: updateChat.chat.chatImage,
                id: updateChat.chat.id,
                authorId: updateChat.chat.authorId.toString(),
                members: updateChat.chat.members,
              ),
            );
            allChats[i].messages = m;
          }
        }
      }
      if (newChat) {
        addNewChat(updateChat.chat);
      }
    
    if (addNotification && config.notification) {
      player.playNotification();
      notification.newEvent(
        'Schat',
        'New message',
      );
    }
    allChats.sort((b, a) => a.dateLastMessage.compareTo(b.dateLastMessage));
    _safeNotifyListeners();
  }
  
  void removeMessageUpdate(int chatId, int messageId) {
    for (Chat chat in allChats) {
      if (chat.id == chatId) {
        chat.messages.removeWhere((message) => message.id == messageId);
        break; 
      }
    }
    _safeNotifyListeners();
  }

 void removeChatUpdate(int id) {
    allChats.removeWhere((chat) => chat.id == id);
    if(selectChatId ==id&&allChats.isNotEmpty)
        {
          selectChat = 0;
          selectChatId = allChats.first.id;
        }
    _safeNotifyListeners();
  }

 void addNewChat(ChatDto chat) {
    allChats.add(Chat(chat));
    _safeNotifyListeners();
  }

 void deliveredMessage(int id) {
    for (var element in allChats) {
      if (element.id == id && element.messages.isNotEmpty) {
        if (element.messages.first.authorId != config.server.userGlobal.id) {
          element.messages.first.delivered = true;
        }
      }
    }
    _safeNotifyListeners();
  }
 
}