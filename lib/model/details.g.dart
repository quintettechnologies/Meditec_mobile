// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Details _$DetailsFromJson(Map<String, dynamic> json) {
  return Details()
    ..remoteAddress = json['remoteAddress'] as String
    ..sessionId = json['sessionId'] as String;
}

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'remoteAddress': instance.remoteAddress,
      'sessionId': instance.sessionId
    };
