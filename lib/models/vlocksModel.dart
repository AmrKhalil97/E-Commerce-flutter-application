import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'vlocksModel.g.dart';

@JsonSerializable()
class vlocksModel_class {

String description;
int followers;
int price;
String publisherName;
String publisherPic;
String url;



  vlocksModel_class({
    required this.price,
    required this.description,
    required this.url,
    required this.followers,
    required this.publisherName,
    required this.publisherPic,
  });

  //from Json
  factory vlocksModel_class.fromJson(DocumentSnapshot<Map<String, dynamic>> map)=>
      vlocksModel_class(
        publisherPic: map['publisherPic'],
        publisherName: map['publisherName'],
        url: map['url'],
        followers: map['followers'],
        description: map['description'],
        price: map['price'],

      );

  Map<String, dynamic> toMap(){
    return{
      'publisherPic':publisherPic,
      'publisherName':publisherName,
      'url':url,
      'followers':followers,
      'description':description,
      'price':price,
    };
  }
}
