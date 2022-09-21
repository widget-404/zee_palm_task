import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class ChatScreen extends GetView<ChatScreenController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.naturalWhite,
      appBar: AppBar(
        backgroundColor: colors.naturalWhite,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Zee Palm',
          style: textStyles.bodyRegular,
        ),
      ),
      body: Obx(
        () => controller.isLoading.value ? const LoadingState() : getBody(),
      ),
      // controller.obx(
      //       (state) => getBody(),
      //   onLoading: const LoadingState(),
      //   onEmpty: const EmptyState(),
      // ),
    );
  }

  Widget getBody() {
    return GetBuilder<ChatScreenController>(builder: (context) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              itemCount: controller.chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SingleChatWidget(
                  data: controller.chatUsers[index],
                  index: index,
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
