import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlocks/layouts/home-layout.dart';

class successPayment extends StatelessWidget {
  const successPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 128, left: 41, right: 41),
        child: Center(
          child: Column(children: [
            SvgPicture.asset(
              'lib/images/done.svg',
              width: 130,
            ),
            SizedBox(height: 51),
            Text(
              'Payment Sucessful',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF27AE60)),
            ),
            Text("Your order will be ready in 1 day, including shipping, more details and options for tracking will be sent to your email \n \n \n Thanks!!!",
              textAlign: TextAlign.center,

              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF212224)),
            ),
            SizedBox(height: 32),
            Container(
              width: 280,
              height: 56,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home())),
                child: Text(
                  'Continue Shopping',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF800080))),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 280,
              height: 56,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home())),
                child: Text(
                  'Go to Home',
                  style: TextStyle(
                    color: Color(0XFF800080),
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(color: Color(0XFF800080))),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
