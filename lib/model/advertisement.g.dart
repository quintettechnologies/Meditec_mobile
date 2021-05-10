// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Advertisement _$AdvertisementFromJson(Map<String, dynamic> json) {
  return Advertisement()
    ..id = json['id'] as num
    ..advertisement = json['advertisement'] as String
    ..youtubeLink = json['youtubeLink'] as String
    ..category = json['category'] == null
        ? null
        : AdvertisementCategory.fromJson(
            json['category'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AdvertisementToJson(Advertisement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'advertisement': instance.advertisement,
      'youtubeLink': instance.youtubeLink,
      'category': instance.category
    };
