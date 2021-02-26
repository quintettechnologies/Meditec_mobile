import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'chamber.g.dart';

@JsonSerializable()
class Chamber {
    Chamber();

    num id;
    String name;
    String adress;
    List doctorSlots;
    User user;
    
    factory Chamber.fromJson(Map<String,dynamic> json) => _$ChamberFromJson(json);
    Map<String, dynamic> toJson() => _$ChamberToJson(this);
}
