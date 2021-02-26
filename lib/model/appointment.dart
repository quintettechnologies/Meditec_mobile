import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "doctorSlot.dart";
part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
    Appointment();

    num id;
    String time;
    String status;
    User user;
    DoctorSlot doctorSlot;
    
    factory Appointment.fromJson(Map<String,dynamic> json) => _$AppointmentFromJson(json);
    Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
