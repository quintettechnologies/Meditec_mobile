// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisementCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertisementCategory _$AdvertisementCategoryFromJson(
    Map<String, dynamic> json) {
  return AdvertisementCategory()
    ..id = json['id'] as num
    ..categoryName = json['categoryName'] as String;
}

Map<String, dynamic> _$AdvertisementCategoryToJson(
        AdvertisementCategory instance) =>
    <String, dynamic>{'id': instance.id, 'categoryName': instance.categoryName};
