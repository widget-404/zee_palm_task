class ChatMessage {
  String messageContent;
  bool typeIsSender;
  String time;

  ChatMessage(
      {required this.messageContent,
      required this.typeIsSender,
      required this.time});

  factory ChatMessage.fromJson(dynamic json) {
    return ChatMessage(
      messageContent: json['content'],
      typeIsSender: json['type'],
      time: json['time'],
    );
  }

  Map<String, dynamic> senderJson() {
    final map = <String, dynamic>{};
    map['content'] = messageContent;
    map['type'] = typeIsSender;
    map['time'] = time;

    return map;
  }

  Map<String, dynamic> receiverJson() {
    final map = <String, dynamic>{};
    map['content'] = messageContent;
    map['type'] = !typeIsSender;
    map['time'] = time;

    return map;
  }
}
