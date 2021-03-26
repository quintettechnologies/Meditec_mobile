import 'package:flutter/material.dart';
import 'package:meditec/utils/utils.dart';

class MessageField {
  static final String createdAt = 'createdAt';
  static final String senderID = 'senderID';
  static final String receiverID = 'receiverID';
}

class Message {
  final String senderID;
  final String senderName;
  final String receiverID;
  final String receiverName;
  final String message;
  final DateTime createdAt;

  const Message({
    @required this.senderID,
    @required this.senderName,
    @required this.receiverID,
    @required this.receiverName,
    @required this.message,
    @required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        senderID: json['senderID'],
        senderName: json['senderName'],
        receiverID: json['receiverID'],
        receiverName: json['receiverName'],
        message: json['message'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'senderID': senderID,
        'senderName': senderName,
        'receiverID': receiverID,
        'receiverName': receiverName,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}
