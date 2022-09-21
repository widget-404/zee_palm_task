import 'package:zee_palm/export.dart';

mixin MessageRepo {
  Future<Either<AppError, UserChatList>> getMessagesData();

  Future<void> setMessagesData(ChatUsers data);
}
