// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

orderModel_class _$orderModel_classFromJson(Map<String, dynamic> json) =>
    orderModel_class(
      buyer: json['buyer'] as String,
      currentVlockPrice: (json['currentVlockPrice'] as num).toDouble(),
      CatalogPrice: (json['CatalogPrice'] as num).toDouble(),
      startPointPrice: (json['startPointPrice'] as num).toDouble(),
      endPointPrice: (json['endPointPrice'] as num).toDouble(),
      currentVlockSize: json['currentVlockSize'] as int,
      actualVlockSize: json['actualVlockSize'] as int,
      shippingTo: json['shippingTo'] as String,
      paymentMethod: json['paymentMethod'] as String,
      deliveryPeriod: json['deliveryPeriod'] as String,
      productName: json['productName'] as String,
      seller: json['seller'] as String,
    );

Map<String, dynamic> _$orderModel_classToJson(orderModel_class instance) =>
    <String, dynamic>{
      'buyer': instance.buyer,
      'seller': instance.seller,
      'shippingTo': instance.shippingTo,
      'paymentMethod': instance.paymentMethod,
      'deliveryPeriod': instance.deliveryPeriod,
      'productName': instance.productName,
      'currentVlockPrice': instance.currentVlockPrice,
      'CatalogPrice': instance.CatalogPrice,
      'endPointPrice': instance.endPointPrice,
      'startPointPrice': instance.startPointPrice,
      'currentVlockSize': instance.currentVlockSize,
      'actualVlockSize': instance.actualVlockSize,
    };
