// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:vlocks/models/userModel.dart';
import 'package:vlocks/modules/profile.dart';
import 'package:vlocks/modules/vlocks.dart';

import 'package:vlocks/shared/components/components.dart';
import 'package:http/http.dart' as http;

import '../models/notificationsModel.dart';
import '../network/cacheHelper.dart';
import '../shared/variables/variables.dart';
import 'catalog.dart';
import 'checkout-screen.dart';
import 'home.dart';
import 'notifications.dart';

class userProfile extends StatefulWidget {
  String id='';

  @override
  State<userProfile> createState() => _profileState();


  userProfile({required this.id});
}

class _profileState extends State<userProfile> {
  bool searchScreen = true;
  List<Widget> screen = [
    HomeScreen(),
    catalog(),
    notifications(),
    vlocks(),
    profile(),
  ];
  int _selectedScreenIndex = 0;
  int followers=0;
  bool isFollowing = false;
  final followerRef=FirebaseFirestore.instance.collection('followers');
  final followingRef=FirebaseFirestore.instance.collection('following');
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
    checkIfFollowing();
    getFollowers();
    //print(isFollowing);print(isFollowing);print(isFollowing);print(isFollowing);print(isFollowing);print(isFollowing);

//FirebaseFirestore storage= FirebaseFirestore.instance;
//   var results=  await storage.collection('users').doc(uId).get();
//   userName=userModel_class.fromJson(results).name;
//   userImage=userModel_class.fromJson(results).image;


  }
