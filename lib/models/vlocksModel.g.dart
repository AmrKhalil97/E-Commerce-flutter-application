// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vlocksModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

vlocksModel_class _$vlocksModel_classFromJson(Map<String, dynamic> json) =>
    vlocksModel_class(
      price: json['price'] as int,
      description: json['description'] as String,
      url: json['url'] as String,
      followers: json['followers'] as int,
      publisherName: json['publisherName'] as String,
      publisherPic: json['publisherPic'] as String,
    );

Map<String, dynamic> _$vlocksModel_classToJson(vlocksModel_class instance) =>
    <String, dynamic>{
      'description': instance.description,
      'followers': instance.followers,
      'price': instance.price,
      'publisherName': instance.publisherName,
      'publisherPic': instance.publisherPic,
      'url': instance.url,
    };
