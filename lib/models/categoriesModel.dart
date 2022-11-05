

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'categoriesModel.g.dart';

@JsonSerializable()
class categoriesModel_class {

  int categoryId;
  String categoryName;
  String url;
  String status;

  categoriesModel_class({
    required this.categoryId,
    required this.categoryName,
    required this.url,
    required this.status,
  });

  //from Json
  factory categoriesModel_class.fromJson(DocumentSnapshot<Map<String, dynamic>> map)=>
      categoriesModel_class(
        categoryId: map['categoryId'],
        categoryName: map['categoryName'],
        url: map['url'],
        status: map['status'],
      );



  Map<String, dynamic> toMap(){
    return{
      'categoryId':categoryId,
      'categoryName':categoryName,
      'url':url, 'status':status,
    };
  }
}
