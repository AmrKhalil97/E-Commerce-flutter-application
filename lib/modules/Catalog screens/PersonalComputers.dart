import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/components/components.dart';
import '../../shared/variables/variables.dart';
import '../catalog.dart';
import '../home.dart';
import '../notifications.dart';
import '../profile.dart';
import '../vlocks.dart';

class PersonalComputers extends StatefulWidget {
  String title;

  PersonalComputers({required String this.title});

  @override
  State<PersonalComputers> createState() => _catalogScreenState();
}

class _catalogScreenState extends State<PersonalComputers> {
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
      bottomNavigationBar: Container(
        height: 63.2,
        child: Wrap(
          children: [
            BottomNavigationBar(
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
      body: searchScreen
          ? SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 900,
                          child: GridView.custom(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 2),
                              childrenDelegate: SliverChildListDelegate([

                                // buildCatalogSubItem(
                                //     context: context,
                                //     title: 'Bags & Cases',
                                //     price: '50',
                                //     url:
                                //     'https://www.figma.com/file/w8K6eoqcjSlTLKVcR5tzSy/image/7343da7ebda0b8ae04a73b78c654a3b25942322e?fuid=965558088867929695'),
                              ])),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
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
