import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'review.g.dart';

@JsonSerializable()
class Review {
    Review();

    num id;
    num rating;
    String feedback;
    User user;
    User doctor;
    
    factory Review.fromJson(Map<String,dynamic> json) => _$ReviewFromJson(json);
    Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
