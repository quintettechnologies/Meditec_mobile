import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "doctorSlot.dart";
part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
    Appointment();

    num id;
    DateTime time;
    num serialNumber;
    String status;
    User user;
    DoctorSlot doctorSlot;
    
    factory Appointment.fromJson(Map<String,dynamic> json) => _$AppointmentFromJson(json);
    Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
