import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vlocks/models/notificationsModel.dart';
import 'package:vlocks/models/postModel.dart';
import 'package:vlocks/modules/checkout-screen.dart';
import 'package:vlocks/modules/createVlockCheckout.dart';
import 'package:vlocks/modules/subscriptionCheckout.dart';
import '../../layouts/home-layout.dart';
import '../../network/cacheHelper.dart';
import '../../shared/variables/variables.dart';
import '../catalog.dart';
import '../customRadioButton.dart';
import '../home.dart';
import '../notifications.dart';
import '../profile.dart';
import '../vlocks.dart';
import 'dart:math';

class createVlockScreen extends StatefulWidget {


  @override
  State<createVlockScreen> createState() => _createVlockScreenState();
  late double currentPrice;
  late double endPointPrice;
  late double catalogPrice;
  late int currentVlockSize;
  late int actualVlockSize;

  late String name;


  createVlockScreen({
     required this.currentPrice,
     required this.name,
     required this.endPointPrice,
     required this.catalogPrice,
  });
}

class _createVlockScreenState extends State<createVlockScreen> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
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

int tier1=100;
int tier2=200;
int tier3=300;
int tier4=400;
String random=i.toString();
int selectedTier=0;

double price=304;

  File? _pickedImage;
   String url='';

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      final pickedImageFile = File(pickedImage!.path);
      final  ref =await FirebaseStorage.instance.ref().child('posts images').child('${i}'+'.jpg'); print('2');

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

void _pickVideoGallery() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if(pickedImage!=null){
    final pickedImageFile = File(pickedImage!.path);

    setState(() {
      _pickedImage = pickedImageFile;

    });


    print(url);
  }print('no image');
}


  int _value = 0;
  int _value2=1;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var descriptionController = TextEditingController();
  var urlController = TextEditingController();

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
      resizeToAvoidBottomInset: false,
