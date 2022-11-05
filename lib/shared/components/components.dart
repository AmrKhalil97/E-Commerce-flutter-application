// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlocks/modules/Catalog%20screens/brand-screen.dart';
import 'package:vlocks/modules/Catalog%20screens/catalogItem-screen.dart';
import 'package:vlocks/modules/Catalog%20screens/products-screen.dart';
import 'package:vlocks/modules/checkout-screen.dart';
import 'package:vlocks/shared/variables/variables.dart';

import '../../layouts/home-layout.dart';

import '../../modules/Catalog screens/CameraPhoto.dart';
import '../../modules/Catalog screens/Detergent.dart';
import '../../modules/Catalog screens/OfficeSupplies.dart';
import '../../modules/Catalog screens/PersonalCare.dart';
import '../../modules/Catalog screens/PersonalComputers.dart';
import '../../modules/Catalog screens/PreparedMeals.dart';
import '../../modules/Catalog screens/Toiletries.dart';

import '../../modules/Catalog screens/babyProducts.dart';
import '../../modules/Catalog screens/product-screen.dart';
import '../../modules/customRadioButton.dart';
Widget buildCatalogTabBar() {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Center(
      child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            height: 48,
            width: 335,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFFFFFFFF).withOpacity(0.3)),
            child: DefaultTabController(
              length: 3,
              child: TabBar(
                labelStyle:
                    TextStyle(fontSize: 12.3, fontWeight: FontWeight.w600),
                unselectedLabelColor: Color(
                  0xFF748B9B,
                ),
                labelColor: Color(0xFF800080),
                // ignore: unnecessary_const
                tabs: [
                  new Container(
                    width: double.infinity,
                    child: new Tab(
                      text: 'On-Demand',
                    ),
                  ),
                  new Container(
                    width: double.infinity,
                    child: new Tab(text: 'Subscription'),
                  ),
                  new Container(
                    width: double.infinity,
                    child: new Tab(text: 'Services'),
                  ),
                ],

                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          )),
    ),
  );
}

