// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review()
    ..id = json['id'] as num
    ..rating = json['rating'] as num
    ..feedback = json['feedback'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..doctor = json['doctor'] == null
        ? null
        : User.fromJson(json['doctor'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'feedback': instance.feedback,
      'user': instance.user,
      'doctor': instance.doctor
    };
