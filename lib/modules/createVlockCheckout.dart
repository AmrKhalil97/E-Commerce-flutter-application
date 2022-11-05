import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlocks/models/orderModel.dart';

import '../models/notificationsModel.dart';
import '../shared/variables/variables.dart';
import 'successPayment-screen.dart';

class createVlockCheckout extends StatefulWidget {



  @override
  State<createVlockCheckout> createState() => _checkoutState();




}

class _checkoutState extends State<createVlockCheckout> {
  var reachedBottom = false;
  int _groupValue = -1;
  int _groupValue2 = -1;
  int _groupValue3 = -1;

  String shippingTo='';
  String paymentMethod='';
  String deliveryPeriod='';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('lib/images/back.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Checkout',
          style: TextStyle(
            color: Color(0XFF000000),
            fontSize: 19,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
            child: Container(
              color: Color(0XFF748B9B).withOpacity(0.3),
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 19),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping to',
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(children: [
                    RadioListTile(
                      activeColor: Color(0XFF800080),
                      title: Row(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Home',
                                  style: TextStyle(
                                    color: Color(0XFF000000),
                                    fontSize: 13,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Dorpstraat 34 19, 6137  SR, Roermond',
                                  style: TextStyle(
                                    color: Color(0XFF748B9B),
                                    fontSize: 9,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ]),
                          Spacer(),
                          SvgPicture.asset(
                            'lib/images/location.svg',
                            width: 20,
                          ),
                        ],
                      ),
                      value: 0,
                      groupValue: _groupValue,
                      onChanged: (value) =>
                          setState(() {
                            _groupValue = value as int;
                            shippingTo='Home';
                            print(shippingTo);
                          }
                          ),
                    ),
                    Container(
                      width: 237,
                      height: 1,
                      color: Color(0XFF748B9B).withOpacity(0.3),
                    ),
                    RadioListTile(
                      activeColor: Color(0XFF800080),
                      title: Text(
                        'Slect Pickup Point',
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 13,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      value: 1,
                      groupValue: _groupValue,
                      onChanged: (newValue) =>
                          setState(() {
                            _groupValue = newValue as int;
                            shippingTo='Select Pickup Point';
                            print(shippingTo);
                          }
                          ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 19,
                ),
                Text(
                  'Share on',
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 19,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  height: 80,
                  width: double.infinity,
                  child: GridView.custom(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 8),
                    childrenDelegate: SliverChildListDelegate(
                      [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'lib/images/facebook.svg',
                                width: 45,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'facebook',
                                style: TextStyle(
                                  color: Color(0XFF000000),
                                  fontSize: 10,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'lib/images/twitter.svg',
                                width: 45,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'twitter',
                                style: TextStyle(
                                  color: Color(0XFF000000),
                                  fontSize: 10,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0XFFFFDD55),
                                      Color(0XFFC837AB),
                                    ],
                                    begin: const FractionalOffset(1.0, 0.0),
                                    end: const FractionalOffset(0.5, 0.0),
                                  ),
                                ),
                                child: SvgPicture.asset('lib/images/Shape.svg',
                                  fit: BoxFit.none,

                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Instagram',
                                style: TextStyle(
                                  color: Color(0XFF000000),
                                  fontSize: 10,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'lib/images/whatsapp.svg',
                                width: 45,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'WhatsApp',
                                style: TextStyle(
                                  color: Color(0XFF000000),
                                  fontSize: 10,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Select Payment Method',
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(children: [
                    RadioListTile(
                      activeColor: Color(0XFF800080),
                      title: Row(
                        children: [
                          Text(
                            'IDEAL',
                            style: TextStyle(
                              color: Color(0XFF000000),
                              fontSize: 13,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('lib/images/ideal.svg')
                        ],
                      ),
                      value: 0,
                      groupValue: _groupValue2,
                      onChanged: (value) =>
                          setState(() {
                            _groupValue2 = value as int;
                            paymentMethod='IDEAL';
                            print(paymentMethod);
                          }
                          ),
                    ),
                    Container(
                      width: 237,
                      height: 1,
                      color: Color(0XFF748B9B).withOpacity(0.3),
                    ),
                    RadioListTile(
                      activeColor: Color(0XFF800080),
                      title: Row(
                        children: [
                          Text(
                            'PayPal',
                            style: TextStyle(
                              color: Color(0XFF000000),
                              fontSize: 13,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('lib/images/paypal.svg')
                        ],
                      ),
                      value: 1,
                      groupValue: _groupValue2,
                      onChanged: (value) =>
                          setState(() {
                            _groupValue2 = value as int;
                            paymentMethod='PayPal';
                            print(paymentMethod);
                          }
                          ),
                    ),
                    Container(
                      width: 237,
                      height: 1,
                      color: Color(0XFF748B9B).withOpacity(0.3),
                    ),
                    RadioListTile(
                      activeColor: Color(0XFF800080),
                      title: Row(
                        children: [
                          Text(
                            'Google Pay',
                            style: TextStyle(
                              color: Color(0XFF000000),
                              fontSize: 13,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            'lib/images/gogpay.svg',
                            width: 33,
                          )
                        ],
                      ),
                      value: 2,
                      groupValue: _groupValue2,
                      onChanged: (value) =>
                          setState(() {
                            _groupValue2 = value as int;
                            paymentMethod='Google Pay';
                            print(paymentMethod);
                          }
                          ),
                    )
                    ,
                    Container(
                      width: 237,
                      height: 1,
                      color: Color(0XFF748B9B).withOpacity(0.3),
                    ),
                    RadioListTile(
                        activeColor: Color(0XFF800080),
                        title: Row(
                          children: [
                            Text(
                              'Venmo',
                              style: TextStyle(
                                color: Color(0XFF000000),
                                fontSize: 13,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              'lib/images/venmo.svg',
                              width: 30,
                            )
                          ],
                        ),
                        value: 3,
                        groupValue: _groupValue2,
                        onChanged: (value) =>
                            setState(() {
                              _groupValue2 = value as int;
                              paymentMethod='Venmo';
                              print(paymentMethod);
                            }
                            )
                    ),
                    Container(
                      width: 237,
                      height: 1,
                      color: Color(0XFF748B9B).withOpacity(0.3),
                    ),
                    RadioListTile(
                        activeColor: Color(0XFF800080),
                        title: Row(
                          children: [
                            Text(
                              'Apple Pay',
                              style: TextStyle(
                                color: Color(0XFF000000),
                                fontSize: 13,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              'lib/images/applepay.svg',
                              width: 30,
                            )
                          ],
                        ),
                        value: 4,
                        groupValue: _groupValue2,
                        onChanged: (value) =>
                            setState(() {
                              _groupValue2 = value as int;
                              paymentMethod='Apple pay';
                              print(paymentMethod);
                            }
                            )),
                    Container(
                      width: 237,
                      height: 1,
                      color: Color(0XFF748B9B).withOpacity(0.3),
                    ),
                    RadioListTile(
                        activeColor: Color(0XFF800080),
                        title: Row(
                          children: [
                            Text(
                              'Credit Card',
                              style: TextStyle(
                                color: Color(0XFF000000),
                                fontSize: 13,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              'lib/images/creditcard.svg',
                              width: 30,
                            )
                          ],
                        ),
                        value: 5,
                        groupValue: _groupValue2,
                        onChanged: (value) =>
                            setState(() {
                              _groupValue2 = value as int;
                              paymentMethod='Credit Card';
                              print(paymentMethod);
                            }
                            )),
                  ]),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Delivery Period',
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(children: [
                    RadioListTile(
                        activeColor: Color(0XFF800080),
                        title: Text(
                          'Once per month',
                          style: TextStyle(
                            color: Color(0XFF000000),
                            fontSize: 16,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        value: 0,
                        groupValue: _groupValue3,
                        onChanged: (value) =>
                            setState(() {
                              _groupValue3 = value as int;
                              deliveryPeriod='Once per month';
                              print(deliveryPeriod);
                            }
                            )),
                    Container(
                      width: 237,
                      height: 1,
                      color: Color(0XFF748B9B).withOpacity(0.3),
                    ),
                    RadioListTile(
                        activeColor: Color(0XFF800080),
                        title: Text(
                          'Twice per month',
                          style: TextStyle(
                            color: Color(0XFF000000),
                            fontSize: 16,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        value: 1,
                        groupValue: _groupValue3,
                        onChanged: (value) =>
                            setState(() {
                              _groupValue3 = value as int;
                              deliveryPeriod='Twice per month';
                              print(deliveryPeriod);
                            }
                            )),
                    Container(
                      width: 237,
                      height: 1,
                      color: Color(0XFF748B9B).withOpacity(0.3),
                    ),
                    RadioListTile(
                        activeColor: Color(0XFF800080),
                        title: Text(
                          'Align with other subscriptions',
                          style: TextStyle(
                            color: Color(0XFF000000),
                            fontSize: 16,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        value: 2,
                        groupValue: _groupValue3,
                        onChanged: (value) =>
                            setState(() {
                              _groupValue3 = value as int;
                              deliveryPeriod='Align with other subscriptions';
                              print(deliveryPeriod);
                            }
                            )),
                  ]),
                ),
                SizedBox(
                  height: 24,
                ),

                Center(
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async{


                        if (formKey.currentState!.validate()) {


                          while(shippingTo !='' && paymentMethod !='' && deliveryPeriod != ''){
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => successPayment()),
                            );
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please fill the form"),
                          ));


                        };

                      },
                      child: Text(
                        'Payment',
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
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF800080),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
