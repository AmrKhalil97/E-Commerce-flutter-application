// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

postModel_class _$postModel_classFromJson(Map<String, dynamic> json) =>
    postModel_class(
      publisherName: json['publisherName'] as String,
      endPointPrice: (json['endPointPrice'] as num).toDouble(),
      catalogPrice: (json['catalogPrice'] as num).toDouble(),
      publisherID: json['publisherID'] as String,
      description: json['description'] as String,
      itemName: json['itemName'] as String,
      vlockCurrentSize: json['vlockCurrentSize'] as int,
      price: (json['price'] as num).toDouble(),
      currentSize: json['currentSize'] as int,
      vlockSize: json['vlockSize'] as int,
      image: json['image'] as String,
      avatar: json['avatar'] as String,
      publisherFollower: json['publisherFollower'] as int,
      postID: json['postID'] as String,
      count: json['count'] as int,
      startPointPrice: (json['startPointPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$postModel_classToJson(postModel_class instance) =>
    <String, dynamic>{
      'publisherName': instance.publisherName,
      'publisherID': instance.publisherID,
      'image': instance.image,
      'description': instance.description,
      'itemName': instance.itemName,
      'price': instance.price,
      'currentSize': instance.currentSize,
      'vlockSize': instance.vlockSize,
      'avatar': instance.avatar,
      'publisherFollower': instance.publisherFollower,
      'count': instance.count,
      'vlockCurrentSize': instance.vlockCurrentSize,
      'postID': instance.postID,
      'endPointPrice': instance.endPointPrice,
      'catalogPrice': instance.catalogPrice,
      'startPointPrice': instance.startPointPrice,
    };
