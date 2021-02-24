import 'package:json_annotation/json_annotation.dart';

part 'details.g.dart';

@JsonSerializable()
class Details {
    Details();

    String remoteAddress;
    String sessionId;
    
    factory Details.fromJson(Map<String,dynamic> json) => _$DetailsFromJson(json);
    Map<String, dynamic> toJson() => _$DetailsToJson(this);
}
