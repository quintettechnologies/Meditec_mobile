import 'package:json_annotation/json_annotation.dart';
import 'package:meditec/model/appointment.dart';
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
  List<Appointment> appoinments;

  factory DoctorSlot.fromJson(Map<String, dynamic> json) =>
      _$DoctorSlotFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorSlotToJson(this);
}
