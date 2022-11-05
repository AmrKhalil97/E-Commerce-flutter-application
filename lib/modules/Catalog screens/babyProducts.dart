import 'package:cloud_firestore/cloud_firestore.dart';
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

class babyProducts extends StatefulWidget {
  String title;

  babyProducts({required String this.title});

  @override
  State<babyProducts> createState() => _catalogScreenState();
}

class _catalogScreenState extends State<babyProducts> {
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
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
              stream: FirebaseFirestore.instance.collection('subCategory').where('category',isEqualTo: 'Baby products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 2),
                        itemBuilder: (context, index) {
                          //return
                          //Text('${snapshot.data!.docs[index].get('categoryName')}');
                          return
                            buildCatalogSubItem(
                                size:  snapshot.data!.docs[index].get('products'),
                                subCategory:  snapshot.data!.docs[index].get('subcategory'),
                                url: snapshot.data!.docs[index].get('image'),
                                context: context);
                        },),
                    );
                }
                if (snapshot.hasError) {
                  return const Text('Error');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )

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
