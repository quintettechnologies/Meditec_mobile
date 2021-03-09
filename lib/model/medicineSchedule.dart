import 'package:json_annotation/json_annotation.dart';
import "medicine.dart";
part 'medicineSchedule.g.dart';

@JsonSerializable()
class MedicineSchedule {
    MedicineSchedule();

    num id;
    num morning;
    num day;
    num night;
    num days;
    Medicine medicine;
    
    factory MedicineSchedule.fromJson(Map<String,dynamic> json) => _$MedicineScheduleFromJson(json);
    Map<String, dynamic> toJson() => _$MedicineScheduleToJson(this);
}
