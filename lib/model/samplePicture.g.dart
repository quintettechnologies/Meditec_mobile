// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'samplePicture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SamplePicture _$SamplePictureFromJson(Map<String, dynamic> json) {
  return SamplePicture()
    ..id = json['id'] as num
    ..image = json['image'] as String
    ..appoinment = json['appoinment'] == null
        ? null
        : Appointment.fromJson(json['appoinment'] as Map<String, dynamic>)
    ..fileType = json['fileType'] as String;
}

Map<String, dynamic> _$SamplePictureToJson(SamplePicture instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'appoinment': instance.appoinment,
      'fileType': instance.fileType
    };
