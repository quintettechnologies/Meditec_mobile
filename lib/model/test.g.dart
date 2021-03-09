// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) {
  return Test()
    ..id = json['id'] as num
    ..testName = json['testName'] as String;
}

Map<String, dynamic> _$TestToJson(Test instance) =>
    <String, dynamic>{'id': instance.id, 'testName': instance.testName};
