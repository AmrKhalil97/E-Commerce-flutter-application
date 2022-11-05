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

class addProduct extends StatefulWidget {
  int productSize=0;
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<addProduct> {
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
        title: Text('Add Product',style: TextStyle(
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
                          Text(
                            'Status',style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          ),),
SizedBox(width: 20,),
                          DropdownButton(
                            // Initial Value
                            value: dropdownvalue3,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: statusList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items,style: TextStyle(
                                  fontSize: 12
                                ),),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue3 = newValue!;
                                status=dropdownvalue3!;
                                if(status=='Subscription'){
                                  tcVisibility=true;
                                }else{
                                  tcVisibility=false;
                                }


                                print(category);
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Visibility(
                        visible: tcVisibility,
                        child:
                        defaultTextField(
                          TextEditingController: vlockPriceController,
                          labelText: 'Vlock price',
                          type: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('Category',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(width: 20,),
                          DropdownButton(
                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: allItems.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items,style: TextStyle(
                                    fontSize: 12
                                ),),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                                category=dropdownvalue!;
                                print(category);
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('Sub Category',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(width: 20,),
                          DropdownButton(

                            // Initial Value
                            value: dropdownvalue2,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: subItems?.map((String subItems) {
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
                          Text('Add Product Image',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
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
                          labelText: 'Product Name',
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
                          labelText: 'Product Price',
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
                        labelText: 'Product end point price',
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
AnimatedTextKit(
    animatedTexts: [
  TypewriterAnimatedText('Product ID will be auto generated')
]),
                      SizedBox(
                        height: 20,
                      ),
                      registerButton(
                          fun:
                          () async {
print(url);
    if (formKey.currentState!.validate()) {


      final post = await FirebaseFirestore.instance
          .collection('subCategory')
          .where('subcategory', isEqualTo: subCategory)
          .get()
          .then((QuerySnapshot snapshot) {
        //Here we get the document reference and return to the post variable.
        return snapshot.docs[0].reference;
      });


      var batch =await FirebaseFirestore.instance.batch();
      //Updates the field value, using post as document reference
      batch.update(post, { 'products': FieldValue.increment(1)});
      batch.commit();

      final docPost=await FirebaseFirestore.instance.collection('product');
      productModel_class model= productModel_class(
          id: i.toString(),
          price:double.parse(priceController.text),
          endPointPrice:double.parse(endPointPriceController.text),
          name: nameController.text,
          description: descController.text,
          productSubcategory:subCategory,
          specifications: specController.text,
          image: url!,
          category: category,
          status: status,
          size:0,
          vlockPrice: vlockPriceController.text == '' ?0.3 :  double.parse(vlockPriceController.text)
      );



      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

      docPost.add(model.toMap());

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
        content: Text("You added a new product successfully"),
      ));
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  admin()),
      );
    }



        },
                          color: Color(0XFF800080),
                          text: 'Create'),
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
