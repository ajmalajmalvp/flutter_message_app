import 'package:flutter/material.dart';
import 'package:flutter_emc/screens/chat_screen/provider/chat_screen_provider.dart';
import 'package:flutter_emc/screens/chat_screen/widgets/reciver_row_widget.dart';
import 'package:flutter_emc/screens/chat_screen/widgets/sender_row_widget.dart';
import 'package:provider/provider.dart';

import '../verify/provider/verify_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var controller = TextEditingController();

  var scrollController = ScrollController();

  var message = '';

  void animateList() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        if (scrollController.offset !=
            scrollController.position.maxScrollExtent) {
          animateList();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F3),
      appBar: AppBar(
        elevation: 12,
        titleSpacing: 10,
        backgroundColor: Colors.grey,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        leadingWidth: 20,
        title: const ListTile(
          title: Text(
            'Usama XD',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.call,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Consumer2<ChatScreenProvider, VerifyProvider>(
          builder: (context, chatScreenProvider, verifyProvider, _) {
        return Column(
          children: [
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ListView.builder(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: chatScreenProvider.getMessagesUserModel == null
                      ? 0
                      : chatScreenProvider.getMessagesUserModel!.data.length,
                  // itemBuilder: (context, index) => verifyProvider.accessKey ==
                  //         chatScreenProvider
                  //             .getMessagesUserModel!.data[index].sender
                  //             .toString()
                  //     // chatModelList.elementAt(index).isMee
                  //     ? SenderRowView(
                  //         index: index,
                  //         message: chatScreenProvider
                  //             .getMessagesUserModel!.data[index].message,
                  //       )
                  //     : ReceiverRowView(
                  //         index: index,
                  //         message: chatScreenProvider
                  //             .getMessagesUserModel!.data[index].message,
                  //       ),
                  itemBuilder: (context, index) {
                    final isSender = verifyProvider.userId ==
                        chatScreenProvider
                            .getMessagesUserModel!.data[index].sender
                            .toString();

                    if (isSender) {
                      return SenderRowView(
                        index: index,
                        message: chatScreenProvider
                            .getMessagesUserModel!.data[index].message,
                      );
                    } else {
                      return ReceiverRowView(
                        index: index,
                        message: chatScreenProvider
                            .getMessagesUserModel!.data[index].message,
                      );
                    }
                  },
                )),
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0, left: 8),
                    child: Icon(
                      Icons.image,
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: 6,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      controller: controller,
                      onFieldSubmitted: (value) {
                        controller.text = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8),
                        border: InputBorder.none,
                        focusColor: Colors.white,
                        hintText: 'Type a message',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12, right: 10),
                    child: Transform.rotate(
                      angle: 45,
                      child: const Icon(
                        Icons.attachment_outlined,
                        color: Color(0xffD11C2D),
                      ),
                    ),
                  ),
                  Consumer2<ChatScreenProvider, VerifyProvider>(builder:
                      (context, chatScreenProvider, verifyProvider, _) {
                    return GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   chatModelList.add(
                        //     ChatModel(controller.text, true),
                        //   );
                        //   animateList();
                        //   controller.clear();
                        // });
                        chatScreenProvider.messageSendFunction(
                          userId: int.parse(verifyProvider.userId),
                          message: controller.text,
                          receiverId: chatScreenProvider
                              .getMessagesUserModel!.data[0].receiver,
                          accessToken: verifyProvider.accessKey,
                        );
                      },
                      // onLongPress: () {
                      //   setState(() {
                      //     chatModelList.add(
                      //       ChatModel(
                      //         controller.text,
                      //         false,
                      //       ),
                      //     );
                      //     animateList();
                      //     controller.clear();
                      //   });
                      // },
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 8, right: 8),
                        child: CircleAvatar(
                          backgroundColor: Color(0xffD11C2D),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
