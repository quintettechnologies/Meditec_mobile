import 'package:json_annotation/json_annotation.dart';

part 'advertisementCategory.g.dart';

@JsonSerializable()
class AdvertisementCategory {
    AdvertisementCategory();

    num id;
    String categoryName;
    
    factory AdvertisementCategory.fromJson(Map<String,dynamic> json) => _$AdvertisementCategoryFromJson(json);
    Map<String, dynamic> toJson() => _$AdvertisementCategoryToJson(this);
}
