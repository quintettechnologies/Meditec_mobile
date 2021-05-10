import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:meditec/model/medicineSchedule.dart';
import 'package:meditec/model/prescription.dart';
import 'package:meditec/model/test.dart';
import 'package:meditec/utils/pdfPrescription_api.dart';
import 'package:meditec/utils/pdf_api.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'callscreens/pickup/pickup_layout.dart';
import 'doctor_profile_screen.dart';

class PrescriptionPage extends HookWidget {
  final Prescription prescription;
  static const String id = 'add_prescription';

  PrescriptionPage({@required this.prescription});
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;

    return PickupLayout(
      scaffold: Scaffold(
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
                Text(
                  "c-Prescription",
                  style: TextStyle(
                      color: Color(0xFF00BABA),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Row(
                  children: [
                    (prescription.doctor.userAvatar != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: space * 0.3,
                              width: space * 0.3,
                              child: Image(
                                image: Image.memory(base64.decode(
                                        prescription.doctor.userAvatar.image))
                                    .image,
                              ),
                            ),
                          )
                        : Container(
                            height: space * 0.3,
                            width: space * 0.3,
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${prescription.doctor.name}",
                          style: TextStyle(fontSize: space * 0.038),
                        ),
                        Text("${prescription.doctor.categories[0].name}",
                            style: TextStyle(fontSize: space * 0.038)),
                        Text("${prescription.doctor.degree.degreeName}",
                            style: TextStyle(fontSize: space * 0.038)),
                        Text("${prescription.doctor.speciality.speciality}",
                            style: TextStyle(fontSize: space * 0.038)),
                        Text("${prescription.doctor.hospitalName}",
                            style: TextStyle(fontSize: space * 0.038)),
                        Text(
                          "${prescription.doctor.mobileNumber}",
                          style: TextStyle(fontSize: space * 0.038),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    (prescription.appoinment.originalUser &&
                            prescription.patient.userAvatar != null)
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
                        : Container(
                            height: space * 0.3,
                            width: space * 0.3,
                            child: Icon(
                              Icons.account_circle,
                              color: Color(0xFF00BABA),
                              size: space * 0.3,
                            ),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Patient: ${prescription.appoinment.originalUser ? prescription.patient.name : prescription.appoinment.friendlyUserName}",
                            style: TextStyle(fontSize: space * 0.038)),
                        Text(
                            "Age: ${prescription.appoinment.originalUser ? prescription.patient.age : prescription.appoinment.friendlyUserAge}",
                            style: TextStyle(fontSize: space * 0.038)),
                        Text(
                            "Gender: ${prescription.appoinment.originalUser ? prescription.patient.gender : prescription.appoinment.friendlyUserGender}",
                            style: TextStyle(fontSize: space * 0.038)),
                        Text(
                          "Phone: ${prescription.patient.mobileNumber}",
                          style: TextStyle(fontSize: space * 0.038),
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
                                      width: space * 0.9,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Container(
                                                      height: space * 0.15,
                                                      width: space * 0.15,
                                                      color: Colors.grey,
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/capsule.png'),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      RichText(
                                                          text: TextSpan(
                                                              text: schedule
                                                                  .medicine
                                                                  .medicineName,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              children: [])),
                                                      Text(
                                                        (schedule.afterMeal)
                                                            ? "After Meal"
                                                            : "Before Meal",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF00BABA),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
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
                                                        color:
                                                            Color(0xFF00BABA),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
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
                                                        color:
                                                            Color(0xFF00BABA),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
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
                                                        color:
                                                            Color(0xFF00BABA),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
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
                                    ),
                                  )
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 5,
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
                                      width: space * 0.9,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
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
                                                    child: Image(
                                                      image: AssetImage(
                                                          'assets/images/test.png'),
                                                    ),
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
                                                                color: Colors
                                                                    .black,
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
                  height: 5,
                ),
                Text(
                  "Advice",
                  style: TextStyle(
                      color: Color(0xFF00BABA),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  (prescription.advice != null) ? prescription.advice : "",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Referred to",
                  style: TextStyle(
                      color: Color(0xFF00BABA),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                (prescription.referredDoctor != null)
                    ? Container(
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
                            (prescription.referredDoctor.userAvatar != null)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: space * 0.17,
                                        width: space * 0.17,
                                        child: Image(
                                          image: Image.memory(base64.decode(
                                                  prescription.referredDoctor
                                                      .userAvatar.image))
                                              .image,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              width: space * 0.02,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prescription.referredDoctor.name,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Text(
                                  //   doctor.degree
                                  //           .degreeName ??
                                  //       "",
                                  //   style: TextStyle(
                                  //       fontSize: 12),
                                  // ),
                                  // Text(
                                  //   doctor.categories[0].name,
                                  //   style: TextStyle(
                                  //       fontSize: 12),
                                  // ),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Available",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF00BABA))),
                                  SizedBox(
                                    height: space * 0.05,
                                  ),
                                  Container(
                                    height: space * 0.05,
                                    //width: space * 0.15,
                                    child: RatingBar(
                                      itemSize: 10,
                                      wrapAlignment: WrapAlignment.end,
                                      initialRating: 5,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ratingWidget: RatingWidget(
                                        full: Icon(
                                          Icons.star,
                                          color: Color(0xFF3C4858),
                                        ),
                                        half: Icon(
                                          Icons.star_half,
                                          color: Color(0xFF3C4858),
                                        ),
                                        empty: Icon(
                                          Icons.star_border,
                                          color: Color(0xFF3C4858),
                                        ),
                                      ),
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      onRatingUpdate: (rating) {
                                        // print(rating);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextButton(
                //       onPressed: () async {
                //         final pdfFile =
                //             await PdfPrescriptionApi.generate(prescription);
                //
                //         PdfApi.openFile(pdfFile);
                //       },
                //       child: Container(
                //         height: space * 0.08,
                //         width: space * 0.25,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: Color(0xFF00BABA),
                //           borderRadius: BorderRadius.circular(5),
                //         ),
                //         child: Text(
                //           "Save As PDF",
                //           style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 14,
                //               fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final pdfFile = await PdfPrescriptionApi.generate(prescription);

            PdfApi.openFile(pdfFile);
          },
          child: Icon(Icons.picture_as_pdf),
          backgroundColor: Color(0xFF00BABA),
        ),
        bottomNavigationBar: MyCustomNavBar(),
      ),
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
