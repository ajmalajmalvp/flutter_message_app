import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_emc/utils/constant.dart';
import 'package:http/http.dart' as http;

import '../model/get_message_list_model.dart';

class ChatListProvider extends ChangeNotifier {
  GetMessage? getMessageModel;
  bool getMessageLoading = true;
  Future<void> getMessageList({
    required String userId,
    required String accessToken,
  }) async {
    log("started $userId",
        name: 'getMessageList'); // Use developer.log for logging

    try {
      final response = await http.get(
        Uri.parse("${Constant.baseUrl}getmessages/$userId"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization': 'Bearer $accessToken',
        },
      );
      log(response.body);

      if (response.statusCode == 200) {
        getMessageModel = getMessageFromJson(
          response.body,
        );
        getMessageLoading = false;
        notifyListeners();
        log(getMessageModel!.data.toString(), name: 'getMessageList');
      } else {
        // If the server returns an error status code
        log(
          'Error - Status Code: ${response.statusCode}',
          name: 'getMessageList',
        );
        getMessageLoading = false;
        notifyListeners();
      }
    } catch (e) {
      // Catch any exceptions that occur during the request
      log('Error - Exception: $e', name: 'getMessageList');
      getMessageLoading = false;
      notifyListeners();
    }
  }

  ///
  ///
  bool calls = false;
  void tabBarSelected({required bool value}) {
    calls = value;
    notifyListeners();
  }
}
