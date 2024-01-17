// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int status;
  String message;
  List<Datum> data;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String otp;
  String messageId;
  String mobileNumber;
  String userType;
  int id;

  Datum({
    required this.otp,
    required this.messageId,
    required this.mobileNumber,
    required this.userType,
    required this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        otp: json["otp"],
        messageId: json["messageId"],
        mobileNumber: json["mobile_number"],
        userType: json["user_type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "messageId": messageId,
        "mobile_number": mobileNumber,
        "user_type": userType,
        "id": id,
      };
}
