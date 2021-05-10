import 'package:json_annotation/json_annotation.dart';
import "advertisementCategory.dart";
part 'advertisement.g.dart';

@JsonSerializable()
class Advertisement {
    Advertisement();

    num id;
    String advertisement;
    String youtubeLink;
    AdvertisementCategory category;
    
    factory Advertisement.fromJson(Map<String,dynamic> json) => _$AdvertisementFromJson(json);
    Map<String, dynamic> toJson() => _$AdvertisementToJson(this);
}
