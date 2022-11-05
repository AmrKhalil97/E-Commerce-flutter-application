import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vlocks/models/brandModel.dart';


Widget buildProductCard(BuildContext context, DocumentSnapshot<Map<String, dynamic>> document) {
  final product = productModel_class.fromJson(document);
  // final productItem = product.types();{
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            width: 128,
            height: 168,
            decoration: BoxDecoration(
              color: Color(0XFFFFFFFF),
              boxShadow: [

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
                        imageUrl: '${product.image}',
                        fit: BoxFit.cover,
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
                    '${product.name}',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Raleway',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Catalog Price:€ ${product.price}',
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
