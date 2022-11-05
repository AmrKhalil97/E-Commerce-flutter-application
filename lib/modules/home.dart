
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vlocks/modules/userProfile.dart';
import 'package:vlocks/modules/search-screen.dart';
import 'package:vlocks/modules/userProfile.dart';
import 'package:vlocks/shared/components/components.dart';
import 'package:vlocks/shared/variables/variables.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models/notificationsModel.dart';
import '../network/cacheHelper.dart';
import 'checkout-screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final followerRef=FirebaseFirestore.instance.collection('followers');
  final followingRef=FirebaseFirestore.instance.collection('following');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CacheHelper.putList(key: 'subList',value: subItems);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    uId = user?.uid ?? 'XsAmI4BR8tDNJDGNTbJR';
    CacheHelper.putDouble(
        key: 'index', value: i);
    i=CacheHelper.getDouble(key: 'index')!;
    Random random=new Random();
    i=random.nextInt(1000)/3614.0;

    print(userImage);
    getUser(storage, uId!);

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(

            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: const Color(0xFF7F007F),
                title: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Flexible(flex: 2,fit: FlexFit.tight,child: SvgPicture.asset('lib/images/logo.svg', width: 100)),
Flexible(fit: FlexFit.tight,
    flex: 3,child: SizedBox(width: double.infinity,)),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              DateTime date1 = DateTime.now();
                              print('Date Time');
                              print(date1);

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => searchScreen(),
                              ));
                            },
                            icon: SvgPicture.asset('lib/images/searchwhite.svg',
                                width: 20)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Stack(
                  children: [
                    Container(
                      height: 202,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF800080),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(

                        children: [
                          SizedBox(height: 20,),
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('posts').orderBy('postedAt',descending: true)
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

                                      DateTime endDate =post_time.add(Duration(days:3));

                                      print("post_time");
                                      print(post_time);

                                      print("end date");
                                      print(endDate);
                                      
                                      if( DateTime.now().isAfter(endDate) ){
                                         FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                          await myTransaction.delete(snapshot.data!.docs[index].reference);

                                          // final docpost2=FirebaseFirestore.instance.collection('notifications');
                                          // notificationsModel_class model2= notificationsModel_class(
                                          //     title: "${userName}'s Vlock was ended",
                                          //     userImage: userImage!
                                          // );
                                          //
                                          // docpost2.add(model2.toMap());
                                         });


                                      }

                                      if(snapshot .data!.docs[index].get('currentSize') == snapshot .data!.docs[index].get('vlockSize') || snapshot .data!.docs[index].get('price') == snapshot .data!.docs[index].get('endPointPrice') || snapshot .data!.docs[index].get('price') < snapshot .data!.docs[index].get('endPointPrice')  ){
                                          FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                          await myTransaction.delete(snapshot.data!.docs[index].reference);});
    // final docpost2=FirebaseFirestore.instance.collection('notifications');
    // notificationsModel_class model2= notificationsModel_class(
    // title: "${snapshot .data!.docs[index].get('publisherName')}'s Vlock was ended",
    // userImage: snapshot .data!.docs[index].get('avatar')
    // );
    //
    // docpost2.add(model2.toMap());

                                      }
                                      String currentUser=snapshot.data?.docs[index].get('publisherName');
                                      var parts=currentUser.split(' ');
                                      var prefix=parts[0].trim();

                                      if(snapshot .data!.docs[index].get('publisherID') != uId){
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
                                              Row(
                                                children: [
                                                  // ignore: prefer_const_constructors
                                                  GestureDetector(
                                                    child: CircleAvatar(
                                                      radius: 26,
                                                      backgroundImage: NetworkImage('${snapshot.data?.docs[index].get('avatar')}'),
                                                      backgroundColor: Colors.transparent,
                                                    ),
                                                    onTap: () {
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => userProfile(id: snapshot.data?.docs[index].get('publisherID'))));

                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      Text(
                                                        (snapshot.data?.docs[index].get('publisherName')).split(' ')[0].trim() !.isEmpty ? 'User' : snapshot.data?.docs[index].get('publisherName'),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 16,
                                                            fontFamily: "Raleway"),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                                          stream: FirebaseFirestore.
                                                          instance.
                                                          collection('followers').
                                                          doc(snapshot.data?.docs[index].get('publisherID')).
                                                          collection('userFollowers').
                                                          snapshots(),
                                                          builder: (context, snapshot) {
                                                            return Text('${snapshot.data?.size} Followers',style: TextStyle(fontSize: 11,color: Color(0xff748B9B),fontWeight: FontWeight.w300),);
                                                          }
                                                      )

                                                    ],
                                                  ),

                                                Flexible(flex: 1,fit: FlexFit.tight,child: SizedBox(width: double.infinity,)),
                                                  Flexible(
                                                    flex: 2,
                                                    fit: FlexFit.tight,
                                                    child: IconButton(
                                                        onPressed: () async{
                                                          final url = Uri.parse(snapshot
                                                              .data!.docs[index]
                                                              .get('image'));
                                                          // "https://www.al-monitor.com/sites/default/files/styles/article_header/public/almpics/2019/03/RTS2DKRR.jpg/RTS2DKRR.jpg?h=a5ae579a&itok=VbjmDPDs"
                                                          // ;
                                                          http.Response response =
                                                          await http.get(url);
                                                          final directory =
                                                          await getTemporaryDirectory();
                                                          final path = directory.path;
                                                          final file =
                                                          File('$path/image.png');
                                                          file.writeAsBytes(
                                                              response.bodyBytes);

                                                          Share.shareFiles(
                                                              ['$path/image.png'],
                                                              text: snapshot
                                                                  .data?.docs[index]
                                                                  .get('description'));

                                                        },
                                                        icon: SvgPicture.asset('lib/images/share.svg',width: 25,)),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
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
                                                height: 12,
                                              ),
                                              // ignore: sized_box_for_whitespace
                                              Center(
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 230,
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
                                                       flex: 2,
                                                       fit: FlexFit.tight,
                                                      child: Text(
                                                        '€${(snapshot.data?.docs[index].get('price')).roundToDouble()}',
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
                                                    '€${(snapshot.data?.docs[index].get('price')).roundToDouble()}',
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
                                              Center(
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

                                                            productName: snapshot.data?.docs[index].get('itemName'),
                                                            seller: snapshot.data?.docs[index].get('publisherName'),
                                                            startPointPrice: snapshot.data?.docs[index].get('price'),
                                                            id: snapshot.data?.docs[index].get('postID'),
                                                            publisher: snapshot.data?.docs[index].get('publisherName'),
                                                            count:snapshot.data?.docs[index].get('count'),
                                                            publisherName:snapshot.data?.docs[index].get('publisherName'),
                                                            publisherAvatar:snapshot.data?.docs[index].get('avatar'),
                                                            currentPrice: snapshot.data?.docs[index].get('price'),
                                                            catalogPrice: snapshot.data?.docs[index].get('catalogPrice'),
                                                            endPointPrice: snapshot.data?.docs[index].get('endPointPrice'),
                                                            actualVlockSize: snapshot.data?.docs[index].get('vlockSize'),
                                                            currentVlockSize: snapshot.data?.docs[index].get('currentSize'),



                                                          ))),
                                                      child:  Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            'Join Vlock ',
                                                            style: TextStyle(
                                                                fontFamily: 'Raleway',
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white,
                                                                fontSize: 16),
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
                                              )
                                            ]),
                                          ),
                                        );
                                      }


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
                                            Row(
                                              children: [
                                                // ignore: prefer_const_constructors
                                                CircleAvatar(
                                                  radius: 26,
                                                  backgroundImage: NetworkImage('${snapshot.data?.docs[index].get('avatar')}'),
                                                  backgroundColor: Colors.transparent,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,

                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Text(
                                                      (snapshot.data?.docs[index].get('publisherName')).split(' ')[0].trim()!.isEmpty ? 'User' : snapshot.data?.docs[index].get('publisherName'),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 16,
                                                          fontFamily: "Raleway"),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                                        stream: FirebaseFirestore.
                                                        instance.
                                                        collection('followers').
                                                        doc(snapshot.data?.docs[index].get('publisherID')).
                                                        collection('userFollowers').
                                                        snapshots(),
                                                        builder: (context, snapshot) {
                                                          return Text('${snapshot.data?.size} Followers',style: TextStyle(fontSize: 11,color: Color(0xff748B9B),fontWeight: FontWeight.w300),);
                                                        }
                                                    )

                                                  ],
                                                ),

                                                Flexible(flex: 2,fit: FlexFit.tight,child: SizedBox(width: double.infinity,)),
                                                Flexible(

                                                  fit: FlexFit.tight,
                                                  child:
                                                  IconButton(
                                                      onPressed: () async{
                                                        final url = Uri.parse(snapshot
                                                            .data!.docs[index]
                                                            .get('image'));
                                                        // "https://www.al-monitor.com/sites/default/files/styles/article_header/public/almpics/2019/03/RTS2DKRR.jpg/RTS2DKRR.jpg?h=a5ae579a&itok=VbjmDPDs"
                                                        // ;
                                                        http.Response response =
                                                        await http.get(url);
                                                        final directory =
                                                        await getTemporaryDirectory();
                                                        final path = directory.path;
                                                        final file =
                                                        File('$path/image.png');
                                                        file.writeAsBytes(
                                                            response.bodyBytes);

                                                        Share.shareFiles(
                                                            ['$path/image.png'],
                                                            text: snapshot
                                                                .data?.docs[index]
                                                                .get('description'));

                                                      },
                                                      icon: SvgPicture.asset('lib/images/share.svg',width: 25,)),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
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
                                              height: 12,
                                            ),
                                            // ignore: sized_box_for_whitespace
                                            Center(
                                              child: Container(
                                                width: double.infinity,
                                                height: 230,
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
                                                      '€${(snapshot.data?.docs[index].get('price')).roundToDouble()}',
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
                                                  '€${(snapshot.data?.docs[index].get('price')).roundToDouble()}',
                                                  style: TextStyle(
                                                      fontFamily: 'Raleway',
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFF800080),
                                                      fontSize: 12),
                                                ),
                                                // ignore: prefer_const_constructors
                                              ],
                                            ),

                                            // ignore: avoid_unnecessary_containers

                                          ]),
                                        ),
                                      );


                                      },
                                    itemCount: snapshot.data!.docs.length,
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
