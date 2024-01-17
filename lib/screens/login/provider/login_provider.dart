import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_emc/screens/login/model/login_model.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../verify/screen_verify.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController phoneController = TextEditingController();

  LoginModel? loginModel;
  bool phoneLoading = false;
  Future<void> loginFunction({required BuildContext context}) async {
    phoneLoading = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse("${Constant.baseUrl}otplogin"),
        body: {
          'mobileNumber': phoneController.text,
          'userType': '1',
        },
      );
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the data
        loginModel = loginModelFromJson(response.body);
        phoneLoading = false;
        notifyListeners();
        log(loginModel!.data.toString(), name: "getmessage");

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const OTPVerificationPage(),
          ),
        );
      } else {
        phoneLoading = false;
        notifyListeners();
        log(loginModel.toString(), name: "getmessage");
      }
    } catch (e) {
      phoneLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
