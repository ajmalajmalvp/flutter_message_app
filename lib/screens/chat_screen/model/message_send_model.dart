// To parse this JSON data, do
//
//     final messageSendModel = messageSendModelFromJson(jsonString);

import 'dart:convert';

MessageSendModel messageSendModelFromJson(String str) =>
    MessageSendModel.fromJson(json.decode(str));

String messageSendModelToJson(MessageSendModel data) =>
    json.encode(data.toJson());

class MessageSendModel {
  int status;
  String message;
  List<Datum> data;

  MessageSendModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MessageSendModel.fromJson(Map<String, dynamic> json) =>
      MessageSendModel(
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
  String id;
  String message;
  String userId;
  String receiverId;
  String parentId;
  int datumEnum;
  int messageId;

  Datum({
    required this.id,
    required this.message,
    required this.userId,
    required this.receiverId,
    required this.parentId,
    required this.datumEnum,
    required this.messageId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        message: json["message"],
        userId: json["userId"],
        receiverId: json["receiverId"],
        parentId: json["parentId"],
        datumEnum: json["enum"],
        messageId: json["messageId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "userId": userId,
        "receiverId": receiverId,
        "parentId": parentId,
        "enum": datumEnum,
        "messageId": messageId,
      };
}
