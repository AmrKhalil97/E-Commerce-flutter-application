import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlocks/admin/editProduct.dart';
import 'package:vlocks/models/brandModel.dart';
import '../../shared/components/components.dart';
import '../../shared/variables/variables.dart';

import '../modules/catalog.dart';
import '../modules/home.dart';
import '../modules/notifications.dart';
import '../modules/profile.dart';
import '../modules/vlocks.dart';
import '../network/cacheHelper.dart';


class viewProducts extends StatefulWidget {
  String category='';
  String itemImage='';
  String itemInfo='';
  String itemName='';
  double price=0;
  String specifications='';
  String subcategory='';
  @override
  State<viewProducts> createState() => _productsScreenState();
}

class _productsScreenState extends State<viewProducts> {

  @override
  void initState(){
    super.initState();
    getItem(
        prize:viewProducts().price ,
        category:viewProducts().category,
        itemImage: viewProducts().itemImage,
        itemInfo: viewProducts().itemInfo,
        itemName: viewProducts().itemName,
        specifications: viewProducts().specifications,
        subcategory: viewProducts().subcategory,
        storage:storage );
    print('print image');
    print(viewProducts().itemImage);
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
                  'Products',
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
              stream: FirebaseFirestore.instance.collection('product').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data!.docs.length==0){

                    return Center(
                      child: Text(
                        'No products yet.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ) ;
                  }
                  return
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          // modifyProductItem(
                          //   context: context,
                          //   image:  snapshot.data!.docs[index].get('image'),
                          //   productName:  snapshot.data!.docs[index].get('name'),
                          //   prize:   snapshot.data!.docs[index].get('price'),
                          //   onPressed: () {
                          //     FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                          //       await myTransaction.delete(snapshot.data!.docs[index].reference);
                          //     });
                          //   },

                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20))),

                              child: TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                onPressed: () => 0,
                                child: SizedBox.fromSize(
                                  child: Container(
                                    width: 335,
                                    height: 150,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 90,
                                            decoration: BoxDecoration(

                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius
                                                  .circular(15.0),

                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                snapshot.data!.docs[index].get('image'),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget: (context, url,
                                                    error) => Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(

                                                snapshot.data!.docs[index].get('name'),
                                                style: TextStyle(
                                                  color: Color(0XFF000000),
                                                  fontSize: 14,
                                                  fontFamily: 'Raleway',
                                                  overflow: TextOverflow.clip,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Catalog Prize',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                      fontFamily: 'Raleway',
                                                      fontWeight: FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '€ ${snapshot.data!
                                                        .docs[index].get(
                                                        'price')}',
                                                    style: TextStyle(
                                                      color: Color(0xFF7F007F),
                                                      fontSize: 12,
                                                      fontFamily: 'Raleway',
                                                      fontWeight: FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                    await myTransaction.delete(snapshot.data!.docs[index].reference);

                                                    final post = await FirebaseFirestore.instance
                                                        .collection('subCategory')
                                                        .where(
                                                        'subcategory',
                                                        isEqualTo: snapshot.data!
                                                        .docs[index].get(
                                                        'product subcategory'))
                                                        .get()
                                                        .then((QuerySnapshot snapshot) {
                                                      //Here we get the document reference and return to the post variable.
                                                      return snapshot.docs[0].reference;
                                                    });


                                                    var batch =await FirebaseFirestore.instance.batch();
                                                    //Updates the field value, using post as document reference
                                                    batch.update(post, { 'products': FieldValue.increment(-1)});
                                                    batch.commit();
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                          (states) {
                                                        return Color(0xFF7F007F)
                                                            .withOpacity(0.2);
                                                      }),
                                                  shape: MaterialStateProperty
                                                      .all(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(15.0))),
                                                ),
                                                child: const Text(
                                                    "Delete Product"),
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => editProduct(
                                                      endPointPrice: snapshot.data!.docs[index].get('endPointPrice'),
                                                      vlockPrice: snapshot.data!.docs[index].get('vlockPrice'),
                                                      productName:snapshot.data!.docs[index].get('name') ,
                                                      catalogPrice:snapshot.data!.docs[index].get('price') ,
                                                      description: snapshot.data!.docs[index].get('description'),
                                                      productID:snapshot.data!.docs[index].get('productID') ,
                                                      specification: snapshot.data!.docs[index].get('specifications'),
                                                    )),);
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                          (states) {
                                                        return Colors.greenAccent.withOpacity(0.4);
                                                      }),
                                                  shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(15.0),),),
                                                ),
                                                child: const Text(
                                                    "Edit Product"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ),
                          );
                        },
                        separatorBuilder: (
                          BuildContext context, int index) => SizedBox(height: 10,),
                        itemCount:  snapshot.data!.docs.length,)
                    );
                }
                else if (snapshot.hasError) {
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
