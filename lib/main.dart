import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vlocks/adminHome.dart';
import 'package:vlocks/layouts/home-layout.dart';
import 'package:vlocks/models/categoriesModel.dart';
import 'package:vlocks/shared/variables/variables.dart';
import 'modules/home.dart';
import 'modules/login-screen.dart';
import 'modules/profile.dart';
import 'network/cacheHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  User? UserData = await FirebaseAuth.instance.currentUser;
  var widget;


   //CacheHelper.clear('subList');
   //CacheHelper.putList(key: 'subList',value: subItems);
    subItems=CacheHelper.getList(key: 'subList')?? [
      'Accessories',
      'Bags & Cases',
      'Sony MDR-7506',
      'Gopro & action  camera’s',
      'Fabric softener',
      'Liquid',
      'Pods',
      'Powder',
    ];
    print('kkkkkk');
    print(subItems.length);


  // var token= CacheHelper.getData(key:'token');
  uId = CacheHelper.getData(key: 'uId');
  print('uId');
  print(uId);

  //getUser(storage);

   if (uId != null) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    uId = user?.uid;
    print(uId);

    if (uId == 'PAy7zp8EImX8kF7GsVJ3yl6USzN2') {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      uId = user?.uid;
      print(uId);

      getUser(storage, uId!);
      print('userImage');
      print(userImage);
      widget =  admin();

    }else{

      getUser(storage, uId!);
      print('userImage');
      print(userImage);
      widget =  Home();

    }



  }
  else {
    widget = login();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key, required Widget this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: startWidget,
      // ignore: deprecated_member_use
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backwardsCompatibility: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light))),
      debugShowCheckedModeBanner: false,
    );
  }
}

void getUserData() {
  FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
    print(value.data());
  }).catchError((onError) {
    print(onError);
  });
}

getCategories(FirebaseFirestore storage) async {
  try {
    var results = await storage
        .collection('categories')
        .doc('5lE137xgBiP3m7hsTdtj')
        .get();
    categoryStatus = categoriesModel_class.fromJson(results).status;
    categoryName = categoriesModel_class.fromJson(results).categoryName;
    categoryImage = categoriesModel_class.fromJson(results).url;
  } catch (e) {
    print(e);
  }
}
