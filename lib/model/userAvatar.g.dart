// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userAvatar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAvatar _$UserAvatarFromJson(Map<String, dynamic> json) {
  return UserAvatar()
    ..avatarId = json['avatarId'] as num
    ..image = json['image'] as String;
}

Map<String, dynamic> _$UserAvatarToJson(UserAvatar instance) =>
    <String, dynamic>{'avatarId': instance.avatarId, 'image': instance.image};
