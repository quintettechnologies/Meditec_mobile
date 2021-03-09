// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescriptionReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionReport _$PrescriptionReportFromJson(Map<String, dynamic> json) {
  return PrescriptionReport()
    ..id = json['id'] as num
    ..image = json['image'] as String
    ..appoinment = json['appoinment'] == null
        ? null
        : Appointment.fromJson(json['appoinment'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PrescriptionReportToJson(PrescriptionReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'appoinment': instance.appoinment
    };
