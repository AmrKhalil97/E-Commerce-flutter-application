

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'notificationsModel.g.dart';

@JsonSerializable()
class notificationsModel_class {

  String title;
  String userImage;



  notificationsModel_class({
    required this.title,
    required this.userImage,


  });

  //from Json
  factory notificationsModel_class.fromJson(DocumentSnapshot<Map<String, dynamic>> map)=>
      notificationsModel_class(
        title: map.data()!['title'],
        userImage: map.data()!['userImage'],

      );



  Map<String, dynamic> toMap(){
    return{
      'title':title,
      'userImage':userImage,
      'createdAt': FieldValue.serverTimestamp()

    };
  }
}
