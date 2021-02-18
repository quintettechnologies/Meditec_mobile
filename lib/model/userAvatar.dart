import 'package:json_annotation/json_annotation.dart';

part 'userAvatar.g.dart';

@JsonSerializable()
class UserAvatar {
    UserAvatar();

    num avatarId;
    String image;
    @JsonKey(ignore: true) dynamic user;
    
    factory UserAvatar.fromJson(Map<String,dynamic> json) => _$UserAvatarFromJson(json);
    Map<String, dynamic> toJson() => _$UserAvatarToJson(this);
}
