import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlocks/models/brandModel.dart';
import 'package:vlocks/modules/Catalog%20screens/products-screen.dart';
import 'package:vlocks/modules/search-screen.dart';
import 'package:vlocks/modules/subscriptionCheckout.dart';

import '../../shared/components/components.dart';
import '../../shared/variables/variables.dart';
import '../catalog.dart';
import '../home.dart';
import '../notifications.dart';
import '../profile.dart';
import '../search-screen.dart';
import '../search-screen.dart';
import '../search-screen.dart';
import '../vlocks.dart';
import 'createVlock-screen.dart';

class subscriptionBrandScreen extends StatefulWidget {
  @override
  State<subscriptionBrandScreen> createState() => _brandScreenState();
  late String text;
  late String navigatingFrom;
  late double endPointPrice;
  late double vlockPrice;
  subscriptionBrandScreen({
    required this.navigatingFrom,
    required this.text,
    required this.endPointPrice,
    required this.vlockPrice,
  });
}

class _brandScreenState extends State<subscriptionBrandScreen> {


  bool endPoint =false;
  String name='';
  String image='';
  double price=0;
  String specifications='';
  String description='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

if(widget.endPointPrice==widget.vlockPrice || widget.vlockPrice<widget.endPointPrice){
setState(() {
  endPoint=true;
});
}
    getItem(
        image: this.image,
        price: this.price,
        name: this.name,
        specifications: this.specifications,
        description: this.description);
    print(image);

    print(image);
  }



  bool searchScreen1 = true;
  List<Widget> screen = [
    HomeScreen(),
    catalog(),
    notifications(),
    vlocks(),
    profile(),
  ];
  int _selectedScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,

        body: searchScreen1 ?
        Column(
          children: [
            Flexible(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                stream: FirebaseFirestore.instance.collection('product').where('name',isEqualTo:widget.text).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return
                      ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount:snapshot.data!.docs.length,
                        itemBuilder:(context, index) {
                          return SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          icon: SvgPicture.asset(
                                            'lib/images/back.svg',
                                            width: 32,
                                          ),
                                          onPressed: () {
                                            if(widget.navigatingFrom == 'searchScreen'){
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => searchScreen()));
                                            }else{
                                              Navigator.pop(context);
                                            }
                                          }
                                      ),
                                      Spacer(),
                                      GestureDetector(child: SvgPicture.asset('lib/images/share.svg')),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.asset(
                                        'lib/images/like.svg',
                                        width: 60,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(

                                                  image: NetworkImage(snapshot.data!.docs[index].get('image')), fit: BoxFit.fill)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(children: [
                                        Row(children: [Text('Vlock size:',style: TextStyle(color: Color(0xff748B9B),fontSize:12 ),),SizedBox(width: 3,),Text('${snapshot.data!.docs[index].get('size')}',style: TextStyle(color: Color(0xff800080)))],),
                                        SizedBox(width: 20,),
                                        Row(children: [Text('Cata price:',style: TextStyle(color: Color(0xff748B9B),fontSize:12),),SizedBox(width: 3,),Text('€${snapshot.data!.docs[index].get('price')}',style: TextStyle(color: Color(0xff800080)))],),
                                      ],),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          snapshot.data!.docs[index].get('name'),
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Vlock price €${snapshot.data!.docs[index].get('vlockPrice')}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff800080)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child:Visibility(
                                          visible: endPoint,
                                          child:
                                          Text(
                                            'Vlock has reached it’s bottom price',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffFE2525)),
                                          ),
                                        ),

                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Product information',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '''${snapshot.data!.docs[index].get(
                                              'description')}''',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff748B9B)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),

                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Price Trend',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ListTile(
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: ButtonTheme(
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  subscriptionCheckout(
                                    actualVlockSize: snapshot.data!.docs[index].get('size'),
                                    catalogPrice: snapshot.data!.docs[index].get('price'),
                                    endPointPrice: snapshot.data!.docs[index].get('endPointPrice'),
                                    productName: snapshot.data!.docs[index].get('name'),
                                    productID: snapshot.data!.docs[index].get('productID'),
                                    vlockPrice: snapshot.data!.docs[index].get('vlockPrice'),
                                    endPoint: endPoint,

                                  )),
                            );


                                                    },
                                                    child: Text(
                                                      'Join Vlock',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'Raleway',
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty.all(Color(0xff800080)),
                                                      shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(18.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),


                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 0,),
                      );

                  }
                  else if (snapshot.hasError) {
                    return const Text('Error',style: TextStyle(
                        fontSize: 100
                    ),);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        )
            : screen[_selectedScreenIndex]
        ,
      ),
    )
    ;  }

  void _selectScreen(int index) {
    setState(() {
      searchScreen1 = false;
      _selectedScreenIndex = index;
    });
  }

  getItem({
    var storage,
    required String image,
    required double price,
    required String name,
    required String specifications,
    required String description,



  }) async {


    try{
      var results=  await storage.collection('brand').doc('eCiSdTbifvrfwhSRBHwa').get();
      productModel_class.fromJson(results).category;
      print('category');
      categoryImage=productModel_class.fromJson(results).category;
      print(productModel_class.fromJson(results).price);
      setState(() {
        image=productModel_class.fromJson(results).image;
        price=productModel_class.fromJson(results).price;
        name=productModel_class.fromJson(results).name;
        specifications=productModel_class.fromJson(results).specifications;
      });
    }
    catch(e){
      print(e);
    }
  }
}
