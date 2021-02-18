// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addressBooks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressBooks _$AddressBooksFromJson(Map<String, dynamic> json) {
  return AddressBooks()
    ..userName = json['userName'] as String
    ..accountName = json['accountName'] as String
    ..createDate = json['createDate'] as String
    ..modifiedDate = json['modifiedDate'] as String
    ..street1 = json['street1'] as String
    ..street2 = json['street2'] as String
    ..street3 = json['street3'] as String
    ..city = json['city'] as String
    ..zip = json['zip'] as String
    ..country = json['country'] as String
    ..account = json['account'] as String
    ..addressId = json['addressId'] as num;
}

Map<String, dynamic> _$AddressBooksToJson(AddressBooks instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'accountName': instance.accountName,
      'createDate': instance.createDate,
      'modifiedDate': instance.modifiedDate,
      'street1': instance.street1,
      'street2': instance.street2,
      'street3': instance.street3,
      'city': instance.city,
      'zip': instance.zip,
      'country': instance.country,
      'account': instance.account,
      'addressId': instance.addressId
    };
