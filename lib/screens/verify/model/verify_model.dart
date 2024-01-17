// To parse this JSON data, do
//
//     final verifyModel = verifyModelFromJson(jsonString);

import 'dart:convert';

VerifyModel verifyModelFromJson(String str) =>
    VerifyModel.fromJson(json.decode(str));

String verifyModelToJson(VerifyModel data) => json.encode(data.toJson());

class VerifyModel {
  int status;
  String message;
  String accessToken;
  List<Datum> data;

  VerifyModel({
    required this.status,
    required this.message,
    required this.accessToken,
    required this.data,
  });

  factory VerifyModel.fromJson(Map<String, dynamic> json) => VerifyModel(
        status: json["status"],
        message: json["message"],
        accessToken: json["accessToken"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "accessToken": accessToken,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  dynamic name;
  dynamic firstName;
  dynamic lastName;
  dynamic emailId;
  dynamic gender;
  dynamic dob;
  dynamic profileImage;
  String messageId;
  String mobileNumber;
  String otp;
  int userType;
  dynamic profession;
  dynamic maternalStatus;
  dynamic address;
  dynamic longitude;
  dynamic latitude;
  dynamic pincode;
  dynamic currentOtpVerified;
  DateTime createdDate;
  DateTime updatedDate;
  int isOtpVerified;
  int isSaveUserDetails;
  dynamic isActive;
  dynamic createdby;
  int accessType;
  int onlineStatus;
  dynamic deviceToken;
  dynamic isBlock;
  dynamic isMute;

  Datum({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.gender,
    required this.dob,
    required this.profileImage,
    required this.messageId,
    required this.mobileNumber,
    required this.otp,
    required this.userType,
    required this.profession,
    required this.maternalStatus,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.pincode,
    required this.currentOtpVerified,
    required this.createdDate,
    required this.updatedDate,
    required this.isOtpVerified,
    required this.isSaveUserDetails,
    required this.isActive,
    required this.createdby,
    required this.accessType,
    required this.onlineStatus,
    required this.deviceToken,
    required this.isBlock,
    required this.isMute,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        emailId: json["emailId"],
        gender: json["gender"],
        dob: json["dob"],
        profileImage: json["profile_image"],
        messageId: json["message_id"],
        mobileNumber: json["mobile_number"],
        otp: json["otp"],
        userType: json["user_type"],
        profession: json["profession"],
        maternalStatus: json["maternal_status"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        pincode: json["pincode"],
        currentOtpVerified: json["current_otp_verified"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedDate: DateTime.parse(json["updated_date"]),
        isOtpVerified: json["isOtpVerified"],
        isSaveUserDetails: json["isSaveUserDetails"],
        isActive: json["is_active"],
        createdby: json["createdby"],
        accessType: json["access_type"],
        onlineStatus: json["online_status"],
        deviceToken: json["device_token"],
        isBlock: json["is_block"],
        isMute: json["is_mute"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "firstName": firstName,
        "lastName": lastName,
        "emailId": emailId,
        "gender": gender,
        "dob": dob,
        "profile_image": profileImage,
        "message_id": messageId,
        "mobile_number": mobileNumber,
        "otp": otp,
        "user_type": userType,
        "profession": profession,
        "maternal_status": maternalStatus,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "pincode": pincode,
        "current_otp_verified": currentOtpVerified,
        "created_date": createdDate.toIso8601String(),
        "updated_date": updatedDate.toIso8601String(),
        "isOtpVerified": isOtpVerified,
        "isSaveUserDetails": isSaveUserDetails,
        "is_active": isActive,
        "createdby": createdby,
        "access_type": accessType,
        "online_status": onlineStatus,
        "device_token": deviceToken,
        "is_block": isBlock,
        "is_mute": isMute,
      };
}
