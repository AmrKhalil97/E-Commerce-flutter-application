import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlocks/models/brandModel.dart';
import 'package:vlocks/modules/Catalog%20screens/brand-screen.dart';
import 'package:vlocks/modules/Catalog%20screens/subscriptionBrandScreen.dart';
import 'package:vlocks/modules/catalog.dart';
import 'package:vlocks/modules/home.dart';
import 'package:vlocks/modules/notifications.dart';
import 'package:vlocks/modules/profile.dart';
import 'package:vlocks/modules/vlocks.dart';
import 'package:vlocks/shared/components/buildProductCard.dart';
import 'package:vlocks/shared/components/components.dart';

import '../network/cacheHelper.dart';
import '../shared/variables/variables.dart';

class searchScreen extends StatefulWidget {
  const searchScreen() : super();

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  late String item;
  TextEditingController search=TextEditingController();
  List allResult=[];
  List resultList=[];
  int count=0;
  getData()async{
   var data = await FirebaseFirestore.instance.collection('product').get();

   setState(() {
      allResult=data.docs;
   });
   searchResultList();
   return data.docs;
  }

  searchResultList(){
    var showResults=[];
    if(search.text != ''){
       for(var tripSnapshot in allResult){
         var title=productModel_class.fromJson(tripSnapshot).name.toLowerCase();
if(title.contains(search.text.toLowerCase())){
  showResults.add(tripSnapshot);
  setState(() {
    count=showResults.length;
  });

}
       }
    }else{
      showResults=List.from(allResult);
      setState(() {
        count=showResults.length;
      });
    }
    setState(() {
      resultList=showResults;
      count=showResults.length;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CacheHelper.putList(key: 'subList',value: subItems);
    setState(() {
      item=search.text;
    });
    getData();
    searchResultList();
  }




  List<Widget> screen = [
    HomeScreen(),
    catalog(),
    notifications(),
    vlocks(),
    profile(),
  ];
  bool searchScreen = true;
  int _selectedScreenIndex = 0;

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
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF).withOpacity(0.97),
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
            ? SingleChildScrollView(
          physics: NeverScrollableScrollPhysics() ,
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: [
                    Container(
                      height: 190,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Color(0XFF800080)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40, left: 10, right: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color(0XFFFFFFFF).withOpacity(0.28),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: Row(children: [
                                  SvgPicture.asset(
                                    'lib/images/searchwhite.svg',
                                    width: 17,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFormField(

                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                      controller: search,
//                                    initialValue: '',

                                      decoration: InputDecoration(
                                          alignLabelWithHint: true,
                                          border: InputBorder.none,
                                          hintText: 'What are you looking for....',

                                          hintStyle: TextStyle(

                                            fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway',
                                              color: Colors.white.withOpacity(0.7))),
                                    onChanged: (value) {
                                      searchResultList();
                                      print(search.text);
                                      setState(() {
                                        // search.text='Jhonsons';
                                        //item=search.text;
                                      });
                                    },
                                    ),
                                  ),

                                  IconButton(
                                    icon: SvgPicture.asset(
                                      'lib/images/x-circle.svg',
                                      width: 24,
                                    ),
                                    onPressed: () => setState(() {
                                     search.text='';
                                     searchResultList();
                                    }),
                                  ),
                                ]),
                              ),
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    '${count} Items found for ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(width: 0.5, color: Colors.white),
                                      ),
                                    ),
                                    child: Text(
                                      '${search.text}'==''? 'All products': '${search.text}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 600,
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                                  itemCount:  resultList.length,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 15,
                                                      mainAxisSpacing: 15),
                                  itemBuilder: (context, index){
                                    return GestureDetector(
                                        onTap:() {
                                          if(resultList[index]['status']=='On-Demand'){
                                            Navigator.pushReplacement(
                                              context,MaterialPageRoute(builder: (context) => brandScreen(
                                              navigatingFrom: 'searchScreen',
                                              text:resultList[index]['name'],
                                              status: resultList[index]['status'],)),);
                                          }else if(resultList[index]['status']=='Subscription'){
                                            Navigator.pushReplacement(
                                              context,MaterialPageRoute(builder: (context) => subscriptionBrandScreen(
                                              endPointPrice: resultList[index]['endPointPrice'],
                                              vlockPrice:resultList[index]['vlockPrice'] ,
                                              navigatingFrom: 'searchScreen',
                                              text:resultList[index]['name'],
                                              )),);
                                          }else{
                                            Navigator.pushReplacement(
                                              context,MaterialPageRoute(builder: (context) => brandScreen(
                                              navigatingFrom: 'searchScreen',
                                              text:resultList[index]['name'],
                                              status: resultList[index]['status'],)),);
                                          }

                                        },
                                        child: buildProductCard(context, resultList[index]));
                                  }
                                  ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : screen[_selectedScreenIndex],
      ),
    );
  }

  void _selectScreen(int index) {
    setState(() {
      searchScreen = false;
      _selectedScreenIndex = index;
    });
  }



}
