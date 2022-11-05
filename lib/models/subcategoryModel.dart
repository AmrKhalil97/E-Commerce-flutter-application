import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'subcategoryModel.g.dart';

@JsonSerializable()
class subcategoryModel_class {
  String category;
  String image;
  String subcategory;




  subcategoryModel_class({
    required this.category,
    required this.image,
    required this.subcategory,



  });

  //from Json
  factory subcategoryModel_class.fromJson(DocumentSnapshot<Map<String, dynamic>> map)=>
      subcategoryModel_class(
        category: map['category'],
        image: map['image'],
        subcategory: map['subcategory'],


      );



  Map<String, dynamic> toMap(){
    return{
      'category':category,
      'image':image,
      'subcategory':subcategory,
      'products':0,


    };
  }
}
