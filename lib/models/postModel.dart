import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'postModel.g.dart';

@JsonSerializable()
class postModel_class {
  String publisherName;
  String publisherID;
  String image;
  String description;
  String itemName;
  double price;
  int currentSize;
  int vlockSize;
  String avatar;
  int publisherFollower;
  int count;
  int vlockCurrentSize;
  String postID;
  double endPointPrice;
  double catalogPrice;
  double startPointPrice;



  postModel_class({
    required this.publisherName,
    required this.endPointPrice,
    required this.catalogPrice,
    required this.publisherID,
    required this.description,
    required this.itemName,
    required this.vlockCurrentSize,
    required this.price,
    required this.currentSize,required this.vlockSize,
    required this.image,
    required this.avatar,
    required this.publisherFollower,
    required this.postID,
    required this.count,
    required this.startPointPrice,


  });

  //from Json
  factory postModel_class.fromJson(DocumentSnapshot<Map<String, dynamic>> map)=>
      postModel_class(
        publisherID: map['publisherID'],
        vlockCurrentSize: map['vlockCurrentSize'],
        catalogPrice: map['catalogPrice'],
        endPointPrice: map['endPointPrice'],
        publisherName: map['publisherName'],
        description: map['description'],
        itemName: map['itemName'],
        currentSize: map['currentSize'],
        price: map['price'],
        vlockSize: map['vlockSize'],
        image: map['image'],
        avatar: map['avatar'],
        publisherFollower: map['publisherFollower'],
        postID: map['postID'],
        count: map['count'],
        startPointPrice: map['startPointPrice'],

      );



  Map<String, dynamic> toMap(){
    return{
      'publisherID':publisherID,
      'catalogPrice':catalogPrice,
      'endPointPrice':endPointPrice,
      'publisherName':publisherName,
      'description':description,
      'itemName':itemName,
      'price':price,
      'currentSize':currentSize,'vlockSize':vlockSize,
      'image':image,
      'avatar':avatar,
      'publisherFollower':publisherFollower,
      'postID':postID,
      'count':count,
      'startPointPrice':startPointPrice,
 'postedAt': FieldValue.serverTimestamp()

    };
  }
}
