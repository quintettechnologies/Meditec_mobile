// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicineSchedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineSchedule _$MedicineScheduleFromJson(Map<String, dynamic> json) {
  return MedicineSchedule()
    ..id = json['id'] as num
    ..afterMeal = json['afterMeal'] as bool
    ..morning = json['morning'] as num
    ..day = json['day'] as num
    ..night = json['night'] as num
    ..days = json['days'] as num
    ..medicine = json['medicine'] == null
        ? null
        : Medicine.fromJson(json['medicine'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MedicineScheduleToJson(MedicineSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'afterMeal': instance.afterMeal,
      'morning': instance.morning,
      'day': instance.day,
      'night': instance.night,
      'days': instance.days,
      'medicine': instance.medicine
    };
