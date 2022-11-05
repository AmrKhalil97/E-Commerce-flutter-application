

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'adModel.g.dart';

@JsonSerializable()
class adModel_class {

  String title;
  String subTitle;
  String image;
  String image2;
  String description;



  adModel_class({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.image2,
    required this.description,
  });

  //from Json
  factory adModel_class.fromJson(DocumentSnapshot<Map<String, dynamic>> map)=>
      adModel_class(
        title: map.data()!['title'],
        subTitle: map.data()!['subTitle'],
        image: map.data()!['image'],
        image2: map.data()!['image2'],
        description: map.data()!['description'],
      );



  Map<String, dynamic> toMap(){
    return{
      'title':title,
      'subTitle':subTitle,
      'image':image,
      'image2':image2,
      'description':description,
    };
  }
}
