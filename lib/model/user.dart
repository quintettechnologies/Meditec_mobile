import 'package:json_annotation/json_annotation.dart';
import "userAvatar.dart";
import "addressBooks.dart";
part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    num userId;
    String name;
    String email;
    String password;
    String mobileNumber;
    String createDate;
    String modifiedDate;
    String reminderQueryQuestion;
    String facebookId;
    String gmailId;
    String twitterId;
    String loginDate;
    String loginIp;
    String lastLoginDate;
    String lastLoginIp;
    String lastFailedLoginDate;
    num failedLoginAttempts;
    bool aggreedToTermOfUse;
    bool emailVerified;
    List account;
    Map<String,dynamic> roles;
    UserAvatar userAvatar;
    AddressBooks addressBooks;
    List specialities;
    List degrees;
    List appoinments;
    List doctorSlots;
    List categories;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