backgroundColor: Colors.white,
      body: searchScreen ?

      Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 25),
                  child: Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset('lib/images/back.svg',width: 32,),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        'Create New Vlock',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,overflow: TextOverflow.clip
                        ),
                      ),
                    ],
                  ),

                ),
                SizedBox(height: 10,),

                Container(width: double.infinity,
                  height: 1,
                  color: Colors.black.withOpacity(0.2),),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Product',
                          style: TextStyle(
                              fontSize: 12,

                              fontFamily: 'Raleway',
                              fontWeight:
                              FontWeight.bold,
                              color: Colors.black.withOpacity(0.4)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 20,

                              fontFamily: 'Raleway',
                              fontWeight:
                              FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Catalog price €${widget.currentPrice}.00',
                          style: TextStyle(
                              fontSize: 16,

                              fontFamily: 'Raleway',
                              fontWeight:
                              FontWeight.bold,
                              color:Color(0xff800080)),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Color(0xff800080).withOpacity(0.1),
                          borderRadius:  BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20),
                            dashPattern: [10, 5],
                            color: Color(0xff800080).withOpacity(0.4),
                            strokeWidth: 2,
                            child:
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('lib/images/attach.svg',width:60 ,),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Upload product'),
                                      SizedBox(width: 5,),
                                      GestureDetector(
                                          onTap: () => _pickImageGallery(),
                                          child: Text('Photo',style: TextStyle(color: Colors.blue),)),
                                      SizedBox(width: 5,),
                                      Text('or'),
                                      SizedBox(width: 5,),
                                      GestureDetector(
                                          onTap: () => _pickVideoGallery(),
                                          child: Text('Video',style: TextStyle(color: Colors.blue),)),
                                    ],
                                  ),
                                ],
                              ),
                            )

                        ),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Choose Vlock Size',
                          style: TextStyle(
                              fontSize: 16,

                              fontFamily: 'Raleway',
                              fontWeight:
                              FontWeight.bold,
                              color:Colors.black),
                        ),
                      ),
                      SizedBox(height: 10,),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Container(
                    color: Colors.white,
                    height: 90,
                    width: double.infinity,
                    child: GridView.custom(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 8),
                      childrenDelegate: SliverChildListDelegate(
                        [
                          MyRadioListTile<int>(
                                value: 1,
                                groupValue: _value,
                                leading: '${tier1} Pcs',
                                title: '€${((widget.currentPrice)-(widget.currentPrice*0.08)).toStringAsFixed(2)}',
                                onChanged: (newValue) => setState(() {
                                  _value = newValue!;
                                  price=((widget.currentPrice)-(widget.currentPrice*0.08)).roundToDouble();
                                  selectedTier=tier1;
                                }),
                              ),
                          MyRadioListTile<int>(
                                value: 2,
                                groupValue: _value,
                                leading: '${tier2} Pcs',
                                title: '€${((widget.currentPrice)-(widget.currentPrice*0.12)).toStringAsFixed(2)}',
                                onChanged: (newValue) =>  setState(() {
                                  _value = newValue!;
                                  selectedTier=tier2;
                                  price=(widget.currentPrice)-(widget.currentPrice*0.12);
                                  print(price);
                                }),
                              ),
                          MyRadioListTile<int>(
                                value: 3,
                                groupValue: _value,
                                leading: '${tier3} Pcs',
                                title: '€${((widget.currentPrice)-(widget.currentPrice*0.14)).toStringAsFixed(2)}',
                                onChanged: (newValue) => setState(() {
                                  _value = newValue!;
                                  selectedTier=tier3;
                                  price=(widget.currentPrice)-(widget.currentPrice*0.14);
                                  print(price);
                                }),
                              ),
                          MyRadioListTile<int>(
                                value: 4,
                                groupValue: _value,
                                leading: '${tier4} Pcs',
                                title: '€${((widget.currentPrice)-(widget.currentPrice*0.18)).toStringAsFixed(2)}',
                                onChanged: (newValue) => setState(() {
                                  _value = newValue!;

                                  selectedTier=tier4;
                                  price=(widget.currentPrice)-(widget.currentPrice*0.18);
                                  print(price);
                                  print(price);
                                }),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                          fontWeight:
                          FontWeight.bold,
                          color:Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: descriptionController,

                        validator: (value){
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            errorStyle: TextStyle(height: 0,fontWeight: FontWeight.w300),
                            contentPadding: EdgeInsets.only(top: 20), // add padding to adjust text
                            isDense: true,
                            hintText: 'Enter description here',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14
                            )
                        ),),
                    ),

                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,bottom: 60),
                  child: ButtonTheme(
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed:
                            () async {
while(-_value!=0 && descriptionController.text != ''){
  if (formKey.currentState!.validate()) {
    print('1');


    print('url'); print('5');
    print(url); print('6');


    final docPost=await FirebaseFirestore.instance.collection('posts'); print('7');

    postModel_class model= postModel_class(
      startPointPrice: price,
        endPointPrice:widget.endPointPrice ,
        avatar: userImage!,
        publisherName: userName,
        publisherID: uId!,
        description: descriptionController.text,
        itemName: widget.name,
        price: price,
        vlockSize: selectedTier,
        vlockCurrentSize:selectedTier,
        currentSize: 1,
        image: url??'https://www.lovelearnings.com/wp-content/uploads/2020/05/no-posts-yet-705x352.png',
        publisherFollower: followers,
        postID: uId!.substring(5)+i.toString(),
        count: 0,
        catalogPrice:widget.catalogPrice
    ); print('8');

    var   parts=userName.split(' ');
    var prefix=parts[0].trim();
    final docpost2=await FirebaseFirestore.instance.collection('notifications'); print('9');

    notificationsModel_class model2= notificationsModel_class(
        title: '${prefix} has started a new Vlock',
        userImage: userImage!
    ); print('10');


    docPost.add(model.toMap()); print('11');
    docpost2.add(model2.toMap()); print('12');


    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  createVlockCheckout()
    ));
      print('13');

  };
}
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  content: Text("Fill all the fields please!"),
));
                          }
                        ,

                        child: Text(
                          'Create Vlock',
                          style: TextStyle(
                              fontSize: 12,

                              fontFamily: 'Raleway',
                              fontWeight:
                              FontWeight.bold,
                              color: Colors.white),
                        ),

                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xff800080
                          )),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),

                        ),),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      )

          : screen[_selectedScreenIndex]
      ,
    )
    ;  }

  // void _pickImageGallery() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //   final pickedImageFile = File(pickedImage!.path);
  //   setState(() {
  //     _pickedImage = pickedImageFile;
  //   });
  //
  // }
}
