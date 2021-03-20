// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prescription _$PrescriptionFromJson(Map<String, dynamic> json) {
  return Prescription()
    ..id = json['id'] as num
    ..medicine = json['medicine'] as String
    ..test = json['test'] as String
    ..doctorName = json['doctorName'] as String
    ..referredTo = json['referredTo'] as String
    ..advice = json['advice'] as String
    ..patient = json['patient'] == null
        ? null
        : User.fromJson(json['patient'] as Map<String, dynamic>)
    ..doctor = json['doctor'] == null
        ? null
        : User.fromJson(json['doctor'] as Map<String, dynamic>)
    ..medicines = (json['medicines'] as List)
        ?.map((e) =>
            e == null ? null : Medicine.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..tests = (json['tests'] as List)
        ?.map(
            (e) => e == null ? null : Test.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..scedules = (json['scedules'] as List)
        ?.map((e) => e == null
            ? null
            : MedicineSchedule.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..referredDoctor = json['referredDoctor'] == null
        ? null
        : User.fromJson(json['referredDoctor'] as Map<String, dynamic>)
    ..appoinment = json['appoinment'] == null
        ? null
        : Appointment.fromJson(json['appoinment'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medicine': instance.medicine,
      'test': instance.test,
      'doctorName': instance.doctorName,
      'referredTo': instance.referredTo,
      'advice': instance.advice,
      'patient': instance.patient,
      'doctor': instance.doctor,
      'medicines': instance.medicines,
      'tests': instance.tests,
      'scedules': instance.scedules,
      'referredDoctor': instance.referredDoctor,
      'appoinment': instance.appoinment
    };
