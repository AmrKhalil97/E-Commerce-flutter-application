// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

userModel_class _$userModel_classFromJson(Map<String, dynamic> json) =>
    userModel_class(
      email: json['email'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String,
      uId: json['uId'] as String,
      isEmailVerified: json['isEmailVerified'] as bool,
      image: json['image'] as String,
      followers: json['followers'] as int,
    );

Map<String, dynamic> _$userModel_classToJson(userModel_class instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'uId': instance.uId,
      'isEmailVerified': instance.isEmailVerified,
      'image': instance.image,
      'followers': instance.followers,
    };
