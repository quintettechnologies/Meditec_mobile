import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'prescription.g.dart';

@JsonSerializable()
class Prescription {
    Prescription();

    num id;
    String medicine;
    String test;
    String doctorName;
    String referredTo;
    User user;
    
    factory Prescription.fromJson(Map<String,dynamic> json) => _$PrescriptionFromJson(json);
    Map<String, dynamic> toJson() => _$PrescriptionToJson(this);
}
