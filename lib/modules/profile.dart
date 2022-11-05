// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlocks/models/userModel.dart';
import 'package:vlocks/modules/signUp-screen.dart';
import 'package:vlocks/network/cacheHelper.dart';
import 'package:vlocks/shared/components/components.dart';


import '../shared/variables/variables.dart';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final followerRef=FirebaseFirestore.instance.collection('followers');
  final followingRef=FirebaseFirestore.instance.collection('following');
  int followers=0;
@override
void initState() {
    // TODO: implement initState
  super.initState();
  CacheHelper.putList(key: 'subList',value: subItems);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  uId = user?.uid??'XsAmI4BR8tDNJDGNTbJR';
  print(uId);
  print('userImage');
  print(userImage);

  getUser(storage, uId!);
  getFollowers();
  }

getFollowers()async{
  QuerySnapshot snapshot=await followerRef.doc(uId).collection('userFollowers').get();
  setState(() {
    followers=snapshot.docs.length;
    print(followers);
  });
}
  @override
  Widget build(BuildContext context) {

    return
      WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(

          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),

                buildProfileInfo(
                  imageUrl: userImage ?? 'https://firebasestorage.googleapis.com/v0/b/vlocks-680cb.appspot.com/o/profile.png?alt=media&token=68df186a-b8af-475f-b1a0-1232f1f9ea5e',
                  name: userName,
                  radius: 55,
                  followers: followers
                ),

                SizedBox(
                  height: 22,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Color(0XFF748B9B).withOpacity(0.2),
                  ),
                ),
                SizedBox(
                  height: 34,
                ),
                buildProfileFunc(
                    image: SvgPicture.asset('lib/images/account.svg', width: 30),
                    text: 'Account'),
                SizedBox(
                  height: 14,
                ),
                buildProfileFunc(
                    image: SvgPicture.asset('lib/images/delivery.svg', width: 30),
                    text: 'Delivery Option'),
                SizedBox(
                  height: 14,
                ),
                buildProfileFunc(
                    image: SvgPicture.asset('lib/images/history.svg', width: 30),
                    text: 'History'),
                SizedBox(
                  height: 14,
                ),
                buildProfileFunc(
                    image: SvgPicture.asset('lib/images/privacy.svg', width: 30),
                    text: 'Privacy'),
                SizedBox(
                  height: 14,
                ),
                buildProfileFunc(
                    image: SvgPicture.asset('lib/images/settings.svg', width: 30),
                    text: 'Settings'),
                SizedBox(
                  height: 14,
                ),
                // buildProfileFunc(
                //   onTap: () => print('kkkkk'),
                //     image: SvgPicture.asset('lib/images/logout.svg', width: 30),
                //     text: 'Logout'),

                //Container(child: TextButton(onPressed: () => print('Sign out'), child: Text('Sign out',style: TextStyle(color: Colors.black),)))
                Padding(

                  padding: const EdgeInsets.only(left: 20, right: 20),

                  child: Container(

                    decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius: BorderRadius.all(Radius.circular(20))),

                    child: TextButton(

                      style: ButtonStyle(

                        overlayColor: MaterialStateProperty.all(Colors.transparent),

                      ),

                      onPressed: () async{
                        await CacheHelper.clear('uId');
                        await CacheHelper.clear('userImage');
                        setState(() {

userImage =CacheHelper.getData(key: 'userImage');
                          print(uId);
                        });
                       await FirebaseAuth.instance.signOut();

                       Navigator.push(context, MaterialPageRoute(builder: ((context) => signUp())));
                      },

                      child: SizedBox.fromSize(

                        child: Container(

                          width: 335,

                          height: 45,

                          child: Row(

                            // ignore: prefer_const_literals_to_create_immutables

                            children: [

                              SvgPicture.asset('lib/images/logout.svg'),

                              SizedBox(

                                width: 16,

                              ),

                              Text(

                                'Sign out',

                                style: TextStyle(

                                  color: Color(0XFF000000),

                                  fontSize: 16,

                                  fontFamily: 'Raleway',

                                  fontWeight: FontWeight.w600,

                                ),

                              ),

                              Spacer(),

                              Icon(Icons.arrow_forward_ios,

                                  size: 20, color: Colors.red)

                            ],

                          ),

                        ),

                      ),

                    ),

                  ),

                ),
              ],
            ),
          ),

    ),
      );
  }


}
userData(){
  return FirebaseFirestore.instance.
  collection('users').doc().get();
  // where('uId', isEqualTo: uId).
  // get();
}


getUser(FirebaseFirestore storage,String uId) async{
  try{
    var results=  await storage.collection('users').doc(uId).get();
    userName=userModel_class.fromJson(results).name!;
    userImage=userModel_class.fromJson(results).image;
    followers=userModel_class.fromJson(results).followers;
  }
  catch(e){
    print(e);
  }
}



