import 'package:json_annotation/json_annotation.dart';

part 'medicine.g.dart';

@JsonSerializable()
class Medicine {
    Medicine();

    num id;
    String medicineName;
    @JsonKey(ignore: true) dynamic prescriptions;
    
    factory Medicine.fromJson(Map<String,dynamic> json) => _$MedicineFromJson(json);
    Map<String, dynamic> toJson() => _$MedicineToJson(this);
}
