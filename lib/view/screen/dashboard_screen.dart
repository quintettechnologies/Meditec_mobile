import 'package:flutter/material.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/doctor_screen.dart';
import 'package:meditec/view/widget/catagoryButton.dart';
import 'package:meditec/view/widget/catagoryButtonDashboard.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: MyCustomAppBar(
            isDashboard: true,
          ),
          drawer: MyCustomDrawer(),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: space * 0.01, horizontal: space * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Services',
                      style: TextStyle(
                          fontSize: space * 0.05, color: kPrimaryTextColor),
                    ),
                    SizedBox(height: space * 0.05),
                    FittedBox(
                      child: Row(
                        children: [
                          CatagoryButtonDashBoard(
                            onTap: () {
                              Navigator.pushNamed(context, DoctorScreen.id);
                            },
                            category: 'Doctor',
                            color: Color(0xFFE2F2F8),
                          ),
                          // SizedBox(width: space * 0.05),
                          // CatagoryButtonDashBoard(
                          //   onTap: () {},
                          //   category: 'Hospital',
                          //   color: Color(0xFFE2F1EF),
                          // ),
                          // SizedBox(width: space * 0.05),
                          // CatagoryButtonDashBoard(
                          //   onTap: () {},
                          //   category: 'Ambulance',
                          //   color: Color(0xFFE7F1E4),
                          // ),
                          // SizedBox(width: space * 0.05),
                          // CatagoryButtonDashBoard(
                          //   onTap: () {},
                          //   category: 'Diagnostic',
                          //   color: Color(0xFFD6E7F2),
                          // ),
                        ],
                      ),
                    ),
                    // SizedBox(height: space * 0.05),
                    // FittedBox(
                    //   child: Row(
                    //     children: [
                    //       CatagoryButtonDashBoard(
                    //         onTap: () {},
                    //         category: 'Blood',
                    //         color: Color(0xFFF7E0E0),
                    //       ),
                    //       SizedBox(width: space * 0.05),
                    //       CatagoryButtonDashBoard(
                    //         onTap: () {},
                    //         category: 'Int. Doctor',
                    //         color: Color(0xFFF8EBE1),
                    //       ),
                    //       SizedBox(width: space * 0.05),
                    //       CatagoryButtonDashBoard(
                    //         onTap: () {},
                    //         category: 'Report',
                    //         color: Color(0xFFF7E3E9),
                    //       ),
                    //       SizedBox(width: space * 0.05),
                    //       CatagoryButtonDashBoard(
                    //         onTap: () {},
                    //         category: 'Blog',
                    //         color: Color(0xFFF1E5EF),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: space * 0.05),
                    Text(
                      "What's New",
                      style: TextStyle(
                          fontSize: space * 0.05, color: kPrimaryTextColor),
                    ),
                    SizedBox(height: space * 0.05),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: kSelectedButtonDecoration,
                            child: Text(
                              "Corona Update",
                              style: kSelectedButtonTextStyle,
                            ),
                          ),
                          SizedBox(width: space * 0.03),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: kButtonDecoration,
                            child: Text(
                              "Health",
                              style: kButtonTextStyle,
                            ),
                          ),
                          SizedBox(width: space * 0.03),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: kButtonDecoration,
                            child: Text(
                              "Doctors",
                              style: kButtonTextStyle,
                            ),
                          ),
                          SizedBox(width: space * 0.03),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: kButtonDecoration,
                            child: Text(
                              "Hospital",
                              style: kButtonTextStyle,
                            ),
                          ),
                          SizedBox(width: space * 0.03),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: kButtonDecoration,
                            child: Text(
                              "Medicine",
                              style: kButtonTextStyle,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // body: Center(
          //   child: Container(
          //     child: FlatButton(
          //         onPressed: () {
          //           Navigator.pushNamed(context, DoctorScreen.id);
          //         },
          //         child: Text("Doctors")),
          //   ),
          // ),
          floatingActionButton: MyCustomFAB(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: MyCustomNavBar(),
        ));
  }
}
