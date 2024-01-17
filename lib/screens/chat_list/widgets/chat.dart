import 'package:flutter/material.dart';
import 'package:flutter_emc/screens/chat_screen/chat_screen.dart';
import 'package:flutter_emc/utils/snackbar.dart';
import 'package:provider/provider.dart';

import '../../chat_screen/provider/chat_screen_provider.dart';
import '../../verify/provider/verify_provider.dart';
import '../model/get_message_list_model.dart';

Widget chatsWidget({required Size size, required GetMessage getMessage}) {
  return ListView.builder(
      itemCount: getMessage.data.length,
      itemBuilder: (context, index) {
        return Consumer2<ChatScreenProvider, VerifyProvider>(
            builder: (context, chatScreenProvider, verifyProvider, _) {
          return GestureDetector(
            onTap: () async {
              await chatScreenProvider.getMessagesUser(
                userId: verifyProvider.userId,
                accessToken: verifyProvider.accessKey,
                connectedUserId: getMessage.data[index].receiver.toString(),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const ChatScreen();
                  },
                ),
              );
            },
            child: ListTile(
              leading: const CircleAvatar(),
              title: Text(
                getMessage.data[index].receiverName ?? 'user',
              ),
              subtitle: Text(getMessage.data[index].message ?? 'message'),
              trailing: Column(
                children: [
                  Text(
                    formatTime(getMessage.data[index].createddate),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 10,
                    child: Center(
                      child: Text(
                        "${getMessage.data[index].activeForReciever}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ),
          );
        });
      });
}
