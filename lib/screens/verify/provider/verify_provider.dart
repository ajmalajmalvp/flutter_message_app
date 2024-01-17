import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_emc/screens/chat_list/chat_list.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constant.dart';
import '../../login/model/login_model.dart';
import '../model/verify_model.dart';

class VerifyProvider extends ChangeNotifier {
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();
  TextEditingController text3 = TextEditingController();
  TextEditingController text4 = TextEditingController();
  TextEditingController text5 = TextEditingController();
  TextEditingController text6 = TextEditingController();

  String accessKey = '';
  String userId = '';

  Future<void> saveAuthKey(
      {required String accessToken, required String userId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessKey', accessToken);
    await prefs.setString('userId', userId);
  }

  Future<void> getAuthKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessKey = prefs.getString('accessKey') ?? '';
    userId = prefs.getString('userId') ?? '';
    log(accessKey.toString());
    notifyListeners();
  }

  String otpMain = '';
  void getOtp() {
    otpMain =
        "${text1.text}${text2.text}${text3.text}${text4.text}${text5.text}${text6.text}";
    notifyListeners();
    log(otpMain);
  }

  VerifyModel? verifyModel;
  bool verifyLoading = false;
  Future<void> verifyFunction(
      {required BuildContext context, required LoginModel loginModel}) async {
    verifyLoading = true;
    notifyListeners();
    try {
      getOtp();
      final response = await http.post(
        Uri.parse("${Constant.baseUrl}otpverify"),
        body: {
          "id": "${loginModel.data[0].id}",
          "otp": otpMain,
        },
      );
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the data
        verifyModel = verifyModelFromJson(response.body);
        verifyLoading = false;
        log(verifyModel!.data.toString(), name: "getmessage");
        await saveAuthKey(
          accessToken: verifyModel!.accessToken,
          userId: verifyModel!.data[0].id.toString(),
        );
        accessKey = verifyModel!.accessToken;
        userId = verifyModel!.data[0].id.toString();
        notifyListeners();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ChatListScreen(),
          ),
        );
      } else {
        verifyLoading = false;
        notifyListeners();
        log(verifyModel.toString(), name: "getmessage");
      }
    } catch (e) {
      verifyLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
