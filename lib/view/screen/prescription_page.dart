import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/medicineSchedule.dart';
import 'package:meditec/model/prescription.dart';
import 'package:meditec/model/test.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'dashboard_screen.dart';

class PrescriptionPage extends HookWidget {
  final Prescription prescription;
  static const String id = 'add_prescription';

  PrescriptionPage({@required this.prescription});
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(),
      drawer: MyCustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  (prescription.patient.userAvatar != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: space * 0.3,
                            width: space * 0.3,
                            child: Image(
                              image: Image.memory(base64.decode(
                                      prescription.patient.userAvatar.image))
                                  .image,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Patients name: ${prescription.patient.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                          "Patients type: ${prescription.doctor.categories[0].name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(
                        "Serial Number: ${prescription.appoinmentId}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "Mobile Number: ${prescription.patient.mobileNumber}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Medicine (Drug and Syrup)",
                style: TextStyle(
                    color: Color(0xFF00BABA),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Column(
                children: [
                  (prescription != null)
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              for (MedicineSchedule schedule
                                  in prescription.scedules)
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.blueGrey
                                                  .withOpacity(0.3),
                                              width: 2))),
                                  child: SizedBox(
                                    width: space * 0.8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  height: space * 0.15,
                                                  width: space * 0.15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RichText(
                                                      text: TextSpan(
                                                          text: schedule
                                                              .medicine
                                                              .medicineName,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          children: [])),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF00BABA),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Text(
                                                  "${schedule.morning}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF00BABA),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Text(
                                                  "${schedule.day}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF00BABA),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Text(
                                                  "${schedule.night}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF00BABA),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Text(
                                                  "${schedule.days} days",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Tests",
                style: TextStyle(
                    color: Color(0xFF00BABA),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Column(
                children: [
                  (prescription != null)
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              for (Test test in prescription.tests)
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.blueGrey
                                                  .withOpacity(0.3),
                                              width: 2))),
                                  child: SizedBox(
                                    width: space * 0.8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  height: space * 0.15,
                                                  width: space * 0.15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RichText(
                                                      text: TextSpan(
                                                          text: test.testName,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          children: [
                                                        // TextSpan(
                                                        //     text:
                                                        //         "100mg",
                                                        //     style: TextStyle(
                                                        //         color: Colors
                                                        //             .black,
                                                        //         fontWeight:
                                                        //             FontWeight.normal))
                                                      ])),
                                                  // RichText(
                                                  //     text: TextSpan(
                                                  //         text: "Tablet ",
                                                  //         style: TextStyle(
                                                  //             fontSize: 12, color: Colors.blueGrey),
                                                  //         children: [
                                                  //           TextSpan(text: "Beximco Pharma")
                                                  //         ]))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Advice",
                style: TextStyle(
                    color: Color(0xFF00BABA),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                prescription.advice,
                style: TextStyle(
                    color: Color(0xFF00BABA),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                "Referred to",
                style: TextStyle(
                    color: Color(0xFF00BABA),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                prescription.referredTo,
                style: TextStyle(
                    color: Color(0xFF00BABA),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MyCustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}

class Space extends StatelessWidget {
  const Space({
    Key key,
    @required this.space,
  }) : super(key: key);

  final double space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space * 0.05,
    );
  }
}
