import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlocks/models/brandModel.dart';
import 'package:vlocks/modules/Catalog%20screens/subscriptionBrandScreen.dart';
import '../../shared/components/components.dart';
import '../../shared/variables/variables.dart';
import '../catalog.dart';
import '../home.dart';
import '../notifications.dart';
import '../profile.dart';
import '../vlocks.dart';
import 'brand-screen.dart';

class productsScreen extends StatefulWidget {

  String category='';
  String status='';
  String itemImage='';
  String itemInfo='';
  String itemName='';
  int price=0;
  String specifications='';
  String subcategory='';
   late String text;
  productsScreen({
    required this.text,
    required this.status,
  });
  //productsScreen({Key key, @required this.text}) : super(key: key);

  @override
  State<productsScreen> createState() => _productsScreenState();
}

class _productsScreenState extends State<productsScreen> {

  @override
  void initState(){
    super.initState();
//     getItem(
//         prize:productsScreen().price ,
//         category:productsScreen().category,
//         itemImage: productsScreen().itemImage,
//         itemInfo: productsScreen().itemInfo,
//         itemName: productsScreen().itemName,
//         specifications: productsScreen().specifications,
//         subcategory: productsScreen().subcategory,
//         storage:storage );
//     print('print image');
// print(productsScreen().itemImage);
  print('product');
  print(widget.text);
  }

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
      body: searchScreen ?
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 25),
            child: Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset('lib/images/back.svg',width: 32,),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  'Products',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,overflow: TextOverflow.clip
                  ),
                ),
                Spacer(),
                SvgPicture.asset('lib/images/search.svg'),
              ],
            ),

          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
              stream: FirebaseFirestore.instance.collection('product').where('product subcategory',isEqualTo: widget.text).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return
                    ListView.separated(
                      itemBuilder: (context, index) {
                        if(snapshot.data!.docs[index].get('status') == 'Subscription'){
                          return  buildSubscriptionItem(
                            context: context,
                            image:  snapshot.data!.docs[index].get('image'),
                            productName:  snapshot.data!.docs[index].get('name'),
                            prize:   snapshot.data!.docs[index].get('price'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => subscriptionBrandScreen(
                                      navigatingFrom:'productsScreen',
                                      text: snapshot.data!.docs[index].get('name'),
                                      endPointPrice: snapshot.data!.docs[index].get('endPointPrice'),
                                      vlockPrice: snapshot.data!.docs[index].get('vlockPrice'),
                                    )),
                              );
                            },
                          );
                        }
                        else if(snapshot.data!.docs[index].get('status') == 'On-Demand'){
  return
    buildProductItem(
      context: context,
      image:  snapshot.data!.docs[index].get('image'),
      productName:  snapshot.data!.docs[index].get('name'),
      prize:   snapshot.data!.docs[index].get('price'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => brandScreen(
                navigatingFrom:'productsScreen',
                text: snapshot.data!.docs[index].get('name'),
              status: snapshot.data!.docs[index].get('status'),)),
        );
      },
    );
}
else{
  return
    buildServiceItem(
      context: context,
      image:  snapshot.data!.docs[index].get('image'),
      productName:  snapshot.data!.docs[index].get('name'),
      prize:   snapshot.data!.docs[index].get('price'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => brandScreen(
                navigatingFrom:'productsScreen',
                text: snapshot.data!.docs[index].get('name'),
                 status:snapshot.data!.docs[index].get('status') ,)),
        );
      },
    );
}

                      },
                      separatorBuilder:(context, index) =>  SizedBox(height: 10,),
                      itemCount: snapshot.data!.docs.length,);
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
