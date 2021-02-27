import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:meditec/model/appointment.dart';
import 'package:meditec/model/index.dart';
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

class PrescriptionPage extends StatefulWidget {
  static const String id = 'Prescription';
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    List<Prescription> prescriptions = context.read(userProvider).prescriptions;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Prescriptions',
                  style: TextStyle(
                      fontSize: space * 0.05, color: kPrimaryTextColor),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      for (Prescription prescription in prescriptions)
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF000000).withOpacity(0.1),
                                  offset: Offset.fromDirection(1),
                                  blurRadius: 10,
                                  spreadRadius: 1)
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Doctor: ${prescription.doctorName ?? ""}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Medicine: ${prescription.medicine ?? ""}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      "Test: ${prescription.test ?? ""}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    // Text(doctors[index].hospital,
                                    //     style: TextStyle(
                                    //         fontSize: 13,
                                    //         fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: space * 0.02,
                              ),
                            ],
                          ),
                        )
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
