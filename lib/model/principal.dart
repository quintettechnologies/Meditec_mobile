import 'package:json_annotation/json_annotation.dart';
import "authorities.dart";
part 'principal.g.dart';

@JsonSerializable()
class Principal {
    Principal();

    List<Authorities> authorities;
    String username;
    String password;
    bool enabled;
    bool accountNonExpired;
    bool credentialsNonExpired;
    bool accountNonLocked;
    
    factory Principal.fromJson(Map<String,dynamic> json) => _$PrincipalFromJson(json);
    Map<String, dynamic> toJson() => _$PrincipalToJson(this);
}
