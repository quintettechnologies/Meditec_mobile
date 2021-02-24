// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'principal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Principal _$PrincipalFromJson(Map<String, dynamic> json) {
  return Principal()
    ..authorities = (json['authorities'] as List)
        ?.map((e) =>
            e == null ? null : Authorities.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..enabled = json['enabled'] as bool
    ..accountNonExpired = json['accountNonExpired'] as bool
    ..credentialsNonExpired = json['credentialsNonExpired'] as bool
    ..accountNonLocked = json['accountNonLocked'] as bool;
}

Map<String, dynamic> _$PrincipalToJson(Principal instance) => <String, dynamic>{
      'authorities': instance.authorities,
      'username': instance.username,
      'password': instance.password,
      'enabled': instance.enabled,
      'accountNonExpired': instance.accountNonExpired,
      'credentialsNonExpired': instance.credentialsNonExpired,
      'accountNonLocked': instance.accountNonLocked
    };
