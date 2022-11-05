// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoriesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

categoriesModel_class _$categoriesModel_classFromJson(
        Map<String, dynamic> json) =>
    categoriesModel_class(
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
      url: json['url'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$categoriesModel_classToJson(
        categoriesModel_class instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'url': instance.url,
      'status': instance.status,
    };
