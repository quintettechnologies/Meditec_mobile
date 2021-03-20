import 'package:json_annotation/json_annotation.dart';
import "appointment.dart";
part 'samplePicture.g.dart';

@JsonSerializable()
class SamplePicture {
    SamplePicture();

    num id;
    String image;
    Appointment appoinment;
    String fileType;
    
    factory SamplePicture.fromJson(Map<String,dynamic> json) => _$SamplePictureFromJson(json);
    Map<String, dynamic> toJson() => _$SamplePictureToJson(this);
}
