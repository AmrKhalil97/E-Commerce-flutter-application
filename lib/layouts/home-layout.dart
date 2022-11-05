
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlocks/modules/catalog.dart';
import 'package:vlocks/modules/home.dart';
import 'package:vlocks/modules/notifications.dart';
import 'package:vlocks/modules/profile.dart';

import '../modules/vlocks.dart';
import '../network/cacheHelper.dart';
import '../shared/variables/variables.dart';

class Home extends StatefulWidget {



  @override
  State<Home> createState() => _HomeState();


}

class _HomeState extends State<Home> {


late String image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    uId = user?.uid??'XsAmI4BR8tDNJDGNTbJR';
    print(uId);
setState(() {
  getUser(storage, uId!);
  image=userImage!;
  CacheHelper.putList(key: 'subList',value: subItems);
});

//FirebaseFirestore storage= FirebaseFirestore.instance;
//   var results=  await storage.collection('users').doc(uId).get();
//   userName=userModel_class.fromJson(results).name;
//   userImage=userModel_class.fromJson(results).image;
  }



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
      body:
      screen[_selectedScreenIndex],
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
    );
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }
}
