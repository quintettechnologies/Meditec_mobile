import 'package:json_annotation/json_annotation.dart';
import "appointment.dart";
part 'prescriptionReport.g.dart';

@JsonSerializable()
class PrescriptionReport {
    PrescriptionReport();

    num id;
    String image;
    Appointment appoinment;
    
    factory PrescriptionReport.fromJson(Map<String,dynamic> json) => _$PrescriptionReportFromJson(json);
    Map<String, dynamic> toJson() => _$PrescriptionReportToJson(this);
}
