import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../model/get_messages_user_model.dart';
import '../model/message_send_model.dart';

class ChatScreenProvider extends ChangeNotifier {
  GetMessagesUserModel? getMessagesUserModel;
  bool getMessagesUserModelLoading = true;
  Future<void> getMessagesUser({
    required String userId,
    required String accessToken,
    required String connectedUserId,
  }) async {
    log("started $userId",
        name: 'getMessageList'); // Use developer.log for logging

    try {
      final response = await http.get(
        Uri.parse("${Constant.baseUrl}getmessage/$userId/$connectedUserId"),
        headers: {
          'authorization': 'Bearer $accessToken',
          // Add any other headers if needed
        },
      );

      if (response.statusCode == 200) {
        getMessagesUserModel = getMessagesUserModelFromJson(response.body);
        getMessagesUserModelLoading = false;
        notifyListeners();
        log(getMessagesUserModel!.data.toString(), name: 'getMessageLists');
        log(response.body.toString(), name: 'getMessageLists');
      } else {
        // If the server returns an error status code
        log('Error - Status Code: ${response.statusCode}',
            name: 'getMessageList');
        getMessagesUserModelLoading = false;
        notifyListeners();
      }
    } catch (e) {
      // Catch any exceptions that occur during the request
      log('Error - Exception: $e', name: 'getMessageList');
      getMessagesUserModelLoading = false;
      notifyListeners();
    }
  }

  MessageSendModel? messageSendModel;
  bool messageSendLoading = false;
  Future<void> messageSendFunction({
    required int userId,
    required String message,
    required int receiverId,
    required String accessToken,
  }) async {
    messageSendLoading = true;
    notifyListeners();
    try {
      final response = await http
          .post(Uri.parse("${Constant.baseUrl}sendmessage"), headers: {
        'authorization': 'Bearer $accessToken', // Add any additional headers
      }, body: {
        "id": userId.toString(),
        "message": message.toString(),
        "userId": userId.toString(),
        "receiverId": receiverId.toString(),
        "parentId": "0"
      });
      print("started");
      log(response.body.toString());
      if (response.statusCode == 200) {
        messageSendModel = messageSendModelFromJson(response.body);
        notifyListeners();
        log(messageSendModel!.data.toString(), name: "getmessage");
        log(response.body.toString());
        getMessagesUser(
          userId: userId.toString(),
          accessToken: accessToken,
          connectedUserId: receiverId.toString(),
        );
        messageSendLoading = false;
      } else {
        messageSendLoading = false;
        notifyListeners();
        log(messageSendModel.toString(), name: "getmessage");
      }
    } catch (e) {
      messageSendLoading = false;
      notifyListeners();
      print(
        e.toString() + '  error',
      );
    }
  }
}
