// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctorSlot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorSlot _$DoctorSlotFromJson(Map<String, dynamic> json) {
  return DoctorSlot()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..startTime = json['startTime'] as String
    ..endTime = json['endTime'] as String
    ..fees = json['fees'] as num
    ..maximumNumberOfAppoinment = json['maximumNumberOfAppoinment'] as num
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..chamber = json['chamber'] == null
        ? null
        : Chamber.fromJson(json['chamber'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DoctorSlotToJson(DoctorSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'fees': instance.fees,
      'maximumNumberOfAppoinment': instance.maximumNumberOfAppoinment,
      'user': instance.user,
      'chamber': instance.chamber
    };
