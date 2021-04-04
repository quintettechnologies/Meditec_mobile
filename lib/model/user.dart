import 'package:json_annotation/json_annotation.dart';
import "role.dart";
import "userAvatar.dart";
import "addressBooks.dart";
import "speciality.dart";
import "degree.dart";
import "category.dart";
import "chamber.dart";
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
  String adminNumber;
  String gender;
  num weight;
  num age;
  String bloodGroup;
  String hospitalName;
  num doctorFee;
  num doctorSecondTimeFee;
  // String doctorRegistrationNumber;
  num doctorRegistrationNumber;
  num failedLoginAttempts;
  bool aggreedToTermOfUse;
  bool emailVerified;
  List account;
  Role roles;
  UserAvatar userAvatar;
  AddressBooks addressBooks;
  Speciality speciality;
  Degree degree;
  List<Category> categories;
  List<Chamber> chambers;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
