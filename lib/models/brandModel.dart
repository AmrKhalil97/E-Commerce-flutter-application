

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'brandModel.g.dart';

@JsonSerializable()
class productModel_class {

 String category;
 String description;
 String image;
 String name;
 double price;
 double vlockPrice;
 double endPointPrice;
 String productSubcategory;
 String specifications;
 String id;
 String status;
 int size;

 productModel_class({
    required this.category,
    required this.size,
    required this.vlockPrice,
    required this.endPointPrice,
   required this.image,
   required this.price,
    required this.name,
    required this.specifications,
    required this.id,
    required this.status,
   required this.productSubcategory,
   required this.description,
 });

  //from Json
  factory productModel_class.fromJson(DocumentSnapshot<Map<String, dynamic>> map)=>
      productModel_class(
        category: map.data()!['category'],
        vlockPrice: map.data()!['vlockPrice'],
        size: map.data()!['size'],
        status: map.data()!['status'],
        endPointPrice: map.data()!['endPointPrice'],
        id: map.data()?['productID'],
        image: map.data()!['image'],
        name: map.data()!['name'],
        price: map.data()!['price'],
        specifications: map.data()!['specifications'],
        productSubcategory: map.data()!['product subcategory'],
        description: map.data()!['description'],
      );



  Map<String, dynamic> toMap(){
    return{
      'category':category,
      'status':status,
      'size':size,
      'vlockPrice':vlockPrice,

      'endPointPrice':endPointPrice,
      'price':price,
      'specifications':specifications,
      'productID':id,

      'description':description,
      'image':image,
      'name':name,
      'product subcategory':productSubcategory,

    };
  }
}
