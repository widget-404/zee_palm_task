import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zee_palm/data/models/chat_user_model.dart';
import 'package:zee_palm/presentation/export.dart';

class SingleChatWidget extends StatefulWidget {
  final ChatUsers data;
  final int index;

  const SingleChatWidget({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  _SingleChatWidgetState createState() => _SingleChatWidgetState();
}

class _SingleChatWidgetState extends State<SingleChatWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailScreen(
            index: widget.index,
          );
        }));
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors.primaryLight,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: colors.primaryDark.withOpacity(0.3),
                blurRadius: 3.0,
                spreadRadius: 1,
                offset: new Offset(-3.0, 3.0),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: sizes.widthRatio * 50,
                      height: sizes.widthRatio * 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colors.naturalWhite,
                          width: 3,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(widget.data.imageUrl),
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
                                color: widget.data.isOnline
                                    ? Colors.greenAccent
                                    : colors.colorGrey,
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
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.data.name,
                              style: textStyles.bodyRegular.copyWith(
                                  color: colors.primaryDark,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Obx(() {
                              return Text(
                                  widget.data.messageData.last.messageContent,
                                  style: textStyles.bodyRegular.copyWith(
                                      fontSize: 13,
                                      color:
                                          colors.primaryDark.withOpacity(0.5),
                                      fontWeight: true
                                          ? FontWeight.bold
                                          : FontWeight.normal));
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Text(
                  widget.data.messageData.last.time,
                  style: textStyles.bodyRegular.copyWith(
                      fontSize: 12,
                      fontWeight: true ? FontWeight.bold : FontWeight.normal),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