checkIfFollowing()async{
    DocumentSnapshot doc=await followerRef.doc(widget.id).collection('userFollowers').doc(uId).get();
    setState(() {
      isFollowing=doc.exists;
    });
    print(isFollowing);print(isFollowing);print(isFollowing);print(isFollowing);
}
getFollowers()async{
    QuerySnapshot snapshot=await followerRef.doc(widget.id).collection('userFollowers').get();
    setState(() {
      followers=snapshot.docs.length;
    });
}

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(


        bottomNavigationBar: Container(
          height: 63.2,
          child: Wrap(
            children: [
              BottomNavigationBar(
                backgroundColor: Colors.white,
                elevation: 0,
                currentIndex: _selectedScreenIndex,
                type: BottomNavigationBarType.fixed,
                onTap: _selectScreen,
                selectedItemColor: Color(0xFF800080),
                items: [
                  BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset('lib/images/homefilled.svg',
                          width: 20),
                      icon: SvgPicture.asset('lib/images/home.svg', width: 20),
                      label: ''),
                  BottomNavigationBarItem(
                      activeIcon:
                      SvgPicture.asset('lib/images/catalog.svg', width: 20),
                      icon: SvgPicture.asset('lib/images/catalogunfilled.svg',
                          width: 20),
                      label: ''),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                        'lib/images/notificationfilled.svg',
                        width: 20),
                    icon: SvgPicture.asset('lib/images/notifications.svg',
                        width: 20),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset('lib/images/Vlo cks.svg', width: 20),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(userImage!),
                        backgroundColor: Colors.transparent,
                      ),
                      label: ''),
                ],
              ),
            ],
          ),
        ),
        body:searchScreen
            ?
        SingleChildScrollView(

          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,

          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),

            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              builder: (context, snapshot) =>
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder:(context, index) {
                      return
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right:20),
                          child: Container(
                            decoration: BoxDecoration(

                               // Set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20.0)), // Set rounded corner radius

                            ),
                            child: SingleChildScrollView(

                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(snapshot.data?.docs[index].get('image') == null ?'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png' :snapshot.data?.docs[index].get('image')),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  // NetworkImage(imageUrl: imageUrl),
                                  // SvgPicture.asset('lib/images/avatar.svg', width: 80),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data?.docs[index].get('name') ==null?'user':snapshot.data?.docs[index].get('name'),
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.clip,

                                            ),
                                            softWrap: false,
                                          ),
                                          SizedBox(width: 10,),
                                          GestureDetector(
                                            onTap: () async {

                                              if(isFollowing == false){
                                                await followerRef
                                                    .doc(snapshot.data?.docs[index].get('uId'))
                                                    .collection('userFollowers')
                                                    .doc(uId)
                                                    .set({
                                                });

                                                await followingRef
                                                    .doc(uId)
                                                    .collection('userFollowing')
                                                    .doc(snapshot.data?.docs[index].get('uId'))
                                                    .set({
                                                });
                                                QuerySnapshot snapshotx=await followerRef.doc(widget.id).collection('userFollowers').get();
                                                setState(() {
                                                  isFollowing = true;
                                                  followers=snapshotx.docs.length;
                                                });

                                                final post = await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .where('uId', isEqualTo: widget.id)
                                                    .get()
                                                    .then((QuerySnapshot snapshot) {
                                                  //Here we get the document reference and return to the post variable.
                                                  return snapshot.docs[0].reference;
                                                });

                                                var batch =await FirebaseFirestore.instance.batch();
                                                //Updates the field value, using post as document reference
                                                batch.update(post, { 'followers': followers});
                                                batch.commit();

                                                print('updated');
                                              }
                                              else {


                                                await followerRef
                                                    .doc(snapshot.data?.docs[index].get('uId'))
                                                    .collection('userFollowers')
                                                    .doc(uId)
                                                    .get().then((doc) {
                                                  doc.reference.delete();
                                                } );

                                                await followingRef
                                                    .doc(uId)
                                                    .collection('userFollowing')
                                                    .doc(snapshot.data?.docs[index].get('uId'))
                                                    .get().then((doc) {
                                                  doc.reference.delete();
                                                });
                                                QuerySnapshot snapshotx=await followerRef.doc(widget.id).collection('userFollowers').get();
                                                setState(()
                                                {
                                                  isFollowing = false;
                                                  followers=snapshotx.docs.length;
                                                });
                                                final post = await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .where('uId', isEqualTo: widget.id)
                                                    .get()
                                                    .then((QuerySnapshot snapshot) {
                                                  //Here we get the document reference and return to the post variable.
                                                  return snapshot.docs[0].reference;
                                                });

                                                var batch =await FirebaseFirestore.instance.batch();
                                                //Updates the field value, using post as document reference
                                                batch.update(post, { 'followers': followers});
                                                batch.commit();

                                                print('updated');

                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey, // Set border color
                                                    width: 1.0),   // Set border width
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)), // Set rounded corner radius

                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Text(
                                                  isFollowing ? 'Unfollow' : 'Follow',
                                                  style: TextStyle(
                                                    color: isFollowing ? Colors.red : Colors.blue,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize:12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '$followers followers',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'invite/invitations',
                                        style: TextStyle(
                                          color: Color(0XFFAFAFAF),
                                          fontSize: 14,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                              scrollDirection: Axis.horizontal,

                              physics: BouncingScrollPhysics(),
                            ),
                          ),
                        );
                    }
                        ,
                  ),
              stream: FirebaseFirestore.instance
                  .collection('users').where('uId',isEqualTo: widget.id)
                  .snapshots(),
            ),

                SizedBox(
                  height: 15,
                ),
               Padding(
                 padding: const EdgeInsets.only(left: 20,right: 20),
                 child: Align(
                   alignment: Alignment.topLeft,
                   child: Row(
                     children: [
                       Container(
                   decoration: BoxDecoration(
                       border: Border.all(
                           color: Colors.grey, // Set border color
                           width: 1.0),   // Set border width
                       borderRadius: BorderRadius.all(
                           Radius.circular(10.0)), // Set rounded corner radius
color: Colors.white
                   ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                             'Recent Posts',
                             style: TextStyle(
                               fontSize: 12,
                               color: Colors.blue,

                             ),),
                         ),
                       ),
                       SizedBox(width: 10,),
                       Container(
                         decoration: BoxDecoration(
                           border: Border.all(
                               color: Colors.grey, // Set border color
                               width: 1.0),   // Set border width
                           borderRadius: BorderRadius.all(
                               Radius.circular(10.0)), // Set rounded corner radius
                             color: Colors.white
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                             'All Posts',
                             style: TextStyle(
                               fontSize: 12,
                               color: Colors.black,

                             ),),
                         ),
                       ),
                       Flexible(flex: 2,fit: FlexFit.tight,child: SizedBox(width: double.infinity,)),
                       Container(
                         decoration: BoxDecoration(
                           border: Border.all(
                               color: Colors.grey, // Set border color
                               width: 1.0),   // Set border width
                           borderRadius: BorderRadius.all(
                               Radius.circular(10.0)), // Set rounded corner radius
                             color: Colors.white
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                             'Filter by',
                             style: TextStyle(
                               fontSize: 12,
                               color: Colors.black,

                             ),),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),

Padding(
  padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 0),
  child:   Container(width: double.infinity,height: 0.1,color: Colors.black,),
),
                //Container(child: TextButton(onPressed: () => print('Sign out'), child: Text('Sign out',style: TextStyle(color: Colors.black),)))
                SingleChildScrollView(
                  child: Padding(

                    padding: const EdgeInsets.only(left: 20, right: 20),

                    child:
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('posts').where('publisherID',isEqualTo: widget.id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {

                          return ListView.separated(

                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                DateTime post_time = snapshot
                                    .data?.docs[index]
                                    .get('postedAt').toDate()
                                    == null ? DateTime.now() :  snapshot
                                    .data?.docs[index]
                                    .get('postedAt').toDate();

                                DateTime endDate =post_time.add(Duration(days:5));

                                print("post_time");
                                print(post_time);

                                print("end date");
                                print(endDate);
                                return Container(
                                  width: 353,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.withOpacity(0.0)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                      //border: Border.all(color: Colors.blueAccent),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child:
                                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                                      Center(
                                        child: Container(
                                          width: double.infinity,
                                          height: 220,
                                          decoration: BoxDecoration(
                                            // ignore: unnecessary_const
                                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    '${snapshot.data?.docs[index].get('image')}?? ''https://media.istockphoto.com/vectors/default-image-icon-vector-missing-picture-page-for-website-design-or-vector-id1357365823?k=20&m=1357365823&s=612x612&w=0&h=ZH0MQpeUoSHM3G2AWzc8KkGYRg4uP_kuu0Za8GFxdFc=',
                                                  ))),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      // ignore: sized_box_for_whitespace
                                      Text(
                                        '${snapshot.data?.docs[index].get('description')}',
                                        style: TextStyle(
                                          height: 1.5,
                                          color: Color(0xff212224),
                                          fontSize: 12,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 4,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SingleChildScrollView(

                                        child: Row(

                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              child: Text(
                                                '${snapshot.data?.docs[index].get('itemName')}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 16,
                                                    fontFamily: "Raleway"),
                                              ),
                                            ),
                                            Flexible(
                                                flex: 1,
                                                child: SizedBox(width: 20,)),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                '€${snapshot.data?.docs[index].get('price')}',
                                                // ignore: unnecessary_const
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF800080),
                                                    fontSize: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Text(
                                            'Vlock size: ',
                                            style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF748B9B),
                                                fontSize: 12),
                                          ),
                                          Text(
                                            '${snapshot.data?.docs[index].get('currentSize')} of ${snapshot.data?.docs[index].get('vlockSize')}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF800080),
                                                fontSize: 12,
                                                fontFamily: 'Raleway'),
                                          ),
                                          SizedBox(width:20,),
                                          const Text(
                                            'Vlock price: ',
                                            style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF748B9B),
                                                fontSize: 12),
                                          ),
                                          Text(
                                            '€${snapshot.data?.docs[index].get('price')}',
                                            style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF800080),
                                                fontSize: 12),
                                          ),
                                          // ignore: prefer_const_constructors
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      // ignore: avoid_unnecessary_containers
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Center(
                                              child: Container(
                                                width: double.infinity,
                                                height: 48,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(2000))),
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15.0),
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                      MaterialStateProperty.all(const Color(0xFF800080))),
                                                  onPressed: () => Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (context) => checkout(
                                                        currentPrice: snapshot.data?.docs[index].get('price'),
                                                        count: snapshot.data?.docs[index].get('count'),
                                                        publisherAvatar: snapshot.data?.docs[index].get('avatar'),
                                                        productName: snapshot.data?.docs[index].get('itemName'),
                                                        publisherName: snapshot.data?.docs[index].get('publisherName'),
                                                        seller: snapshot.data?.docs[index].get('publisherName'),
                                                        startPointPrice: snapshot.data?.docs[index].get('startPointPrice'),
                                                        id: snapshot.data?.docs[index].get('postID'),
                                                        publisher: snapshot.data?.docs[index].get('publisherName'),
                                                        catalogPrice: snapshot.data?.docs[index].get('catalogPrice'),
                                                        endPointPrice: snapshot.data?.docs[index].get('endPointPrice'),
                                                        actualVlockSize: snapshot.data?.docs[index].get('vlockSize'),
                                                        currentVlockSize: snapshot.data?.docs[index].get('currentSize'),
                                                      ))),
                                                  child:  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          'Join Vlock ',
                                                          style: TextStyle(
                                                              fontFamily: 'Raleway',
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white,
                                                              fontSize: 16),
                                                        ),
                                                        flex: 3,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '(Vlock ends in 3 days)',
                                                        style: TextStyle(
                                                            fontFamily: 'Raleway',
                                                            color: Colors.white.withOpacity(0.99),
                                                            fontSize: 12),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                        ],
                                      )
                                    ]),
                                  ),
                                );


                              },
                              itemCount: snapshot.data!.size,
                              separatorBuilder: (context, index) {
                                if (index % 4 == 0 && index != 0) {
                                  return  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                    builder: (context, snapshot) {

                                      if(snapshot.hasData){
                                        print('has data');
                                        double x=index/4-1;

                                        return artics(
                                            description: snapshot
                                                .data?.docs[x.toInt()]
                                                .get('description'),
                                            title: snapshot
                                                .data?.docs[x.toInt()]
                                                .get('title'),
                                            image: snapshot
                                                .data?.docs[x.toInt()]
                                                .get('image'),
                                            image2: snapshot
                                                .data?.docs[x.toInt()]
                                                .get('image2'),
                                            subTitle: snapshot
                                                .data?.docs[x.toInt()]
                                                .get('subTitle')
                                        );

                                      }
                                      return Text('data');
                                    } ,

                                    stream: FirebaseFirestore.instance
                                        .collection('ads')
                                        .snapshots(),
                                  );

                                }return Text('');
                              }
                          );
                        }
                        if (snapshot.hasError) {
                          return const Text(
                            'Error',
                            style: TextStyle(fontSize: 100),
                          );
                        }
                        else {
                          return Center(child: const CircularProgressIndicator());
                        }
                      },
                    ),

                  ),
                ),
              ],
            ),
          ),
        ): screen[_selectedScreenIndex],

      );
  }
  void _selectScreen(int index) {
    setState(() {
      searchScreen = false;
      _selectedScreenIndex = index;
    });
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



