import 'package:flutter/material.dart';
import 'package:meditec/view/screen/doctor_screen.dart';
import 'package:meditec/view/widget/catagoryButton.dart';
import 'package:meditec/view/widget/catagoryButtonDashboard.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(),
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
                  'Category',
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
                      SizedBox(width: space * 0.05),
                      CatagoryButtonDashBoard(
                        onTap: () {},
                        category: 'Hospital',
                        color: Color(0xFFE2F1EF),
                      ),
                      SizedBox(width: space * 0.05),
                      CatagoryButtonDashBoard(
                        onTap: () {},
                        category: 'Ambulance',
                        color: Color(0xFFE7F1E4),
                      ),
                      SizedBox(width: space * 0.05),
                      CatagoryButtonDashBoard(
                        onTap: () {},
                        category: 'Diagnostic',
                        color: Color(0xFFD6E7F2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: space * 0.05),
                FittedBox(
                  child: Row(
                    children: [
                      CatagoryButtonDashBoard(
                        onTap: () {},
                        category: 'Blood',
                        color: Color(0xFFF7E0E0),
                      ),
                      SizedBox(width: space * 0.05),
                      CatagoryButtonDashBoard(
                        onTap: () {},
                        category: 'Int. Doctor',
                        color: Color(0xFFF8EBE1),
                      ),
                      SizedBox(width: space * 0.05),
                      CatagoryButtonDashBoard(
                        onTap: () {},
                        category: 'Report',
                        color: Color(0xFFF7E3E9),
                      ),
                      SizedBox(width: space * 0.05),
                      CatagoryButtonDashBoard(
                        onTap: () {},
                        category: 'Blog',
                        color: Color(0xFFF1E5EF),
                      ),
                    ],
                  ),
                ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
