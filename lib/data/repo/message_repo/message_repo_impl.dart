import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zee_palm/export.dart';

class MessageRepoImpl implements MessageRepo {
  final SharedPreferences _preferences;
  final FirebaseFirestore fireStore;

  MessageRepoImpl(
    this._preferences,
    this.fireStore,
  );

  @override
  Future<Either<AppError, UserChatList>> getMessagesData() async {
    try {
      String userId = _preferences.getString(constant.userId) ?? '';
      CollectionReference ref = fireStore.collection('chats');
      final res = await ref.doc(userId).collection('user_messages').get();
      final allData = res.docs.map((doc) => doc.data()).toList();

      if (allData.isNotEmpty) {
        final data = UserChatList.fromJson(allData);
        return Right(data);
      } else {
        return Left(AppError(title: 'Data not found'));
      }
    } catch (e) {
      print(e);
      return Left(AppError(title: 'Something went wrong, try again!'));
    }
  }

  @override
  Future<void> setMessagesData(ChatUsers data) async {
    try {
      String userId =
          _preferences.getString(constant.userId) ?? 'user_not_registered';
      String userName =
          _preferences.getString(constant.userName) ?? 'user_not_registered';
      String userImage =
          _preferences.getString(constant.userImage) ?? 'user_not_registered';
      await fireStore
          .collection('chats')
          .doc(userId)
          .collection('user_messages')
          .doc(data.receiverId)
          .update(
            data.senderJson(),
          );
      await fireStore
          .collection('chats')
          .doc(data.receiverId)
          .collection('user_messages')
          .doc(userId)
          .update(
            data.receiverJson(userName, userImage),
          );
    } catch (e) {
      print(e);
    }
  }
}
