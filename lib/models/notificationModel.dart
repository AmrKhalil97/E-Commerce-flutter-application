//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'dart:convert';
//
// part 'brandModel.g.dart';
//
// @JsonSerializable()
// class brandModel_class {
//
//   String category;
//   String itemImage;
//   String itemInfo;
//   String itemName;
//   int price;
//   String specifications;
//   String subcategory;
//
//   brandModel_class({
//     required this.category,
//     required this.itemImage,
//     required this.itemInfo,
//     required this.itemName,
//     required this.price,
//     required this.specifications,
//     required this.subcategory,
//   });
//
//   //from Json
//   factory brandModel_class.fromJson(DocumentSnapshot<Map<String, dynamic>> map)=>
//       brandModel_class(
//         category: map['category'],
//         itemImage: map['itemImage'],
//         itemInfo: map['itemInfo'],
//         itemName: map['itemName'],
//         price: map['price'],
//         specifications: map['specifications'],
//         subcategory: map['subcategory'],
//       );
//
//
//
//   Map<String, dynamic> toMap(){
//     return{
//       'category':category,
//       'itemImage':itemImage,
//       'itemInfo':itemInfo,
//       'itemName':itemName,
//       'price':price,
//       'specifications':specifications,
//       'subcategory':subcategory,
//     };
//   }
// }
