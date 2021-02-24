import 'package:json_annotation/json_annotation.dart';

part 'speciality.g.dart';

@JsonSerializable()
class Speciality {
    Speciality();

    num id;
    String speciality;
    
    factory Speciality.fromJson(Map<String,dynamic> json) => _$SpecialityFromJson(json);
    Map<String, dynamic> toJson() => _$SpecialityToJson(this);
}
