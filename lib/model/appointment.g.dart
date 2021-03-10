// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return Appointment()
    ..id = json['id'] as num
    ..time = DateTime.parse(json['time'])
    ..serialNumber = json['serialNumber'] as num
    ..status = json['status'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..doctorSlot = json['doctorSlot'] == null
        ? null
        : DoctorSlot.fromJson(json['doctorSlot'] as Map<String, dynamic>)
    ..reports = (json['reports'] as List)
        ?.map((e) => e == null
            ? null
            : PrescriptionReport.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'serialNumber': instance.serialNumber,
      'status': instance.status,
      'user': instance.user,
      'doctorSlot': instance.doctorSlot,
      'reports': instance.reports
    };
