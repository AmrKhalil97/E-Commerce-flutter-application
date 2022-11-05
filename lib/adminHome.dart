import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vlocks/admin/addProduct.dart';
import 'package:vlocks/admin/addSubscription.dart';
import 'package:vlocks/admin/viewAds.dart';
import 'package:vlocks/admin/viewOrders.dart';
import 'package:vlocks/shared/variables/variables.dart';
import 'admin/addAd.dart';
import 'admin/addSubcategory.dart';
import 'admin/viewProducts.dart';
import 'modules/signUp-screen.dart';
import 'network/cacheHelper.dart';

class admin extends StatefulWidget {

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CacheHelper.putDouble(
        key: 'index', value: i);
    CacheHelper.putList(key: 'subList',value: subItems);
    i=CacheHelper.getDouble(key: 'index')!;
    Random random=new Random();
    i=random.nextInt(1000)/314.0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text('Admin Home',style: TextStyle(
            color: Colors.black
          ),),),
        body:


        Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Text('Create a new ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  addSubcategory()),
                        );
                      },
                        child: Text('subcategory?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.blue),)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 1,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        'OR',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Container(width: 150, height: 1, color: Colors.grey)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Add product or service',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  addProduct()),
                        );
                      },
                      //color:Color(0xFF800080),
                  child: Text('Add product',style: TextStyle(color: Colors.white,fontSize: 14),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF800080), // This is what you need!
                    ),),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Create an advertise',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 130,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  addAd()),
                            );
                          },
                          //color:Color(0xFF800080),
                          child: Text('Create new ad',style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  Color(0xFF800080), // This is what you need!
                          ),),
                      ),
                    ),
                    SizedBox(width: 4,),
                    Expanded(
                      child: Container(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  viewAds()),
                            );
                          },
                          //color:Color(0xFF800080),
                          child: Text('View Ads',style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  Color(0xFF800080), // This is what you need!
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('View or delete products and orders',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  viewProducts()),
                      );
                    },
                    //color:Color(0xFF800080),
                    child: Text('View Products',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF800080), // This is what you need!
                    ),),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  viewOrders()),
                      );
                    },
                    //color:Color(0xFF800080),
                    child: Text('View Orders',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF800080), // This is what you need!
                    ),
                  ),
                ),
            SizedBox(
            height: 10,
      ),

                SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async{
                      await CacheHelper.clear('uId');

                      await FirebaseAuth.instance.signOut();

                      Navigator.push(context, MaterialPageRoute(builder: ((context) => signUp())));
                    },
                    child: Text('Logout',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Colors.red, // This is what you need!
                    ),
                  ),
                ),
      SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
