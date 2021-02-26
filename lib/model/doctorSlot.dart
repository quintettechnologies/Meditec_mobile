import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "chamber.dart";
part 'doctorSlot.g.dart';

@JsonSerializable()
class DoctorSlot {
    DoctorSlot();

    num id;
    String name;
    String startTime;
    String endTime;
    num fees;
    num maximumNumberOfAppoinment;
    User user;
    Chamber chamber;
    
    factory DoctorSlot.fromJson(Map<String,dynamic> json) => _$DoctorSlotFromJson(json);
    Map<String, dynamic> toJson() => _$DoctorSlotToJson(this);
}
