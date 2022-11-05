// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brandModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

productModel_class _$productModel_classFromJson(Map<String, dynamic> json) =>
    productModel_class(
      category: json['category'] as String,
      size: json['size'] as int,
      endPointPrice: (json['endPointPrice'] as num).toDouble(),
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
          vlockPrice: (json['vlockPrice'] as num).toDouble(),
      name: json['name'] as String,
      specifications: json['specifications'] as String,
      id: json['id'] as String,
      status: json['status'] as String,
      productSubcategory: json['productSubcategory'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$productModel_classToJson(productModel_class instance) =>
    <String, dynamic>{
      'category': instance.category,
      'description': instance.description,
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'endPointPrice': instance.endPointPrice,
      'productSubcategory': instance.productSubcategory,
      'specifications': instance.specifications,
      'id': instance.id,
      'status': instance.status,
      'size': instance.size,
    };
