import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlocks/models/brandModel.dart';
import '../../shared/components/components.dart';
import '../../shared/variables/variables.dart';

import '../modules/catalog.dart';
import '../modules/home.dart';
import '../modules/notifications.dart';
import '../modules/profile.dart';
import '../modules/vlocks.dart';


class viewAds extends StatefulWidget {
  @override
  State<viewAds> createState() => _productsScreenState();
}

class _productsScreenState extends State<viewAds> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 40),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  'View Ads',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,overflow: TextOverflow.clip
                  ),
                ),

              ],
            ),

          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
              stream: FirebaseFirestore.instance.collection('ads').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data!.docs.length==0){

                    return Center(
                      child: Text(
                        'No Ads yet.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ) ;
                  }
                  return
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return
                            Padding(padding: const EdgeInsets.only(left: 20,right:20),
                              child: articsAdmin(
                                  description: snapshot
                                      .data?.docs[index]
                                      .get('description'),
                                  title: snapshot
                                      .data?.docs[index]
                                      .get('title'),
                                  image: snapshot
                                      .data?.docs[index]
                                      .get('image'),
                                  image2: snapshot
                                      .data?.docs[index]
                                      .get('image2'),
                                  subTitle: snapshot
                                      .data?.docs[index]
                                      .get('subTitle'),
                                OnPressed: () {
                                  FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                    await myTransaction.delete(snapshot.data!.docs[index].reference);
                                  });
                                },
                              ) ,);

                        },
                        separatorBuilder:(context, index) =>  SizedBox(height: 10,),
                        itemCount: snapshot.data!.docs.length,),
                    );

                }
                if (snapshot.hasError) {
                  return const Text('Error',style: TextStyle(
                      fontSize: 100
                  ),);
                }
                else {
                  return Center(child: const CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      )
    )
    ;  }

}
