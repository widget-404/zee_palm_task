import 'package:get/get.dart';

import 'chat_messages_model.dart';

class UserChatList {
  final List<ChatUsers> list;

  UserChatList(this.list);

  factory UserChatList.fromJson(dynamic json) {
    List<ChatUsers> data = [];
    if (json != null && json.isNotEmpty) {
      json.forEach((element) {
        data.add(ChatUsers.fromJson(element));
      });
    }

    return UserChatList(data);
  }
}

class ChatUsers {
  String receiverId;
  bool isOnline;
  String name;
  String imageUrl;
  RxList<ChatMessage> messageData;

  ChatUsers({
    required this.receiverId,
    required this.isOnline,
    required this.name,
    required this.imageUrl,
    required this.messageData,
  });

  factory ChatUsers.fromJson(dynamic json) {
    RxList<ChatMessage> data = List<ChatMessage>.empty().obs;
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(ChatMessage.fromJson(element));
      });
    }
    return ChatUsers(
      receiverId: json['receiverId'],
      isOnline: json['isOnline'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      messageData: data,
    );
  }

  Map<String, dynamic> senderJson() {
    List<dynamic> data = [];
    if (messageData.isNotEmpty) {
      messageData.forEach((element) {
        data.add(element.senderJson());
      });
    }
    final map = <String, dynamic>{};
    map['name'] = name;
    map['imageUrl'] = imageUrl;
    map['data'] = data;

    return map;
  }

  Map<String, dynamic> receiverJson(String senderName, String senderImage) {
    List<dynamic> data = [];
    if (messageData.isNotEmpty) {
      messageData.forEach((element) {
        data.add(element.receiverJson());
      });
    }
    final map = <String, dynamic>{};
    map['name'] = senderName;
    map['imageUrl'] = senderImage;
    map['data'] = data;

    return map;
  }
}
