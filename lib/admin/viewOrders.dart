import 'package:animated_text_kit/animated_text_kit.dart';
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
import '../network/cacheHelper.dart';


class viewOrders extends StatefulWidget {
  String category='';
  String itemImage='';
  String itemInfo='';
  String itemName='';
  double price=0;

  String specifications='';
  String subcategory='';
  @override
  State<viewOrders> createState() => _productsScreenState();
}

class _productsScreenState extends State<viewOrders> {

  @override
  void initState(){
    super.initState();
    getItem(
        prize:viewOrders().price ,
        category:viewOrders().category,
        itemImage: viewOrders().itemImage,
        itemInfo: viewOrders().itemInfo,
        itemName: viewOrders().itemName,
        specifications: viewOrders().specifications,
        subcategory: viewOrders().subcategory,
        storage:storage );
    print('print image');
    print(viewOrders().itemImage);
    CacheHelper.putList(key: 'subList',value: subItems);
  }

  bool searchScreen = true;
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
    return Scaffold(
      body: searchScreen ?
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 40),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  'Orders',
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
              stream: FirebaseFirestore.instance.collection('orders').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data!.docs.length==0){

                    return Center(
                      child: Text(
                        'No orders yet.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ) ;
                  }else
                  return
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ListView.separated(
                        itemBuilder: (context, index) {

                          return
                            modifyOrdersItem(
                              context: context,
                              orderID: snapshot.data!.docs[index].get('OrderID'),
                              size: snapshot.data!.docs[index].get('size'),
                              productName:  snapshot.data!.docs[index].get('productName'),
                              startPointPrice:   snapshot.data!.docs[index].get('startPointPrice'),
                              endPointPrice: snapshot.data!.docs[index].get('endPointPrice'),
                              catalogPrice: snapshot.data!.docs[index].get('CatalogPrice'),
                              currentVlockPrice: snapshot.data!.docs[index].get('currentVlockPrice'),
                              actualVlockSize: snapshot.data!.docs[index].get('actualVlockSize'),
                              currentVlockSize: snapshot.data!.docs[index].get('currentVlockSize'),
                              onPressed: () {
                                FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                  await myTransaction.delete(snapshot.data!.docs[index].reference);
                                });
                              },
                              buyer: snapshot.data!.docs[index].get('buyer'),
                              shippingTo: snapshot.data!.docs[index].get('shippingTo'),
                              deliveryPeriod: snapshot.data!.docs[index].get('deliveryPeriod'),
                              selectPaymentMethod: snapshot.data!.docs[index].get('paymentMethod'),
                              seller: snapshot.data!.docs[index].get('seller'),
                            );
                        },
                        separatorBuilder:(context, index) =>  SizedBox(height: 10,),
                        itemCount: snapshot.data!.docs.length,),
                    );
                } if (!snapshot.hasData) {
                  return const Text('Error',style: TextStyle(
                      fontSize: 100
                  ),);
                }
                 if (snapshot.hasError) {
                  return const Text('Error',style: TextStyle(
                      fontSize: 100
                  ),);
                } else {
                  return Center(child: const CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      )

          : screen[_selectedScreenIndex]
      ,
    )
    ;  }

  void _selectScreen(int index) {
    setState(() {
      searchScreen = false;
      _selectedScreenIndex = index;
    });
  }



  getItem({
    var storage,
    required String category,
    required String itemInfo,
    required String itemName,
    required double prize,
    required String specifications,
    required String subcategory,
    required String itemImage,
  }) async {
    try{
      var results=  await storage.collection('brand').doc('eCiSdTbifvrfwhSRBHwa').get();
      productModel_class.fromJson(results).category;
      print('category');
      categoryImage=productModel_class.fromJson(results).category;
      print(productModel_class.fromJson(results).price);
      setState(() {
        category=productModel_class.fromJson(results).category;
        itemImage=productModel_class.fromJson(results).image;
        itemName=productModel_class.fromJson(results).name;
        prize=productModel_class.fromJson(results).price;
        subcategory=productModel_class.fromJson(results).productSubcategory;
        specifications=productModel_class.fromJson(results).specifications;
      });
    }
    catch(e){
      print(e);
    }
  }

}
