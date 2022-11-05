import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'userModel.g.dart';

@JsonSerializable()
class userModel_class {
  //variables
  String? email;
  String? name;
  String phone;
  String uId;
  bool isEmailVerified;
  String image;
  int followers;

  //constructor
  userModel_class({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.isEmailVerified,
    required this.image,
    required this.followers,
  });

  //from Json
  factory userModel_class.fromJson(
          DocumentSnapshot<Map<String, dynamic>> map) =>
      userModel_class(
        email: map['email'],
        uId: map['uId'],
        phone: map['phone'],
        name: map['name'],
        isEmailVerified: map['isEmailVerified'],
        image: map['image'],
        followers: map['followers'],
      );

  //to Json
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'followers': followers,
    };
  }
}
