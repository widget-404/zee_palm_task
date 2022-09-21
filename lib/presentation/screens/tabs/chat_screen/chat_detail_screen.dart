import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class ChatDetailScreen extends GetView<ChatScreenController> {
  final int index;

  const ChatDetailScreen({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryLight,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: colors.primaryLight,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: colors.accentPrimary,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Container(
                  width: sizes.widthRatio * 46,
                  height: sizes.widthRatio * 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.naturalWhite,
                      width: 3,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(controller.chatUsers[index].imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: controller.chatUsers[index].isOnline
                                ? Colors.greenAccent
                                : Colors.grey,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: colors.naturalWhite, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        controller.chatUsers[index].name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        controller.chatUsers[index].isOnline
                            ? "Online"
                            : "Offline",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Center(
                      child: Icon(
                        Icons.more_vert,
                        color: colors.accentPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GetBuilder<ChatScreenController>(builder: (context) {
            return SizedBox(
              height: sizes.height * 0.82,
              child: Obx(() => ListView.builder(
                    itemCount: controller.chatUsers[index].messageData.length,
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, messageIndex) {
                      return messageBox(
                          controller.chatUsers[index].messageData.length -
                              1 -
                              messageIndex);
                    },
                  )),
            );
          }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Transform.rotate(
                        angle: 70,
                        child: Icon(
                          Icons.attach_file,
                          color: colors.accentPrimary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: horizontalValue(16)),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalValue(10)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.msgController,
                                  decoration: const InputDecoration(
                                      hintText: "Write message...",
                                      hintStyle:
                                          TextStyle(color: Colors.black54),
                                      border: InputBorder.none),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: horizontalValue(5)),
                                child: GestureDetector(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    controller.updateMessages(index);
                                  },
                                  child: Icon(
                                    Icons.send,
                                    color: colors.accentPrimary,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget messageBox(int messageIndex) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (!controller
                .chatUsers[index].messageData.value[messageIndex].typeIsSender
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Padding(
          padding: controller
                  .chatUsers[index].messageData.value[messageIndex].typeIsSender
              ? EdgeInsets.only(left: horizontalValue(100))
              : EdgeInsets.only(right: horizontalValue(100)),
          child: Row(
            mainAxisAlignment: !controller.chatUsers[index].messageData
                    .value[messageIndex].typeIsSender
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              controller.chatUsers[index].messageData.value[messageIndex]
                      .typeIsSender
                  ? SizedBox.shrink()
                  : Container(
                      width: sizes.widthRatio * 46,
                      height: sizes.widthRatio * 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colors.naturalWhite,
                          width: 3,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                              controller.chatUsers[index].imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              controller.chatUsers[index].messageData.value[messageIndex]
                      .typeIsSender
                  ? SizedBox.shrink()
                  : horizontalSpacer(10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: !controller.chatUsers[index].messageData
                            .value[messageIndex].typeIsSender
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )
                        : const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                    color: (!controller.chatUsers[index].messageData
                            .value[messageIndex].typeIsSender
                        ? Colors.grey.shade200
                        : colors.accentPrimary),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.chatUsers[index].messageData
                              .value[messageIndex].messageContent,
                          style: TextStyle(
                              fontSize: 15,
                              color: controller.chatUsers[index].messageData
                                      .value[messageIndex].typeIsSender
                                  ? colors.naturalWhite
                                  : colors.primaryDark),
                        ),
                      ),
                      Text(
                        controller.chatUsers[index].messageData
                            .value[messageIndex].time,
                        style: TextStyle(
                            fontSize: 15,
                            color: controller.chatUsers[index].messageData
                                    .value[messageIndex].typeIsSender
                                ? colors.naturalWhite
                                : colors.colorGrey),
                      ),
                      horizontalSpacer(10),
                      Icon(
                        Icons.done_all,
                        size: 15,
                        color: controller.chatUsers[index].messageData
                                .value[messageIndex].typeIsSender
                            ? colors.naturalWhite
                            : colors.accentPrimary,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
