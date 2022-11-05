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
import 'package:vlocks/models/userModel.dart';
import 'package:vlocks/modules/signUp-screen.dart';
import 'package:vlocks/shared/components/components.dart';
import '../layouts/home-layout.dart';
import '../modules/profile.dart';
import '../network/cacheHelper.dart';
import '../shared/variables/variables.dart';

class editProduct extends StatefulWidget {
  int productSize=0;
  @override
  _loginState createState() => _loginState();

  late String productName;
  late String productID;
  late double endPointPrice;
  late double catalogPrice;
  late String description;
  late String specification;
  late double vlockPrice;

  editProduct({
    required this.productName,
    required this.productID,
    required this.endPointPrice,
    required this.catalogPrice,
    required this.description,
    required this.specification,
    required this.vlockPrice,
  });
}

class _loginState extends State<editProduct> {
  var tcVisibility = false;
  String url='';
  String status='On-Demand';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('kkkkkk');
    print(subItems.length);
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

  String category='Baby products';
  String image='';
  String name='';
  int price=0;
  String subCategory='Accessories';
  int size=0;
  String specifications='';

  String dropdownvalue = 'Baby products';


  var nameController = TextEditingController();

  var priceController = TextEditingController();
  var endPointPriceController = TextEditingController();

  var sizeController = TextEditingController();

  var specController = TextEditingController();
  var vlockPriceController = TextEditingController();
  var vlockPrice = TextEditingController();

  var descController=TextEditingController();

  String dropdownvalue2 = 'Accessories';
  String dropdownvalue3 = 'On-Demand';

  String? selectedItem2='Pods';
  String? selectedItem3='Baby products';

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
      final  ref =await FirebaseStorage.instance.ref().child('onDemand product images').child('${i}'+'.jpg'); print('2');



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
        title: Text(widget.productName,style: TextStyle(
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
                      SizedBox(height: 10,),
                      defaultTextField(
                        TextEditingController: nameController,
                        textValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        labelText: 'Product name is ${widget.productName}',
                        type: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                        TextEditingController: priceController,
                        textValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        labelText: 'Product catalog Price is ${widget.catalogPrice}',
                        type: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                        TextEditingController: endPointPriceController,
                        textValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        labelText: 'Product end point price is ${widget.endPointPrice}',
                        type: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                        TextEditingController: vlockPrice,
                        textValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        labelText: 'Current vlock price is ${widget.vlockPrice}',
                        type: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                        TextEditingController: specController,
                        textValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        labelText: 'Product Specifications',
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
                        labelText: 'Product Description',
                        type: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      registerButton(
                          fun:
                              () async {
                            print(url);
                            if (formKey.currentState!.validate()) {

                              final post = await FirebaseFirestore.instance
                                  .collection('product')
                                  .where('productID', isEqualTo: widget.productID)
                                  .get()
                                  .then((QuerySnapshot snapshot) {
                                //Here we get the document reference and return to the post variable.
                                return snapshot.docs[0].reference;
                              });


                              var batch =await FirebaseFirestore.instance.batch();
                              //Updates the field value, using post as document reference
                              batch.update(post, { 'name': nameController.text});
                              batch.update(post, { 'price': double.parse(priceController.text)});
                              batch.update(post, { 'endPointPrice': double.parse(endPointPriceController.text)});
                              batch.update(post, { 'vlockPrice': double.parse(vlockPrice.text)});
                              batch.update(post, { 'specifications': specController.text});
                              batch.update(post, { 'description': descController.text});
                              batch.commit();

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Product modified successfully"),
                              ));
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  admin()),
                              );
                            }
                          },
                          color: Color(0XFF800080),
                          text: 'Modify'),
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
