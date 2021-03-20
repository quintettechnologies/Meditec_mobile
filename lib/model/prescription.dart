import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "medicine.dart";
import "test.dart";
import "medicineSchedule.dart";
import "appointment.dart";
part 'prescription.g.dart';

@JsonSerializable()
class Prescription {
    Prescription();

    num id;
    String medicine;
    String test;
    String doctorName;
    String referredTo;
    String advice;
    User patient;
    User doctor;
    List<Medicine> medicines;
    List<Test> tests;
    List<MedicineSchedule> scedules;
    User referredDoctor;
    Appointment appoinment;
    
    factory Prescription.fromJson(Map<String,dynamic> json) => _$PrescriptionFromJson(json);
    Map<String, dynamic> toJson() => _$PrescriptionToJson(this);
}
