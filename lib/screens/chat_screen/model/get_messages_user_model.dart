// To parse this JSON data, do
//
//     final getMessagesUserModel = getMessagesUserModelFromJson(jsonString);

import 'dart:convert';

GetMessagesUserModel getMessagesUserModelFromJson(String str) =>
    GetMessagesUserModel.fromJson(json.decode(str));

String getMessagesUserModelToJson(GetMessagesUserModel data) =>
    json.encode(data.toJson());

class GetMessagesUserModel {
  int status;
  String message;
  List<Datum> data;

  GetMessagesUserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetMessagesUserModel.fromJson(Map<String, dynamic> json) =>
      GetMessagesUserModel(
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
  int id;
  String message;
  int sender;
  int receiver;
  int isSeen;
  DateTime createddate;
  dynamic receiverProfileImage;
  int receiverId;
  dynamic receiverName;
  int isBlock;
  int isMute;
  dynamic isRatingProfile;
  dynamic rating;

  Datum({
    required this.id,
    required this.message,
    required this.sender,
    required this.receiver,
    required this.isSeen,
    required this.createddate,
    required this.receiverProfileImage,
    required this.receiverId,
    required this.receiverName,
    required this.isBlock,
    required this.isMute,
    required this.isRatingProfile,
    required this.rating,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        message: json["message"],
        sender: json["sender"],
        receiver: json["receiver"],
        isSeen: json["is_seen"],
        createddate: DateTime.parse(json["createddate"]),
        receiverProfileImage: json["receiver_profile_image"],
        receiverId: json["receiver_id"],
        receiverName: json["receiver_name"],
        isBlock: json["is_block"],
        isMute: json["is_mute"],
        isRatingProfile: json["is_rating_profile"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "sender": sender,
        "receiver": receiver,
        "is_seen": isSeen,
        "createddate": createddate.toIso8601String(),
        "receiver_profile_image": receiverProfileImage,
        "receiver_id": receiverId,
        "receiver_name": receiverName,
        "is_block": isBlock,
        "is_mute": isMute,
        "is_rating_profile": isRatingProfile,
        "rating": rating,
      };
}
