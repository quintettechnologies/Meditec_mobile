// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return Appointment()
    ..id = json['id'] as num
    ..time = json['time'] as String
    ..status = json['status'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..doctorSlot = json['doctorSlot'] == null
        ? null
        : DoctorSlot.fromJson(json['doctorSlot'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'status': instance.status,
      'user': instance.user,
      'doctorSlot': instance.doctorSlot
    };
