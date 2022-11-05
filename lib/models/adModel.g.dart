// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

adModel_class _$adModel_classFromJson(Map<String, dynamic> json) =>
    adModel_class(
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      image: json['image'] as String,
      image2: json['image2'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$adModel_classToJson(adModel_class instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
      'image': instance.image,
      'image2': instance.image2,
      'description': instance.description,
    };
