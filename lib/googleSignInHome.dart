// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class googleHome extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//    return
//        Scaffold(
//          body: StreamBuilder(
//              stream: FirebaseAuth.instance.authStateChanges(),
//              builder: (context, snapshot) {
//                if(snapshot.connectionState==ConnectionState.waiting)
//                  return Center(child: CircularProgressIndicator(),);
//                else {return SignUpWidget();}
//              },
//          ),
//        );
//   }
//
// }