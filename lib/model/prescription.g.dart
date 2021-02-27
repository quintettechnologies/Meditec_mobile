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
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medicine': instance.medicine,
      'test': instance.test,
      'doctorName': instance.doctorName,
      'referredTo': instance.referredTo,
      'user': instance.user
    };
