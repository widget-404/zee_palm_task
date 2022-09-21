import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zee_palm/export.dart';

class ChatScreenController extends GetxController
    with StateMixin<ChatDetailScreen> {
  final MessageUseCase useCase;
  final SharedPreferences preferences;
  ChatScreenController(this.useCase, this.preferences);

  RxBool isLoading = false.obs;
  List<ChatUsers> chatUsers = [];
  TextEditingController msgController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> onInit() async {
    change(null, status: RxStatus.loading());
    isLoading.value = true;
    await useCase.getMessagesData();
    listenDataOnUpdate();
    if (useCase.chatList.list.isNotEmpty) {
      chatUsers = useCase.chatList.list;
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
    isLoading.value = false;

    super.onInit();
  }

  listenDataOnUpdate() async {
    String userId = preferences.getString(constant.userId) ?? '';
    CollectionReference ref = FirebaseFirestore.instance.collection('chats');
    final docRef = ref.doc(userId).collection('user_messages');
    docRef.snapshots().listen(
      (event) {
        final allData = event.docs.map((doc) => doc.data()).toList();
        if (allData.isNotEmpty) {
          final data = UserChatList.fromJson(allData);
          chatUsers = data.list;
          update();
        }
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

  updateMessages(int index) {
    chatUsers[index].messageData.add(
          ChatMessage(
            messageContent: msgController.text,
            typeIsSender: true,
            time: DateFormat('hh:mm').format(
              DateTime.now(),
            ),
          ),
        );
    msgController.clear();
    useCase.updateMessages(chatUsers[index]);
  }
}
