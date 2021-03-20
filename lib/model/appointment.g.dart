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
    ..friendlyUserName = json['friendlyUserName'] as String
    ..friendlyUserAge = json['friendlyUserAge'] as num
    ..friendlyUserWeight = json['friendlyUserWeight'] as num
    ..friendlyUserBloodGroup = json['friendlyUserBloodGroup'] as String
    ..originalUser = json['originalUser'] as bool
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..doctorSlot = json['doctorSlot'] == null
        ? null
        : DoctorSlot.fromJson(json['doctorSlot'] as Map<String, dynamic>)
    ..prescription = json['prescription'] == null
        ? null
        : Prescription.fromJson(json['prescription'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'serialNumber': instance.serialNumber,
      'status': instance.status,
      'friendlyUserName': instance.friendlyUserName,
      'friendlyUserAge': instance.friendlyUserAge,
      'friendlyUserWeight': instance.friendlyUserWeight,
      'friendlyUserBloodGroup': instance.friendlyUserBloodGroup,
      'originalUser': instance.originalUser,
      'user': instance.user,
      'doctorSlot': instance.doctorSlot,
      'prescription': instance.prescription
    };
