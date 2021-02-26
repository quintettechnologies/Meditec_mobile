// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chamber.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chamber _$ChamberFromJson(Map<String, dynamic> json) {
  return Chamber()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..adress = json['adress'] as String
    ..doctorSlots = json['doctorSlots'] as List
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ChamberToJson(Chamber instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adress': instance.adress,
      'doctorSlots': instance.doctorSlots,
      'user': instance.user
    };
