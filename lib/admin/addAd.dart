import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vlocks/models/adModel.dart';
import 'package:vlocks/models/brandModel.dart';
import 'package:vlocks/models/userModel.dart';
import 'package:vlocks/modules/signUp-screen.dart';
import 'package:vlocks/shared/components/components.dart';
import '../adminHome.dart';
import '../layouts/home-layout.dart';
import '../modules/profile.dart';
import '../network/cacheHelper.dart';
import '../shared/variables/variables.dart';

class addAd extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<addAd> {
  String? url2;
  String? url;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CacheHelper.putList(key: 'subList',value: subItems);
    CacheHelper.putDouble(
        key: 'index', value: i);
    i=CacheHelper.getDouble(key: 'index')!;
    Random random=new Random();
    i=random.nextInt(1000)/314.0;

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    uId = user?.uid??'XsAmI4BR8tDNJDGNTbJR';
    print(uId);

    getUser(storage, uId!);
  }

  var nameController = TextEditingController();

  var priceController = TextEditingController();

  var sizeController = TextEditingController();

  var specController = TextEditingController();

  var descController=TextEditingController();


  String username = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var emailController = TextEditingController();var titleController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  bool pass = true;
  bool isEmailVerified = false;
  bool isEmailSent = false;
  double opacity = 0.3;
  File? _pickedImage;
  File? _pickedImage2;

  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();


  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      final pickedImageFile = File(pickedImage!.path);
      final  ref =await FirebaseStorage.instance.ref().child("ad's images").child('${i}'+'.jpg'); print('2');



      setState(() async {
        _pickedImage = pickedImageFile;
        await ref.putFile(_pickedImage!); print('3');
        url=await ref.getDownloadURL(); print('4');
      });

      print('url');
      print(url);



      print(url);
    }print('no image');
  }

  void _pickImageGallery2() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      final pickedImageFile = File(pickedImage!.path);
      final  ref =await FirebaseStorage.instance.ref().child("ad's images").child('${i*12}'+'.jpg'); print('2');



      setState(() async {
        _pickedImage2 = pickedImageFile;
        await ref.putFile(_pickedImage2!); print('3');
        url2=await ref.getDownloadURL(); print('4');
      });

      print('url');
      print(url);



      print(url);
    }print('no image');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,

        centerTitle: true,
        title: Text('Create new Ad',style: TextStyle(
            color: Colors.black
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Form(
                  key: formKey,
                  child: Column(
                    children: [

                      Row(
                        children: [
                          Text("Ad's background Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(width: 30,),
                          IconButton(
                              onPressed:()async {
                                _pickImageGallery();
                              },
                              icon: Icon(Icons.add_a_photo))
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text("Ad's product Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(width: 30,),
                          IconButton(
                              onPressed:()async {
                                _pickImageGallery2();
                              },
                              icon: Icon(Icons.add_a_photo))
                        ],
                      ),
                      SizedBox(height: 10,),
                      defaultTextField(
                          TextEditingController: nameController,
                          textValidator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          labelText: 'Product name',
                          type: TextInputType.text),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                        TextEditingController: titleController,
                        textValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        labelText: 'Product title',
                        type: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                        TextEditingController: descController,
                        textValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        labelText: 'Product description',
                        type: TextInputType.text,
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      registerButton(
                          fun:
                              () async {

    if (formKey.currentState!.validate()) {
      final docPost=await FirebaseFirestore.instance.collection('ads');
      adModel_class model= adModel_class(
          title: nameController.text,
          image2: url2!,
          subTitle: titleController.text,
          description:descController.text ,
          image:url!
      );
      docPost.add(model.toMap());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
        content: Text("You've added a new ad successfully"),
      ));

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  admin()),
      );

    }

                          },
                          color: Color(0XFF800080),
                          text: 'REGISTER'),
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
      ),
    );
  }
}
