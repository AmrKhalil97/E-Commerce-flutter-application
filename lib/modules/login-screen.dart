import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:vlocks/models/userModel.dart';
import 'package:vlocks/modules/signUp-screen.dart';
import 'package:vlocks/shared/components/components.dart';
import 'package:vlocks/shared/variables/variables.dart';
import '../adminHome.dart';
import '../layouts/home-layout.dart';
import '../network/cacheHelper.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  String username = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  bool pass = true;
  bool isEmailVerified = false;
  bool isEmailSent = false;
  double opacity = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => signUp(),
                  )),
              child: Text(
                'Sign up',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ))
        ],
        centerTitle: true,
        title: SvgPicture.asset(
          'lib/images/logo2.svg',

          width: 80,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log in to Vlocks',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),

              Column(children: [
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: TextButton(
                    onPressed: () async {
                      await signInWithGoogle();

                      final user = FirebaseAuth.instance.currentUser;
                       userModel_class model = await userModel_class(
                          email: user?.email,
                          name: user?.displayName,
                          phone: '0000000',
                          uId: user!.uid,
                          isEmailVerified: isEmailVerified,
                          image: user!.photoURL!,
                          followers: 0);
                      //
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.uid)
                          .set(model.toMap());

                      await CacheHelper.putData(
                          key: 'uId', value: user!.uid).then((value) {
                        print('xxxxxxx');
                        CacheHelper.putData(
                            key: 'userImage', value: user!.photoURL!).then((value) {
                          print('xxxxxxx');

                        });

                      });

                      setState(() {

                        uId=CacheHelper.getData(key: 'uId');
                        userImage=CacheHelper.getData(key: 'userImage')!;
                        print('userImage');
                        print(userImage);
                        print(userImage);
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },

                    child: Row(
                      children: [
                        SvgPicture.asset('lib/images/google.svg', width: 20),
                        SizedBox(
                          width: 70,
                        ),
                        Text(
                          'Continue with Google',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    // textColor: Colors.black,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: TextButton(
                    onPressed:() => 0,

                    child: Row(
                      children: [
                        SvgPicture.asset('lib/images/apple.svg', width: 20),
                        SizedBox(
                          width: 70,
                        ),
                        Text(
                          'Continue with Apple',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    // textColor: Colors.black,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'OR',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Container(width: 120, height: 1, color: Colors.grey)
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextField(
                        TextEditingController: emailController,
                        textValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        labelText: 'Email',
                        type: TextInputType.emailAddress),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextField(
                        TextEditingController: passwordController,
                        textValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        labelText: 'Password',
                        suffix: pass ? Icons.visibility_off : Icons.visibility,
                        password: pass,
                        type: TextInputType.visiblePassword,
                        obsecureButton: () {
                          setState(() {
                            pass = !pass;
                          });
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    registerButton(
                        fun: () async{

                          if (formKey.currentState!.validate()) {
                            await FirebaseAuth.
                            instance.
                            signInWithEmailAndPassword(
                                email:emailController.text,
                                password:  passwordController.text);

                            final user  =FirebaseAuth.instance.currentUser;

                            await CacheHelper.putData(
                                key: 'uId', value: user!.uid).then((value)  {
                              print('xxxxxxx');
                              CacheHelper.putData(
                                  key: 'userImage', value: user.photoURL ?? 'https://firebasestorage.googleapis.com/v0/b/vlocks-680cb.appspot.com/o/profile.png?alt=media&token=68df186a-b8af-475f-b1a0-1232f1f9ea5e').then((value) {
                                print('xxxxxxx');

                              });

                            });

                            setState(() {

                              uId=CacheHelper.getData(key: 'uId');
                              userImage=CacheHelper.getData(key: 'userImage')!;
                              print('userImage');
                              print(userImage);
                              print(userImage);
                            });

                            if(uId == 'PAy7zp8EImX8kF7GsVJ3yl6USzN2'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => admin()),
                              );
                            }
                            else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()),
                              );}
                                  }



                              //   FirebaseAuth.instance
                              //   .signInWithEmailAndPassword(
                              //   email: emailController.text,
                              //   password: passwordController.text)
                              //   .then((value) async{
                              //     final user = FirebaseAuth.instance.currentUser;
                              //     await CacheHelper.putData(
                              //     key: 'uId', value: value.user!.uid).then((value) {
                              //       print('added user ID');
                              //       CacheHelper.putData(key: 'userImage', value:  user!.photoURL!);
                              // });
                              //
                              //
                              // setState(() {
                              //   uId=CacheHelper.getData(key: 'uId');
                              //   userImage=CacheHelper.getData(key: 'userImage');
                              //   print('userImage');
                              //   print(userImage);
                              //   print(userImage);
                              // });
                              // if(uId == 'PAy7zp8EImX8kF7GsVJ3yl6USzN2'){
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => admin()),
                              //   );
                              // }
                              // else{
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Home()),
                              //   );}
                                //}
                            //);

                          return null;
                        },
                        color: Color(0XFF800080),
                        text: 'Log in'),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Visibility(
                visible: isEmailSent,
                child: TextFormField(
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Hint here"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential authResult =
        await _auth.signInWithCredential(authCredential);
    User user = await _auth.currentUser!;
    print('user email = ${user.email}');
  }
}
