// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..userId = json['userId'] as num
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..password = json['password'] as String
    ..mobileNumber = json['mobileNumber'] as String
    ..createDate = json['createDate'] as String
    ..modifiedDate = json['modifiedDate'] as String
    ..reminderQueryQuestion = json['reminderQueryQuestion'] as String
    ..facebookId = json['facebookId'] as String
    ..gmailId = json['gmailId'] as String
    ..twitterId = json['twitterId'] as String
    ..loginDate = json['loginDate'] as String
    ..loginIp = json['loginIp'] as String
    ..lastLoginDate = json['lastLoginDate'] as String
    ..lastLoginIp = json['lastLoginIp'] as String
    ..lastFailedLoginDate = json['lastFailedLoginDate'] as String
    ..adminNumber = json['adminNumber'] as String
    ..gender = json['gender'] as String
    ..weight = json['weight'] as num
    ..age = json['age'] as num
    ..bloodGroup = json['bloodGroup'] as String
    ..hospitalName = json['hospitalName'] as String
    ..failedLoginAttempts = json['failedLoginAttempts'] as num
    ..aggreedToTermOfUse = json['aggreedToTermOfUse'] as bool
    ..emailVerified = json['emailVerified'] as bool
    ..account = json['account'] as List
    ..roles = json['roles'] == null
        ? null
        : Role.fromJson(json['roles'] as Map<String, dynamic>)
    ..userAvatar = json['userAvatar'] == null
        ? null
        : UserAvatar.fromJson(json['userAvatar'] as Map<String, dynamic>)
    ..addressBooks = json['addressBooks'] == null
        ? null
        : AddressBooks.fromJson(json['addressBooks'] as Map<String, dynamic>)
    ..speciality = json['speciality'] == null
        ? null
        : Speciality.fromJson(json['speciality'] as Map<String, dynamic>)
    ..degree = json['degree'] == null
        ? null
        : Degree.fromJson(json['degree'] as Map<String, dynamic>)
    ..categories = (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..chambers = (json['chambers'] as List)
        ?.map((e) =>
            e == null ? null : Chamber.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'mobileNumber': instance.mobileNumber,
      'createDate': instance.createDate,
      'modifiedDate': instance.modifiedDate,
      'reminderQueryQuestion': instance.reminderQueryQuestion,
      'facebookId': instance.facebookId,
      'gmailId': instance.gmailId,
      'twitterId': instance.twitterId,
      'loginDate': instance.loginDate,
      'loginIp': instance.loginIp,
      'lastLoginDate': instance.lastLoginDate,
      'lastLoginIp': instance.lastLoginIp,
      'lastFailedLoginDate': instance.lastFailedLoginDate,
      'adminNumber': instance.adminNumber,
      'gender': instance.gender,
      'weight': instance.weight,
      'age': instance.age,
      'bloodGroup': instance.bloodGroup,
      'hospitalName': instance.hospitalName,
      'failedLoginAttempts': instance.failedLoginAttempts,
      'aggreedToTermOfUse': instance.aggreedToTermOfUse,
      'emailVerified': instance.emailVerified,
      'account': instance.account,
      'roles': instance.roles,
      'userAvatar': instance.userAvatar,
      'addressBooks': instance.addressBooks,
      'speciality': instance.speciality,
      'degree': instance.degree,
      'categories': instance.categories,
      'chambers': instance.chambers
    };
