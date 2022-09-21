import 'package:zee_palm/export.dart';

class MessageUseCase {
  final MessageRepo repo;

  MessageUseCase(this.repo);

  UserChatList _chatList = UserChatList([]);

  Future<bool> getMessagesData() async {
    try {
      final res = await repo.getMessagesData();
      return res.fold((error) {
        return false;
      }, (data) {
        _chatList = data;
        return true;
      });
    } catch (error) {
      return false;
    }
  }

  Future<bool> updateMessages(ChatUsers data) async {
    try {
      final res = await repo.setMessagesData(data);
      return true;
    } catch (error) {
      return false;
    }
  }

  UserChatList get chatList => _chatList;
}
