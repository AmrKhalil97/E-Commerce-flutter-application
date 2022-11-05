import 'dart:io';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vlocks/adminHome.dart';
import 'package:vlocks/models/brandModel.dart';
import 'package:vlocks/models/subcategoryModel.dart';
import 'package:vlocks/models/userModel.dart';
import 'package:vlocks/modules/signUp-screen.dart';
import 'package:vlocks/shared/components/components.dart';
import '../layouts/home-layout.dart';
import '../modules/profile.dart';
import '../network/cacheHelper.dart';
import '../shared/variables/variables.dart';

class addSubcategory extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<addSubcategory> {

  String url='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CacheHelper.putDouble(
        key: 'index', value: i);
    i=CacheHelper.getDouble(key: 'index')!;
    CacheHelper.putList(key: 'subList',value: subItems);
    Random random=new Random();
    i=random.nextInt(1000)/314.0;

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    uId = user?.uid??'XsAmI4BR8tDNJDGNTbJR';
    print(uId);

    getUser(storage, uId!);
  }

  String category='Baby products';
  String image='Baby products';
  String name='Baby products';
  int price=0;
  String subCategory='Baby products';
  int size=0;
  String specifications='Baby products';
  var nameController = TextEditingController();

  var priceController = TextEditingController();
  var endPointPriceController = TextEditingController();

  var sizeController = TextEditingController();

  var specController = TextEditingController();

  var descController=TextEditingController();

  String dropdownvalue2 = 'Baby products';



  String username = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  bool pass = true;
  bool isEmailVerified = false;
  bool isEmailSent = false;
  double opacity = 0.3;
  File? _pickedImage;

  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      final pickedImageFile = File(pickedImage!.path);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(
      //   content: Text("You've picked an image"),
      // ));
      final  ref =await FirebaseStorage.instance.ref().child('subcategory images').child('${i}'+'.jpg'); print('2');



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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,

        centerTitle: true,
        title: Text('Add subcategory',style: TextStyle(
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
                          Text('Select category',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(width: 10,),
                          DropdownButton(

                            // Initial Value
                            value: dropdownvalue2,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: allItems.map((String subItems) {
                              return DropdownMenuItem(
                                value: subItems,
                                child: Text(subItems
                                  ,style: TextStyle(
                                      fontSize: 12
                                  ),),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue2 = newValue!;
                                subCategory=dropdownvalue2!;
                                print(subCategory);
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('Add subcategory Image',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(width: 30,),
                          IconButton(
                              onPressed:()async {
                                _pickImageGallery();
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
                          labelText: 'Subcategory Name',
                          type: TextInputType.text),

                      SizedBox(
                        height: 20,
                      ),
                      registerButton(
                          fun:
                              () async {

                            print('urllllll');
                            print(url);
                            if (formKey.currentState!.validate()) {


if(CacheHelper.getList(key: 'subList')!.contains(nameController.text)){
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
    content: Text("This subcategory already exists"),
  ));
}
else{
  subItems?.add(nameController.text);
  CacheHelper.sharedPreferences.setStringList('subList', subItems!);

  CacheHelper.putList(key: 'subList', value: subItems!);
  final docPost=await FirebaseFirestore.instance.collection('subCategory');
  subcategoryModel_class model= subcategoryModel_class(
      image: url,
      category: subCategory,
      subcategory:nameController.text
  );
  docPost.add(model.toMap());
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
    content: Text("You added a new subcategory successfully"),
  ));
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  admin()),
  );
}

                            }
                          },
                          color: Color(0XFF800080),
                          text: 'Create'),
                    ],
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
