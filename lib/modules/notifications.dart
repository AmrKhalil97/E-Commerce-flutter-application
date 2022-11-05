// ignore_for_file: camel_case_types, prefer_const_constructors, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlocks/shared/components/components.dart';

class notifications extends StatelessWidget {
  bool earlier=false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () => Future.value(false),

      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 52),
              child: Center(
                child: Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Railway',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'New',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 10,),

            Flexible(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                stream: FirebaseFirestore.instance.collection('notifications').orderBy('createdAt', descending: true ).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return
                      SizedBox(
                        height: 250,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            DateTime post_time = snapshot
                                .data?.docs[index]
                                .get('createdAt').toDate();


                            DateTime now = DateTime.now();

                            print("post_time");
                            print(post_time);

                            print("end date");
                            String sDuration = "${now.difference(post_time).inHours} Hours: ${now.difference(post_time).inMinutes.remainder(60)} Minutes: ${(now.difference(post_time).inSeconds.remainder(60))} Seconds";
                           return buildNotifications(
                                img:snapshot.data!.docs[index].get('userImage')
                                ,
                                title: snapshot.data!.docs[index].get('title'),
                                postedAt:

                                sDuration.toString()
                           );
                          },

                          separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                          itemCount: 3,
                          padding: const EdgeInsets.only(right: 20, left: 20, top: 8),
                        ),
                      );
                  }
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Earlier',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            SizedBox(height: 10,),

            Flexible(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                stream: FirebaseFirestore.instance.collection('notifications').orderBy('createdAt', descending: true ).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return
                      SizedBox(
                        height: 300,
                        child: ListView.separated(
                          //physics: const NeverScrollableScrollPhysics(),
                          physics: BouncingScrollPhysics(),
                          reverse: true,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index){

                            DateTime post_time = snapshot
                                .data?.docs[index]
                                .get('createdAt').toDate();


                            DateTime now = DateTime.now();

                            print("post_time");
                            print(post_time);

                            print("end date");
                            String sDuration = "${now.difference(post_time).inHours} Hours: ${now.difference(post_time).inMinutes.remainder(60)} Minutes: ${(now.difference(post_time).inSeconds.remainder(60))} Seconds";
                            return buildNotifications(
                                img:snapshot.data!.docs[index].get('userImage')
                                ,
                                title: snapshot.data!.docs[index].get('title'),
                                postedAt:

                                sDuration.toString()
                            );
                          },

                          separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          padding: const EdgeInsets.only(right: 20, left: 20, top: 8),
                        ),
                      );
                  }
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
