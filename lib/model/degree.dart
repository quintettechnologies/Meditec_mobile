import 'package:json_annotation/json_annotation.dart';

part 'degree.g.dart';

@JsonSerializable()
class Degree {
    Degree();

    num id;
    String degreeName;
    
    factory Degree.fromJson(Map<String,dynamic> json) => _$DegreeFromJson(json);
    Map<String, dynamic> toJson() => _$DegreeToJson(this);
}
