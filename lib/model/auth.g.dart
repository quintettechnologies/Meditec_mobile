// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) {
  return Auth()
    ..authorities = (json['authorities'] as List)
        ?.map((e) =>
            e == null ? null : Authorities.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..details = json['details'] == null
        ? null
        : Details.fromJson(json['details'] as Map<String, dynamic>)
    ..authenticated = json['authenticated'] as bool
    ..principal = json['principal'] == null
        ? null
        : Principal.fromJson(json['principal'] as Map<String, dynamic>)
    ..credentials = json['credentials'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'authorities': instance.authorities,
      'details': instance.details,
      'authenticated': instance.authenticated,
      'principal': instance.principal,
      'credentials': instance.credentials,
      'name': instance.name
    };
