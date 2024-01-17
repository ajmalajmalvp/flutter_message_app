import 'package:flutter/material.dart';
import 'package:flutter_emc/screens/chat_list/provider/chat_list_provider.dart';
import 'package:flutter_emc/screens/chat_list/widgets/calls.dart';
import 'package:flutter_emc/screens/chat_list/widgets/chat.dart';
import 'package:flutter_emc/screens/verify/provider/verify_provider.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ChatListProvider chatListProvider =
          Provider.of<ChatListProvider>(context, listen: false);
      VerifyProvider verifyProvider =
          Provider.of<VerifyProvider>(context, listen: false);
      chatListProvider.getMessageList(
        userId: verifyProvider.userId,
        accessToken: verifyProvider.accessKey,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back_ios_new),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      // width: size.width * 0.6,
                      height: size.height * 0.04,
                      child: Consumer<ChatListProvider>(
                          builder: (context, chatProvider, value) {
                        return Row(
                          children: [
                            chatProvider.calls
                                ? Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          chatProvider.tabBarSelected(
                                              value: false);
                                        },
                                        child: SizedBox(
                                          width: size.width * 0.23,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Chats"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.25,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Calls",
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.25,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Chats",
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          chatProvider.tabBarSelected(
                                              value: true);
                                        },
                                        child: SizedBox(
                                          width: size.width * 0.23,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Calls"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        );
                      }),
                    ),
                    const Icon(
                      Icons.call,
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                SizedBox(
                  height: size.height * 0.065,
                  child: TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Expanded(
                  child: Consumer<ChatListProvider>(
                    builder: (context, chatProvider, value) {
                      return chatProvider.getMessageModel == null
                          ? const Center(
                              child: Text("No Message"),
                            )
                          : chatProvider.calls
                              ? callsWidget(size: size)
                              : chatsWidget(
                                  size: size,
                                  getMessage: chatProvider.getMessageModel!,
                                );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
