import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "chamber.dart";
part 'doctorSlot.g.dart';

@JsonSerializable()
class DoctorSlot {
  DoctorSlot();

  num id;
  String name;
  DateTime startTime;
  DateTime endTime;
  num fees;
  num maximumNumberOfAppoinment;
  User user;
  Chamber chamber;
  String dayName;
  num weekToRepeat;

  factory DoctorSlot.fromJson(Map<String, dynamic> json) =>
      _$DoctorSlotFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorSlotToJson(this);
}
