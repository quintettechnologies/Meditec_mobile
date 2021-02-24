// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'degree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Degree _$DegreeFromJson(Map<String, dynamic> json) {
  return Degree()
    ..id = json['id'] as num
    ..degreeName = json['degreeName'] as String;
}

Map<String, dynamic> _$DegreeToJson(Degree instance) =>
    <String, dynamic>{'id': instance.id, 'degreeName': instance.degreeName};
