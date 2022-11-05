

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:vlocks/shared/variables/variables.dart';

part 'orderModel.g.dart';

@JsonSerializable()
class orderModel_class {
  String buyer;
  String seller;
  String shippingTo;
  String paymentMethod;
  String deliveryPeriod;
  String productName;

  double currentVlockPrice;
  double CatalogPrice;
  double endPointPrice;
  double startPointPrice;
  int currentVlockSize;
  int actualVlockSize;




  orderModel_class({
    required this.buyer,
    required this.currentVlockPrice,
    required this.CatalogPrice,
    required this.startPointPrice,
    required this.endPointPrice,
    required this.currentVlockSize,
    required this.actualVlockSize,

    required this.shippingTo,
    required this.paymentMethod,
    required this.deliveryPeriod,
    required this.productName,
    required this.seller,


  });

  //from Json
  factory orderModel_class.fromJson(DocumentSnapshot<Map<String, dynamic>> map)=>
      orderModel_class(
        paymentMethod: map.data()!['paymentMethod'],
        actualVlockSize: map.data()!['actualVlockSize'],
        currentVlockSize: map.data()!['currentVlockSize'],
        currentVlockPrice: map.data()!['currentVlockPrice'],
        CatalogPrice: map.data()!['CatalogPrice'],
        startPointPrice: map.data()!['startPointPrice'],
        deliveryPeriod: map.data()!['deliveryPeriod'],
        productName: map.data()!['productName'],
        endPointPrice: map.data()!['endPointPrice'],
        shippingTo: map.data()!['shippingTo'],
        seller: map.data()!['seller'],
        buyer: map.data()!['buyer'],
      );



  Map<String, dynamic> toMap(){
    return{
      'productName':productName,
      'currentVlockSize':currentVlockSize,
      'actualVlockSize':actualVlockSize,
      'paymentMethod':paymentMethod,
      'deliveryPeriod':deliveryPeriod,
      'currentVlockPrice':currentVlockPrice,
      'CatalogPrice':CatalogPrice,
      'startPointPrice':startPointPrice,
      'endPointPrice':endPointPrice,
      'shippingTo':shippingTo,
      'size':1,
      'OrderID':i.toString(),
      'seller':seller,
      'buyer':buyer,
    };
  }
}

