// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:vlocks/modules/Catalog%20screens/services.dart';
import 'package:vlocks/modules/Catalog%20screens/subscription.dart';

import 'Catalog screens/onDemand.dart';

class catalog extends StatefulWidget {
  @override
  State<catalog> createState() => _catalogState();
}

class _catalogState extends State<catalog> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            bottom: PreferredSize(
                child: Text("Catalog",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Colors.black)
                ),
                preferredSize: Size.zero),

          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10,top: 20),
            child: Column(
              children: [
                Container(
width: 324,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.blueAccent.withOpacity(0.3))),
                  child: TabBar(

                    isScrollable: true,
                    unselectedLabelColor:Color(0xff748B9B),

                    tabs: [

                      new Tab(text: 'On-Demand',
                        // child: Text(
                        //   'On-Demand',
                        //   style: TextStyle(
                        //       fontSize: 12,
                        //       fontFamily: 'Raleway',
                        //       fontWeight: FontWeight.w600,
                        //       color: Color(0XFF800080),
                        //   ),
                        // ),
                      ),
                      new Tab(text: 'Subscription',
                        // child: Text(
                        //   'Subscription',
                        //   style: TextStyle(
                        //       fontSize: 13,
                        //       fontFamily: 'Raleway',
                        //       fontWeight: FontWeight.w600,
                        //       color: Color(0XFF800080)),
                        // ),
                      ),
                      new Tab(text:'Services' ,
                        // child: Text(
                        //   'Services',
                        //   style: TextStyle(
                        //       fontSize: 13,
                        //       fontFamily: 'Raleway',
                        //       fontWeight: FontWeight.w600,
                        //       color: Color(0XFF800080)),
                        // ),
                      ),
                    ],
                    labelColor: Color(0XFF800080),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,top: 15),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF000000)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: TabBarView(

                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5,
                              right: 5
                          ),
                          child: onDemand(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5
                          ),
                          child: subscription(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5,
                              right: 5
                          ),
                          child: services(),
                        )],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
