import 'package:flutter/material.dart';
import 'package:meditec/utils/utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class ChatUser {
  final String idUser;
  final String name;
  final DateTime lastMessageTime;

  const ChatUser({
    @required this.idUser,
    @required this.name,
    @required this.lastMessageTime,
  });

  ChatUser copyWith({
    String idUser,
    String name,
    String lastMessageTime,
  }) =>
      ChatUser(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      );

  static ChatUser fromJson(Map<String, dynamic> json) => ChatUser(
        idUser: json['idUser'],
        name: json['name'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
      };
}