Widget buildSearchItem(
    {required String url,
    context,
    required String title,
    required int price}) {
  return Stack(
    children: [
      Positioned.fill(
        child: Container(
          width: 128,
          height: 168,
          decoration: BoxDecoration(
            color: Color(0XFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 0.1,
                offset: Offset(0, 0.5), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '${url}',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                    // ignore: prefer_const_constructors,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${title}',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Raleway',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Text(
                        'Catalog Price:€ 240,-',
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF800080)),
                      ),
                      Text(
                        '${price},-',
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF800080)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      Align(
          alignment: Alignment.topRight,
          child: SvgPicture.asset('lib/images/like.svg', width: 60)),
    ],
  );
}

Widget buildCatalogSubItem(
    {required String url,
    context,
    required String subCategory,
    required int size})
{
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => productsScreen(text: subCategory,status: 'On-Demand',)),
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: Container(
            width: 128,
            height: 168,
            decoration: BoxDecoration(
              color: Color(0XFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 0.9,
                  offset: Offset(0, 0.5), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),

                          child: CachedNetworkImage(
                            imageUrl: '${url}',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${subCategory}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,

                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${size}",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF800080)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'products',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF800080)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildUserProfileInfo(
        {required String imageUrl,
        required String name,
        required double radius,
        required int followers}) =>
    Padding(
      padding: const EdgeInsets.only(left: 0,right: 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.0),
            ),
          color: Colors.white,

        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CircleAvatar(
                  radius: radius,
                  backgroundImage: NetworkImage(imageUrl),
                  backgroundColor: Colors.transparent,
                ),
              ),
              // NetworkImage(imageUrl: imageUrl),
              // SvgPicture.asset('lib/images/avatar.svg', width: 80),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Follow',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${followers} followers',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'invite/invitations',
                    style: TextStyle(
                      color: Color(0XFFAFAFAF),
                      fontSize: 14,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

Widget buildProfileInfo(
    {required String imageUrl,
      required String name,
      required double radius,
      required int followers}) =>
    Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.0),
            ),

            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              CircleAvatar(
                radius: radius,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.transparent,
              ),
              // NetworkImage(imageUrl: imageUrl),
              // SvgPicture.asset('lib/images/avatar.svg', width: 80),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${followers} followers',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'invite/invitations',
                    style: TextStyle(
                      color: Color(0XFFAFAFAF),
                      fontSize: 14,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

Widget buildProfileFunc(
        {void Function()? onTap,
        required String text,
        required Widget image}) =>
    GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () => 0,
            child: SizedBox.fromSize(
              child: Container(
                width: 335,
                height: 45,
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables

                  children: [
                    image,
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        color: Color(0XFF000000),
                        fontSize: 16,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                        size: 20, color: Color(0XFF748B9B))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

Widget buildCatalogItem({context, required String url, required String title}) {
  return GestureDetector(
    onTap:  ()
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraPhoto(
              title: title,
            ),
          ),
        );
      //   title == "Baby products" ?
      // Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => catalogScreen(
      //           title: title,
      //         ),
      //       ),
      // );
      },
    child: Column(
      children: [
        Expanded(
          child: Container(
              width: 300.0,
              height: 120.0,

              child: Center(
                child: Container(
                  width: 300.0,
                  height: 200.0,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),

                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,

                      imageUrl: url,
                      //placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(
            color: Color(0XFF000000),
            fontSize: 10,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget buildProductItem(
        {void Function()? onPressed,
        context,
        required String image,
        required String productName,
        required double prize}) =>
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () => 0,
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      color: Color(0XFF000000),
                      fontSize: 14,
                      fontFamily: 'Raleway',
                      overflow: TextOverflow.fade,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Catalog Prize',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '€ $prize',
                        style: TextStyle(
                          color: Color(0xFF7F007F),
                          fontSize: 12,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  OutlinedButton(
                    onPressed: onPressed
                    //     () {
                    //   selectedProduct = productName;
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => brandScreen()),
                    //   );
                    // },
                    ,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color>(
                              (states) {
                        return Color(0xFF7F007F).withOpacity(0.2);
                      }),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                    child: const Text("View Product"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );

Widget buildServiceItem(
    {void Function()? onPressed,
      context,
      required String image,
      required String productName,
      required double prize}) =>
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () => 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Wrap(
              spacing: 15,
              alignment: WrapAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                        color: Color(0XFF000000),
                        fontSize: 14,
                        fontFamily: 'Raleway',
                        overflow: TextOverflow.fade,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Catalog Prize',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '€ $prize',
                          style: TextStyle(
                            color: Color(0xFF7F007F),
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    OutlinedButton(
                      onPressed: onPressed
                      //     () {
                      //   selectedProduct = productName;
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => brandScreen()),
                      //   );
                      // },
                      ,
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                                (states) {
                              return Color(0xFF7F007F).withOpacity(0.2);
                            }),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                      ),
                      child: const Text("View Product"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget buildSubscriptionItem(
    {void Function()? onPressed,
      context,
      required String image,
      required String productName,
      required double prize}) =>
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () => 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Wrap(
              spacing: 15,
              alignment: WrapAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                        color: Color(0XFF000000),
                        fontSize: 14,
                        fontFamily: 'Raleway',
                        overflow: TextOverflow.fade,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Catalog Prize',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '€ $prize',
                          style: TextStyle(
                            color: Color(0xFF7F007F),
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    OutlinedButton(
                      onPressed: onPressed
                      //     () {
                      //   selectedProduct = productName;
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => brandScreen()),
                      //   );
                      // },
                      ,
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                                (states) {
                              return Color(0xFF7F007F).withOpacity(0.2);
                            }),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                      ),
                      child: const Text("Join"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );


Widget modifyProductItem(
    {void Function()? onPressed,
      context,
      required String image,
      required String productName,
      required double prize}) =>
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),

        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () => 0,
          child: SizedBox.fromSize(
            child: Container(
              width: 335,
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),

                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: image,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: TextStyle(
                            color: Color(0XFF000000),
                            fontSize: 14,
                            fontFamily: 'Raleway',
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Catalog Prize',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '€ $prize',
                              style: TextStyle(
                                color: Color(0xFF7F007F),
                                fontSize: 12,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        OutlinedButton(
                          onPressed: onPressed,
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                  return Color(0xFF7F007F).withOpacity(0.2);
                                }),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          child: const Text("Delete Product"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

Widget modifyOrdersItem(
    {void Function()? onPressed,
      context,
      required int size,
      required int currentVlockSize,
      required int actualVlockSize,
      required String productName,
      required double startPointPrice,
      required double endPointPrice,
      required double currentVlockPrice,
      required double catalogPrice,
      required String shippingTo,
      required String selectPaymentMethod,
      required String deliveryPeriod,
    required String seller,
    required String orderID,
    required String buyer}) =>
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () => 0,
          child: SizedBox.fromSize(
            child: Container(
              width: 335,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Order ID:',
                            style: TextStyle(
                              color: Color(0XFF000000),
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            '${orderID}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Seller: ${seller}',
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 14,
                          fontFamily: 'Raleway',
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Buyer ID: ${buyer}',
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 14,
                          fontFamily: 'Raleway',
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Product name: ${productName}',
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 14,
                          fontFamily: 'Raleway',
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Shipping to: ${shippingTo}',
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 14,
                          fontFamily: 'Raleway',
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Payment method: ${selectPaymentMethod}',
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 14,
                          fontFamily: 'Raleway',
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Delivery Period: ${deliveryPeriod}',
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 14,
                          fontFamily: 'Raleway',
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Catalog Price:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '€ $catalogPrice',
                            style: TextStyle(
                              color: Color(0xFF7F007F),
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Current vlock Price:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '€ $currentVlockPrice',
                            style: TextStyle(
                              color: Color(0xFF7F007F),
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),

                      Row(
                        children: [
                          Text(
                            'End point Price:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '€ $endPointPrice',
                            style: TextStyle(
                              color: Color(0xFF7F007F),
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'start point Price:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '€ $catalogPrice',
                            style: TextStyle(
                              color: Color(0xFF7F007F),
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'current vlock size:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$currentVlockSize',
                            style: TextStyle(
                              color: Color(0xFF7F007F),
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Actual vlock size:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$actualVlockSize',
                            style: TextStyle(
                              color: Color(0xFF7F007F),
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 280,
                        child: OutlinedButton(
                          onPressed: onPressed,
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                  return Color(0xFF7F007F).withOpacity(0.1);
                                }),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          child: const Text("Delete Order"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

Widget buildCreateVlockScreen(
        {void Function()? onPressed,
        context,
        required String image,
        required String productName,
        required int prize}) =>
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () => 0,
          child: SizedBox.fromSize(
            child: Container(
              width: 335,
              height: 100,
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 14,
                          fontFamily: 'Raleway',
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Catalog Prize',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '€ $prize',
                            style: TextStyle(
                              color: Color(0xFF7F007F),
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      OutlinedButton(
                        onPressed:onPressed
                        //     () {
                        //   selectedProduct = productName;
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => brandScreen()),
                        //   );
                        // }
                        ,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                            return Color(0xFF7F007F).withOpacity(0.2);
                          }),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                        ),
                        child: const Text("View Product"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

Widget defaultTextField(
        {required TextEditingController,

        required String labelText,
        IconData? suffix,
        bool password = false,
        required TextInputType type,
        Function()? obsecureButton,
         FormFieldValidator? textValidator}) =>
    TextFormField(
        cursorColor: Color(0XFF800080),
        controller: TextEditingController,
        validator: textValidator,
        keyboardType: type,
        obscureText: password,
        decoration: InputDecoration(
          labelStyle: new TextStyle(color: Colors.grey),
          labelText: labelText,
          suffixIcon: suffix != null
              ? IconButton(onPressed: obsecureButton, icon: Icon(suffix))
              : null,
        ));

Widget defaultButton(
        {required Function()? fun,
        required Color color,
        required String text}) =>
    Container(
      width: double.infinity,
      color: color,
      child: MaterialButton(
        onPressed: fun,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget registerButton({
  required Function()? fun,
  required Color color,
  required String text,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: fun,
      child: Text(
        text,
        style: TextStyle(fontSize: 17),
      ),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          primary: Color(0xFF7F007F)),
    ),
  );
}

buildProductScreen({
  required String name,
  required String image,
  required int price,
  required void Function() onpressed2,
  required void Function() onpressed,
  required String description,
  required String specifications,
}) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    reverse: true,
    scrollDirection: Axis.vertical,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    'lib/images/back.svg',
                    width: 32,
                  ),
                  //onPressed: () => Navigator.of(context).pop(),
                  onPressed: onpressed2),
              Spacer(),
              GestureDetector(child: SvgPicture.asset('lib/images/share.svg')),
              SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                'lib/images/like.svg',
                width: 60,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(

                          image: NetworkImage(image), fit: BoxFit.fill)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Catalog price $price.00€',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff800080)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Product information',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '''$description''',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff748B9B)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Specifications',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '''$specifications''',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff748B9B)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: ButtonTheme(
                        child: SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Join Active Vlock',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff800080)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: onpressed
                          // () =>
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) =>  createVlockScreen()),
                          // )
                          ,
                          child: Text(
                            'Create Vlock',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(18), // <-- Radius
                            ),
                            side: BorderSide(
                                width: 2.0, color: Color(0xff800080)),
                          ),
                        ),
                      ),

                    ),

                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    ),
  );
}

// buildNewVlockScreen({
//   required void Function() onpressed,
//   required void Function() setState,
// })
// {return
//   SingleChildScrollView(
//
//     scrollDirection: Axis.vertical,
//     child: Column(
//       crossAxisAlignment:CrossAxisAlignment.start,
//
//       children: [
//         SizedBox(height: 10,),
//
//         Container(width: double.infinity,
//           height: 1,
//           color: Colors.black.withOpacity(0.2),),
//         Padding(
//           padding: const EdgeInsets.only(left: 20,right: 20),
//           child: Column(
//             children: [
//               SizedBox(height: 10,),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Product',
//                   style: TextStyle(
//                       fontSize: 12,
//
//                       fontFamily: 'Raleway',
//                       fontWeight:
//                       FontWeight.bold,
//                       color: Colors.black.withOpacity(0.4)),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'HERO8 Black/Silver v05.00',
//                   style: TextStyle(
//                       fontSize: 20,
//
//                       fontFamily: 'Raleway',
//                       fontWeight:
//                       FontWeight.bold,
//                       color: Colors.black),
//                 ),
//               ),
//               SizedBox(height: 15,),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Catalog price €320',
//                   style: TextStyle(
//                       fontSize: 16,
//
//                       fontFamily: 'Raleway',
//                       fontWeight:
//                       FontWeight.bold,
//                       color:Color(0xff800080)),
//                 ),
//               ),
//               SizedBox(height: 10,),
//               Container(
//                 width: double.infinity,
//                 height: 220,
//                 decoration: BoxDecoration(
//                   color: Color(0xff800080).withOpacity(0.2),
//                   borderRadius:  BorderRadius.all(Radius.circular(20.0)),
//                 ),
//                 child: DottedBorder(
//                     borderType: BorderType.RRect,
//                     radius: Radius.circular(20),
//                     dashPattern: [10, 5],
//                     color: Color(0xff800080),
//                     strokeWidth: 2,
//                     child:
//
//                     Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset('lib/images/attach.svg',width:60 ,),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           Text(
//                             'Upload prodect Photo or Video',
//                             style: TextStyle(
//                                 fontSize: 16,
//
//                                 fontFamily: 'Raleway',
//                                 fontWeight:
//                                 FontWeight.bold,
//                                 color:Colors.black ),
//                           ),
//
//                         ],
//                       ),
//                     )
//
//                 ),
//               ),
//               SizedBox(height: 10,),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Choose Vlock Size',
//                   style: TextStyle(
//                       fontSize: 16,
//
//                       fontFamily: 'Raleway',
//                       fontWeight:
//                       FontWeight.bold,
//                       color:Colors.black),
//                 ),
//               ),
//               SizedBox(height: 10,),
//
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 10,right: 10),
//           child: Row(
//             children: [
//               MyRadioListTile<int>(
//                 value: 1,
//                 groupValue: _value,
//                 leading: '100 Pcs',
//                 title: '€304,-',
//                 onChanged: (value) => setState(() => _value = value!),
//               ),
//               MyRadioListTile<int>(
//                 value: 2,
//                 groupValue: _value,
//                 leading: '100 Pcs',
//                 title: '€304,-',
//                 onChanged: (value) => setState( setState
//                 //        () => _value = value!
//                 ),
//               ),
//               MyRadioListTile<int>(
//                 value: 3,
//                 groupValue: _value,
//                 leading: '100 Pcs',
//                 title: '€304,-',
//                 onChanged: (value) => setState(() => _value = value!),
//               ),
//               MyRadioListTile<int>(
//                 value: 4,
//                 groupValue: _value,
//                 leading: '100 Pcs',
//                 title: '€304,-',
//                 onChanged: (value) => setState(() => _value = value!),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 15,),
//         Padding(
//           padding: const EdgeInsets.only(left: 15),
//           child: Align(
//             alignment: Alignment.topLeft,
//             child: Text(
//               'Description',
//               style: TextStyle(
//                   fontSize: 16,
//
//                   fontFamily: 'Raleway',
//                   fontWeight:
//                   FontWeight.bold,
//                   color:Colors.black),
//             ),
//           ),
//         ),
//         SizedBox(height: 15,),
//         Padding(
//           padding: const EdgeInsets.only(left: 15,right: 15),
//           child: Container(
//             height: 160,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.grey.withOpacity(0.5),
//               ),
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 decoration: InputDecoration(
//                     border: InputBorder.none,
//
//                     contentPadding: EdgeInsets.only(top: 20), // add padding to adjust text
//                     isDense: true,
//                     hintText: "Enter decription here",
//
//                     hintStyle: TextStyle(
//                         fontWeight: FontWeight.w300,
//                         fontSize: 14
//                     )
//                 ),),
//             ),
//
//           ),
//         ),
//         SizedBox(height: 15,),
//
//         Padding(
//           padding: const EdgeInsets.only(left: 15,right: 15),
//           child: ButtonTheme(
//             child: SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: onpressed,
//                 //     () {
//                 //   Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(builder: (context) =>  Home()),
//                 //   );
//                 // },
//
//                 child: Text(
//                   'Create Vlock',
//                   style: TextStyle(
//                       fontSize: 12,
//
//                       fontFamily: 'Raleway',
//                       fontWeight:
//                       FontWeight.bold,
//                       color: Colors.white),
//                 ),
//
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Color(0xff800080
//                   )),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                   ),
//
//                 ),),
//             ),
//           ),
//         ),
//
//       ],
//     ),
//   );
//
// }
buildVlockWithAds() {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        height: 812.0,
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 800.0,
            height: 800.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                image: DecorationImage(
                    image: NetworkImage(
                        'https://s3-alpha-sig.figma.com/img/4794/8584/09d8c631a7b80c6407e4c94e93f6de9f?Expires=1664150400&Signature=gWD~uYPnhbKf3vFlwNvV7Y3M-Cj2r2Awa44pUCDdhHZppLW11XDCEJjLw4fVnKKm7rZ-zm0Bg3Lf7OAy~TAg4OBzr6x2PvcVU4gLqIn3XLtWrz-jOmQo~DpsrVw5SVzWEk43CFuZHgLzNy3hlSP74S3st3oK6sDtmdFiyjC5DiZKlJe9PquWoX1ZUdCxAn35feJ7Fi8PLH2DcAgg1X7psdaK7Fj3rkp9GcWfxqL1HMpe8enwmcU3G5XVppwdUwhZpdoYS1p4um2mCz3gpA-s5fX1faBoiQyCeVquyFqeeZ9-40~2OYplvNxy6yShb2F3gdfXHyYYLN~jj199myBGZg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
                    fit: BoxFit.fitHeight)),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 520),
              child: Center(
                child: Container(
                  width: 303,
                  height: 185,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(children: [
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(3.0),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0XFF748B9B)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://s3-alpha-sig.figma.com/img/8459/5892/f47b79e8557e8dbe4bcb0c1b64da2bec?Expires=1664150400&Signature=Ars5ENQN0CSdABaU58nCuqTjyabhTSxZupvH7TFw0jc7MwU77NX7mTH1OifLaDXido4VkCBeHGo8br8wKOFgEPOF9o1Of9frlEHBCJHDs9DXLFy6v4QIg762Tzb2vsrqQQ0TjUyWXC5w1i8N4isXCx1xoGkuSQ8t5Z41hEacD5~p5GLYu6zeV44vehXco7wCDLHzxFnKA8gmQE438PkdFE61-M1TsjkrkIuQKggt5vWmXWy1J50U-Pas8WkSyhbndIAaAuhBnIc-NzoVo5CYIv-0ZPX~NWu9ZfEfpQvinHeS7xL0YvTKm2PxWvF0Qvget4UEI2-eDowJgTqapZLAtQ__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
                                  fit: BoxFit.fitHeight)),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Robyn-X12',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0XFF212224)),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Sealee urban',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0XFF212224)),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'If you are looking for the latest and the most stylish urban bike. Sealee Urban is the answer.',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0XFF212224)),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ]),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Row(
                          children: [
                            Text(
                              'Advertisment',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w900,
                                  color: Color(0XFFE56C44)),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () => 0,
                                icon: SvgPicture.asset(
                                  'lib/images/go.svg',
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Skipp',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Railway',
                  fontWeight: FontWeight.bold,
                  color: Color(0XFFFFFFFF)),
            ),
          ],
        ),
      )
    ],
  );
}

artics({
  required String image,
  required String image2,
  required String title,
  required String subTitle,
  required String description
}){
return  Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: 812.0,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: double.infinity,
              height: 800.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.withOpacity(0.0)),
                  image: DecorationImage(
                      image: NetworkImage(
image                      ),
                      fit: BoxFit.fitHeight)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 520),
                child: Center(
                  child: Container(
                    width: 303,
                    height: 185,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                            children: [
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Raleway',
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Color(
                                              0XFF212224)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      subTitle,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Raleway',
                                          fontWeight:
                                          FontWeight.w400,
                                          color: Color(
                                              0XFF212224)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
     description,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Raleway',
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Color(
                                              0XFF212224)),
                                      maxLines: 3,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                 EdgeInsets.all(15.0),
                                padding:
                                 EdgeInsets.all(3.0),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10),
                                    border: Border.all(
                                        color:
                                        Color(0XFF748B9B)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                    image2    ),
                                        fit: BoxFit.fitHeight)),
                              )
                            ]),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text(
                                'Advertisment',
                                style: TextStyle(
                                    fontSize: 15,

                                    fontWeight:
                                    FontWeight.w900,
                                    color:
                                    Color(0XFFE56C44)),
                                maxLines: 3,
                                overflow:
                                TextOverflow.ellipsis,
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () => 0,
                                  icon: SvgPicture.asset(
                                    'lib/images/go.svg',
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Skipp',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Railway',
                    fontWeight: FontWeight.bold,
                    color: Color(0XFFFFFFFF)),
              ),
            ],
          ),
        )
      ],
    ),
  );

}

articsAdmin({
  void Function()?OnPressed,
  required String image,
  required String image2,
  required String title,
  required String subTitle,
  required String description,
}){
  return  Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: 812.0,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: double.infinity,
              height: 800.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.withOpacity(0.0)),
                  image: DecorationImage(
                      image: NetworkImage(
                          image                      ),
                      fit: BoxFit.fitHeight)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 520),
                child: Center(
                  child: Container(
                    width: 303,
                    height: 185,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                            children: [
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Raleway',
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Color(
                                              0XFF212224)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      subTitle,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Raleway',
                                          fontWeight:
                                          FontWeight.w400,
                                          color: Color(
                                              0XFF212224)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      description,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Raleway',
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Color(
                                              0XFF212224)),
                                      maxLines: 3,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                EdgeInsets.all(15.0),
                                padding:
                                EdgeInsets.all(3.0),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10),
                                    border: Border.all(
                                        color:
                                        Color(0XFF748B9B)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            image2    ),
                                        fit: BoxFit.fitHeight)),
                              )
                            ]),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text(
                                'Advertisment',
                                style: TextStyle(
                                    fontSize: 15,

                                    fontWeight:
                                    FontWeight.w900,
                                    color:
                                    Color(0XFFE56C44)),
                                maxLines: 3,
                                overflow:
                                TextOverflow.ellipsis,
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () => 0,
                                  icon: SvgPicture.asset(
                                    'lib/images/go.svg',
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: OnPressed,
                child: Container(
                  color: Colors.red,
                  child: Text(
                    'Delete',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Railway',
                        fontWeight: FontWeight.bold,
                        color: Color(0XFFFFFFFF)),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );

}

Widget buildNotifications({
  required String img,
  required String title,
  required String postedAt,
  String? title2
}){

  return   Container(
    decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    height: 70,
    child: Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage:
            NetworkImage(img),
            backgroundColor: Colors.transparent,
          ),
          // SvgPicture.asset('lib\images\logout.svg'),
          SizedBox(
            width: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 12,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   ' has started a new Vlock',
                    //   style: TextStyle(
                    //
                    //     fontSize: 14,
                    //     fontFamily: 'Raleway',
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      '${postedAt.toString()} ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),
                    ),
                    Text(
                      'ago',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}