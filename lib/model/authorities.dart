import 'package:json_annotation/json_annotation.dart';

part 'authorities.g.dart';

@JsonSerializable()
class Authorities {
    Authorities();

    String authority;
    
    factory Authorities.fromJson(Map<String,dynamic> json) => _$AuthoritiesFromJson(json);
    Map<String, dynamic> toJson() => _$AuthoritiesToJson(this);
}
