import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlocks/modules/Catalog%20screens/products-screen.dart';

import '../../shared/components/components.dart';
import '../../shared/variables/variables.dart';
import '../catalog.dart';
import '../home.dart';
import '../notifications.dart';
import '../profile.dart';
import '../vlocks.dart';

class CameraPhoto extends StatefulWidget {
  String title;

  CameraPhoto({required String this.title});

  @override
  State<CameraPhoto> createState() => _catalogScreenState();
}

class _catalogScreenState extends State<CameraPhoto> {
  bool searchScreen = true;
  List<Widget> screen = [
    HomeScreen(),
    catalog(),
    notifications(),
    vlocks(),
    profile(),
  ];
  int _selectedScreenIndex = 1;
  @override
  Widget build(BuildContext context) {
    if(_selectedScreenIndex == 4){
      setState(() {
        radius=1.5;
        avatar=Color(0xFF800080).withOpacity(1);
      });
    }else {
      setState(() {
        radius=0;
        avatar=Color(0xFF800080).withOpacity(0);
      });
    }
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 62,
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
                    activeIcon:
                    SvgPicture.asset('lib/images/homefilled.svg', width: 20),
                    icon: SvgPicture.asset('lib/images/home.svg', width: 20),
                    label: ''),
                BottomNavigationBarItem(
                    activeIcon:
                    SvgPicture.asset('lib/images/catalog.svg', width: 20),
                    icon: SvgPicture.asset('lib/images/catalogunfilled.svg',
                        width: 20),
                    label: ''),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset('lib/images/notificationfilled.svg',
                      width: 20),
                  icon: SvgPicture.asset('lib/images/notifications.svg', width: 20),
                  label: '',
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('lib/images/Vlo cks.svg', width: 20),
                    label: ''),
                BottomNavigationBarItem(
                    icon:  CircleAvatar(
                      radius: 22.5,
                      backgroundColor: Colors.transparent,
                      child: CircleAvatar(
                        backgroundColor: avatar,
                        radius: 21+radius,
                        child: CircleAvatar(

                          radius: 21,
                          backgroundImage:
                          NetworkImage(userImage ?? 'https://firebasestorage.googleapis.com/v0/b/vlocks-680cb.appspot.com/o/profile.png?alt=media&token=68df186a-b8af-475f-b1a0-1232f1f9ea5e'),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    label: ''),
              ],
            ),

          ],

        ),
      ),
      body: searchScreen
          ?
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(left: 15, right: 15, top: 25),
              child: Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'lib/images/back.svg',
                      width: 32,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    '${widget.title}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        overflow: TextOverflow.clip),
                  ),
                  Spacer(),
                  SvgPicture.asset('lib/images/search.svg'),
                ],
              ),
            ),

            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
              stream: FirebaseFirestore.instance.collection('subCategory').where('category',isEqualTo:widget.title).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  if(snapshot.data!.docs.length==0){

                    AnimatedTextKit(
                      animatedTexts: [
                      TyperAnimatedText("There are no products yet.")
                    ],);
                  }else

                  return
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                         //return
                           //Text('${snapshot.data!.docs[index].get('categoryName')}');

                            // buildCatalogSubItem(
                            //           size:  snapshot.data!.docs[index].get('products'),
                            //           subCategory:  snapshot.data!.docs[index].get('subcategory'),
                            //           url: snapshot.data!.docs[index].get('image'),
                            //           context: context);

                            return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => productsScreen(text: snapshot.data!.docs[index].get('subcategory'),status: 'On-Demand',)),
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    width: 128,
                                    height: 168,
                                    decoration: BoxDecoration(
                                      color: Color(0XFFFFFFFF),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.1,
                                          blurRadius: 0.9,
                                          offset: Offset(0, 0.5), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Container(
                                                width: 96,
                                                height: 96,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),

                                                  child: CachedNetworkImage(
                                                    imageUrl: '${snapshot.data!.docs[index].get('image')}',
                                                    fit: BoxFit.cover,
                                                    width: MediaQuery.of(context).size.width,
                                                    placeholder: (context, url) =>
                                                        CircularProgressIndicator(),
                                                    errorWidget: (context, url, error) =>
                                                    new Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${snapshot.data!.docs[index].get('subcategory')}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,

                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${snapshot.data!.docs[index].get('products')}",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0XFF800080)),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'products',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0XFF800080)),
                                                ),
                                              ],
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
                              ],
                            ),
                          );

                        },),
                    );
                }
                 if (snapshot.hasError) {
                  return  Text('Error');
                }
                 if (snapshot.data==null || snapshot.data!.docs.isEmpty) {
                  return  Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Text(
                      'There are no products right now.',
                        style: TextStyle(fontSize: 18),
                         )
                  );
                }
                 else {
                  return  CircularProgressIndicator();
                }
              },
            )

            //     StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    // builder: (context, snapshot) {
    //   if(snapshot.hasData){
    //     return Text('${snapshot.data!.docs[0].get('price')}');
    //       // GridView.builder(
    //       //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       //       crossAxisCount: 1,
    //       //
    //       //     ),
    //       //     itemBuilder:(context, index) =>  Text('done'),
    //       //     itemCount: 3,);
    //       // GridView.builder(
    //       //   itemCount: snapshot.data!.docs.length,
    //       //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       //       childAspectRatio: (MediaQuery.of(context).size.height / 1100),
    //       //       crossAxisCount: 3,
    //       //       crossAxisSpacing: 10,
    //       //       mainAxisSpacing: 10),
    //       //   itemBuilder: (context, index) {
    //       //     return buildCatalogItem(context: context,
    //       //       url: snapshot.data!.docs[index].get('url'),
    //       //       title:  snapshot.data!.docs[index].get('categoryName'),);
    //       //   },);
    // }
    // else if (snapshot.hasError) {
    //       return const Text('Error');
    //     }
    // else {
    //   return const CircularProgressIndicator();
    //   }
    // },
    // stream: FirebaseFirestore.instance.collection('product').where('category',isEqualTo: 'Camera & Photo').snapshots() ,)
            // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
            //   stream: FirebaseFirestore.instance.collection('product').where('category',isEqualTo: 'Camera & Photo').snapshots(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return
            //
            //       // GridView.custom(
            //       //
            //       //     physics: const ScrollPhysics(),
            //       //                 scrollDirection: Axis.vertical,
            //       //                 shrinkWrap: true,
            //       //                 gridDelegate:
            //       //                 SliverGridDelegateWithFixedCrossAxisCount(
            //       //                     mainAxisSpacing: 10,
            //       //                     crossAxisSpacing: 10,
            //       //                     crossAxisCount: 2),
            //       //
            //       //     childrenDelegate:
            //       //     SliverChildListDelegate([
            //       //     buildCatalogSubItem(
            //       //
            //       //     size:  snapshot.data!.docs[index].get('size'),
            //       //     subCategory:  snapshot.data!.docs[index].get('product subcategory'),
            //       //     url: snapshot.data!.docs[index].get('image'),
            //       //     context: context)
            //       //     ]));
            //
            //         GridView.builder(
            //           itemCount: snapshot.data!.docs.length,
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 2,
            //               crossAxisSpacing: 3,
            //               mainAxisSpacing: 3),
            //           itemBuilder: (context, index) {
            //             return
            //               buildCatalogSubItem(
            //               size:  snapshot.data!.docs[index].get('size'),
            //               subCategory:  snapshot.data!.docs[index].get('product subcategory'),
            //               url: snapshot.data!.docs[index].get('image'),
            //               context: context);
            //               buildCatalogItem(context: context,
            //               url: snapshot.data!.docs[index].get('url'),
            //               title:  snapshot.data!.docs[index].get('categoryName'),);
            //           },);
            //     }
            //     if (snapshot.hasError) {
            //       return const Text('Error');
            //     } else {
            //       return
            //         const CircularProgressIndicator();
            //     }
            //   },
            // )

            // Stack(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 15, right: 15),
            //       child: SingleChildScrollView(
            //         child: Column(
            //           children: [
            //             Container(
            //               height: 900,
            //               child: GridView.custom(
            //                   physics: const ScrollPhysics(),
            //                   scrollDirection: Axis.vertical,
            //                   shrinkWrap: true,
            //                   gridDelegate:
            //                   SliverGridDelegateWithFixedCrossAxisCount(
            //                       mainAxisSpacing: 10,
            //                       crossAxisSpacing: 10,
            //                       crossAxisCount: 2),
            //                   childrenDelegate: SliverChildListDelegate([
            //
            //                     buildCatalogSubItem(
            //                         context: context,
            //                         title: 'Bags & Cases',
            //                         price: '50',
            //                         url:
            //                         'https://www.figma.com/file/w8K6eoqcjSlTLKVcR5tzSy/image/7343da7ebda0b8ae04a73b78c654a3b25942322e?fuid=965558088867929695'),
            //                   ])),
            //             ),
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      )
          : screen[_selectedScreenIndex],
    );
  }

  void _selectScreen(int index) {
    setState(() {
      searchScreen = false;
      _selectedScreenIndex = index;
    });
  }
}
