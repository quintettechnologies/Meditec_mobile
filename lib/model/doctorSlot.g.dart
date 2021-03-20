// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctorSlot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorSlot _$DoctorSlotFromJson(Map<String, dynamic> json) {
  return DoctorSlot()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..startTime = DateTime.parse(json['startTime'])
    ..endTime = DateTime.parse(json['endTime'])
    ..fees = json['fees'] as num
    ..maximumNumberOfAppoinment = json['maximumNumberOfAppoinment'] as num
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..chamber = json['chamber'] == null
        ? null
        : Chamber.fromJson(json['chamber'] as Map<String, dynamic>)
    ..dayName = json['dayName'] as String
    ..weekToRepeat = json['weekToRepeat'] as num;
}

Map<String, dynamic> _$DoctorSlotToJson(DoctorSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'fees': instance.fees,
      'maximumNumberOfAppoinment': instance.maximumNumberOfAppoinment,
      'user': instance.user,
      'chamber': instance.chamber,
      'dayName': instance.dayName,
      'weekToRepeat': instance.weekToRepeat
    };
