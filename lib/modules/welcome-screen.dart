import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlocks/layouts/home-layout.dart';
import 'package:vlocks/modules/login-screen.dart';
import 'package:vlocks/modules/signUp-screen.dart';

class welcomeScreen extends StatelessWidget {
  final style =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7F007F),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 100,
          ),
          SvgPicture.asset('lib/images/vlocks logo.svg'),
          SizedBox(
            height: 90,
          ),
          Text(
            "Welcome!",
            style: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Consectetur et consequat, facilisi elementum pharetra. Commodo turpis mi aenean elementum nec urna. Fermentum molestie nec nunc, etiam turpis viverra arcu at quis. Eleifend amet lectus tortor id nec mi. Dui tincidunt lectus dolor, dui vitae enim rhoncus lorem. Sed volutpat consectetur nulla ipsum viverra turpis.",
              textAlign: TextAlign.center,
               style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Container(
            width: 300,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Container(

                width: 270,
                height: 48,
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(

                      border: Border.all(color: Color(0xFF800080)),

                      borderRadius: BorderRadius.all(Radius.circular(20))),

                child: GestureDetector(

                    // style: ButtonStyle(
                    //
                    //     shape:
                    //         MaterialStateProperty.all<RoundedRectangleBorder>(
                    //       RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(15.0),
                    //       ),
                    //     ),
                    //
                    // ),
                    onTap: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => login(),
                        )),
                    child: Text( "SIGN IN",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                      ),
                    )),
              ),
              SizedBox(
                height: 13,
              ),
              Container(
                width: 270,
                height: 48,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child:
                ElevatedButton(
                    style: ButtonStyle(
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF800080))),
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => signUp(),
                        )),
                    child: Text(   "SIGN UP",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    )),
              ),
              SizedBox(
                height: 13,
              ),
              Text("By clicking this button you agree to our",
                textAlign: TextAlign.center,

                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Color(0XFF000000),
                    fontSize: 13,
                    fontWeight: FontWeight.w800),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 17,
                  ),
                  TextButton(
                    onPressed: () => 0,
                    child: Text("Terms of Service",
                      textAlign: TextAlign.center,

                      style: TextStyle(decoration: TextDecoration.underline,
                          fontFamily: 'Raleway',
                          color: Color(0XFF800080),
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Text("and",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Color(0XFF800080),
                        fontSize: 13,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: () => 0,
                    child: Text( "Privacy Policy",
                      textAlign: TextAlign.center,

                      style: TextStyle(decoration: TextDecoration.underline,
                          fontFamily: 'Raleway',
                          color: Color(0XFF800080),
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              )
            ]),
          )
        ]),
      ),
    );
  }
}
