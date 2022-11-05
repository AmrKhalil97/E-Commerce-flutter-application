// ignore_for_file: camel_case_types

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vlocks/layouts/home-layout.dart';

import '../../network/cacheHelper.dart';

class variables {
  int index = 0;
}
String? uId=CacheHelper.getData(key: 'uId');
  //double i=0.6;
Random random=new Random();
double i=random.nextInt(1000)/314.0;
String selectedProduct ='';
var  userName='';
int followers=0;
String? userImage=CacheHelper.getData(key: 'userImage');
FirebaseFirestore storage= FirebaseFirestore.instance;
double radius=0;
late Color avatar;

 var  allItems=[
  'Baby products',
  'Beauty',
  'Camera & Photo',
  'Education',
  'Consumer Electronics',
  'Health & Personal Care',
  'Home & Garden',
  'Personal Computers',
  'Toys & Games-',
  'Cosmetics',
  'Cleaning products',
  'Detergent',
  'Fitness',
  'Home misc.',
  'School & Office supplies',
  'Prepared meals',
  'Toiletries',

];
var statusList=[
  'On-Demand',
  'Subscription',
  'Services'
];
var onDemandItems=[
  'Baby products',
  'Beauty',
  'Camera & Photo',
  'Education',
  'Consumer Electronics',
  'Health & Personal Care',
  'Home & Garden',
  'Personal Computers',
  'Toys & Games-',
  'Cosmetics',
  'Cleaning products',
  'Detergent',
  'Fitness',
  'Home misc.',
  'School & Office supplies',
  'Prepared meals',
  'Toiletries',
];

var subscriptionItems=[
  'Baby products',
  'Cosmetics',
  'Cleaning products',
  'Detergent',
  'Fitness',
  'Home misc.',
  'School & Office supplies',
  'Prepared meals',
  'Toiletries',
];
var onDemandSubItems=[
  'Accessories',
  'Bags & Cases',
  'Sony MDR-7506',
  'Gopro & action  camera’s',
];
var subscriptionSubItems=[
  'Fabric softener',
  'Liquid',
  'Pods',
  'Powder',
];

var subCategories=[
  'Accessories',
  'Bags & Cases',
  'Sony MDR-7506',
  'Gopro & action  camera’s',
  'Fabric softener',
  'Liquid',
  'Pods',
  'Powder',
];
var subItems=CacheHelper.getList(key: 'subList') ??[
  'Accessories',
  'Bags & Cases',
  'Sony MDR-7506',
  'Gopro & action  camera’s',
  'Fabric softener',
  'Liquid',
  'Pods',
  'Powder',
  ];
String  categoryName='';
String categoryStatus='';
String categoryImage='';