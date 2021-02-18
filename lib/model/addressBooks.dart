import 'package:json_annotation/json_annotation.dart';

part 'addressBooks.g.dart';

@JsonSerializable()
class AddressBooks {
    AddressBooks();

    String userName;
    String accountName;
    String createDate;
    String modifiedDate;
    String street1;
    String street2;
    String street3;
    String city;
    String zip;
    String country;
    String account;
    num addressId;
    
    factory AddressBooks.fromJson(Map<String,dynamic> json) => _$AddressBooksFromJson(json);
    Map<String, dynamic> toJson() => _$AddressBooksToJson(this);
}
