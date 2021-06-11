import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "doctorSlot.dart";
import "prescription.dart";
part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  Appointment();

  num id;
  //DateTime time;
  num serialNumber;
  String status;
  String friendlyUserName;
  num friendlyUserAge;
  num friendlyUserWeight;
  String friendlyUserBloodGroup;
  String friendlyUserGender;
  bool originalUser;
  num fee;
  num adminFee;
  bool prescriptionExist;
  bool samplePictureExist;
  bool previousReportExist;
  User user;
  DoctorSlot doctorSlot;
  Prescription prescription;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
