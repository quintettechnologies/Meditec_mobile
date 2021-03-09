// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medicine _$MedicineFromJson(Map<String, dynamic> json) {
  return Medicine()
    ..id = json['id'] as num
    ..medicineName = json['medicineName'] as String;
}

Map<String, dynamic> _$MedicineToJson(Medicine instance) =>
    <String, dynamic>{'id': instance.id, 'medicineName': instance.medicineName};
