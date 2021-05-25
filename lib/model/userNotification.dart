import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'userNotification.g.dart';

@JsonSerializable()
class UserNotification {
    UserNotification();

    num id;
    String notification;
    User user;
    
    factory UserNotification.fromJson(Map<String,dynamic> json) => _$UserNotificationFromJson(json);
    Map<String, dynamic> toJson() => _$UserNotificationToJson(this);
}
