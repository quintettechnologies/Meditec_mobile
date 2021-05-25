// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userNotification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) {
  return UserNotification()
    ..id = json['id'] as num
    ..notification = json['notification'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserNotificationToJson(UserNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notification': instance.notification,
      'user': instance.user
    };
