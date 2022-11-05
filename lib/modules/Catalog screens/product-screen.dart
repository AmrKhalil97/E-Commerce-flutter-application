import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../shared/components/components.dart';
import '../catalog.dart';
import '../home.dart';
import '../notifications.dart';
import '../profile.dart';
import '../vlocks.dart';

class productScreen extends StatefulWidget {


  @override
  State<productScreen> createState() => _productScreenState();
}

class _productScreenState extends State<productScreen> {



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


      body: searchScreen ?
      SingleChildScrollView(

        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 25),
              child: Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset('lib/images/back.svg',width: 32,),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'Products',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,overflow: TextOverflow.clip
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset('lib/images/search.svg'),
                ],
              ),

            ),
            Column(
              children: [
                SizedBox(
                  height: 34,
                ),
                buildProductItem(
                  context: context,
                    image:'https://s3-alpha-sig.figma.com/img/7343/da7e/bda0b8ae04a73b78c654a3b25942322e?Expires=1663545600&Signature=NJ-fv8mHXIMFT3lPtkP~oTvwb8HD~cMqrUcZNMe~uvsSeZeSG3TTE-o68a~pON-lPjKlrjvR5EBrO-41nFQT4UsCnK72lzMKUSVzYB6jzMf3WSgNSCV0EEedJxb24TMZ2CwBXEQn1WJ~0OA2zVG91Z8YN~rPbxV-GEp-JuKusmHCTvHhLxPZhUMxDe6xwVFfuPuo06qxuFbsjMbG-wJfkxSUmz7TdwLYNYBIed3GMY4GTmkRlhuDDQY4AqzBvcD2dYOYYYB7diTOSYkT4W53PCnsH5SMAvSsXwo4zgKtPZsxvpPUj59ZqliZxTIb9CVVwExQui9pz4ZpBWWwaN5ANA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
                    prize: 22,
                    productName: 'Gopro Hero '),
                SizedBox(
                  height: 10,
                ),
                buildProductItem(
                    context: context,
                    image:'https://s3-alpha-sig.figma.com/img/7343/da7e/bda0b8ae04a73b78c654a3b25942322e?Expires=1663545600&Signature=NJ-fv8mHXIMFT3lPtkP~oTvwb8HD~cMqrUcZNMe~uvsSeZeSG3TTE-o68a~pON-lPjKlrjvR5EBrO-41nFQT4UsCnK72lzMKUSVzYB6jzMf3WSgNSCV0EEedJxb24TMZ2CwBXEQn1WJ~0OA2zVG91Z8YN~rPbxV-GEp-JuKusmHCTvHhLxPZhUMxDe6xwVFfuPuo06qxuFbsjMbG-wJfkxSUmz7TdwLYNYBIed3GMY4GTmkRlhuDDQY4AqzBvcD2dYOYYYB7diTOSYkT4W53PCnsH5SMAvSsXwo4zgKtPZsxvpPUj59ZqliZxTIb9CVVwExQui9pz4ZpBWWwaN5ANA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
                    prize: 22,
                    productName: 'Gopro Hero 8'),
                SizedBox(
                  height: 10,
                ),
                buildProductItem(
                    context: context,
                    image:'https://s3-alpha-sig.figma.com/img/7343/da7e/bda0b8ae04a73b78c654a3b25942322e?Expires=1663545600&Signature=NJ-fv8mHXIMFT3lPtkP~oTvwb8HD~cMqrUcZNMe~uvsSeZeSG3TTE-o68a~pON-lPjKlrjvR5EBrO-41nFQT4UsCnK72lzMKUSVzYB6jzMf3WSgNSCV0EEedJxb24TMZ2CwBXEQn1WJ~0OA2zVG91Z8YN~rPbxV-GEp-JuKusmHCTvHhLxPZhUMxDe6xwVFfuPuo06qxuFbsjMbG-wJfkxSUmz7TdwLYNYBIed3GMY4GTmkRlhuDDQY4AqzBvcD2dYOYYYB7diTOSYkT4W53PCnsH5SMAvSsXwo4zgKtPZsxvpPUj59ZqliZxTIb9CVVwExQui9pz4ZpBWWwaN5ANA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
                    prize: 22,
                    productName: 'Gopro Hero 8'),
                SizedBox(
                  height: 10,
                ),
                buildProductItem(
                    context: context,
                    image:'https://s3-alpha-sig.figma.com/img/7343/da7e/bda0b8ae04a73b78c654a3b25942322e?Expires=1663545600&Signature=NJ-fv8mHXIMFT3lPtkP~oTvwb8HD~cMqrUcZNMe~uvsSeZeSG3TTE-o68a~pON-lPjKlrjvR5EBrO-41nFQT4UsCnK72lzMKUSVzYB6jzMf3WSgNSCV0EEedJxb24TMZ2CwBXEQn1WJ~0OA2zVG91Z8YN~rPbxV-GEp-JuKusmHCTvHhLxPZhUMxDe6xwVFfuPuo06qxuFbsjMbG-wJfkxSUmz7TdwLYNYBIed3GMY4GTmkRlhuDDQY4AqzBvcD2dYOYYYB7diTOSYkT4W53PCnsH5SMAvSsXwo4zgKtPZsxvpPUj59ZqliZxTIb9CVVwExQui9pz4ZpBWWwaN5ANA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
                    prize: 22,
                    productName: 'Gopro Hero 8'),

              ],
            ),
          ],
        ),
      )
          : screen[_selectedScreenIndex]
      ,
    )
    ;  }

  void _selectScreen(int index) {
    setState(() {
      searchScreen = false;
      _selectedScreenIndex = index;
    });
  }
}
