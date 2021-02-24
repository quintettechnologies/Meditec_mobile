import 'package:json_annotation/json_annotation.dart';
import "authorities.dart";
import "details.dart";
import "principal.dart";
part 'auth.g.dart';

@JsonSerializable()
class Auth {
    Auth();

    List<Authorities> authorities;
    Details details;
    bool authenticated;
    Principal principal;
    String credentials;
    String name;
    
    factory Auth.fromJson(Map<String,dynamic> json) => _$AuthFromJson(json);
    Map<String, dynamic> toJson() => _$AuthToJson(this);
}
