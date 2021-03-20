import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:meditec/model/appointment.dart';
import 'package:meditec/view/screen/upload_previous_report_page.dart';
import 'package:meditec/view/screen/upload_sample_screen.dart';
import 'package:meditec/view/screen/video_call_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customFAB.dart';

class AppointmentDetailScreen extends StatefulWidget {
  static const String id = 'appointment_detail';
  final Appointment appointment;

  const AppointmentDetailScreen({Key key, this.appointment}) : super(key: key);

  @override
  _AppointmentDetailScreenState createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyCustomAppBar(),
      bottomNavigationBar: MyCustomNavBar(),
      floatingActionButton: MyCustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: space * 0.2,
                      ),
                      Container(
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
                        child: Column(
                          children: [
                            SizedBox(
                              height: space * 0.14,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget
                                      .appointment.doctorSlot.chamber.user.name,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.appointment.doctorSlot.chamber.user
                                      .categories[0].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  widget.appointment.doctorSlot.chamber.user
                                      .degree.degreeName,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Container(
                                  height: space * 0.12,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VideoCall(
                                                          appointment: widget
                                                              .appointment,
                                                        )));
                                          },
                                          child: Container(
                                            height: space * 0.09,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: space * 0.01),
                                            decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.videocam,
                                                  color: Colors.white,
                                                  size: space * 0.06,
                                                ),
                                                SizedBox(
                                                  width: space * 0.01,
                                                ),
                                                Text(
                                                  "Join Video Call",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: space * 0.05,
                                        ),
                                        GestureDetector(
                                          // onTap: () {
                                          //   Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               VideoCall(
                                          //                 appointment:
                                          //                     widget.appointment,
                                          //               )));
                                          // },
                                          child: Container(
                                            height: space * 0.09,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: space * 0.01),
                                            decoration: BoxDecoration(
                                                color: Colors.blueAccent,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.messenger,
                                                  color: Colors.white,
                                                  size: space * 0.06,
                                                ),
                                                SizedBox(
                                                  width: space * 0.01,
                                                ),
                                                Text(
                                                  "Send Text Message",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: space * 0.12,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UploadPreviousReportScreen(
                                                  appointment:
                                                      widget.appointment,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: space * 0.09,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: space * 0.01),
                                            decoration: BoxDecoration(
                                                color: Colors.brown,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.upload_file,
                                                  color: Colors.white,
                                                  size: space * 0.06,
                                                ),
                                                SizedBox(
                                                  width: space * 0.01,
                                                ),
                                                Text(
                                                  "Upload Previous Documents",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: space * 0.12,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UploadSampleScreen(
                                                  appointment:
                                                      widget.appointment,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: space * 0.09,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: space * 0.01),
                                            decoration: BoxDecoration(
                                                color: Colors.teal,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.image_rounded,
                                                  color: Colors.white,
                                                  size: space * 0.06,
                                                ),
                                                SizedBox(
                                                  width: space * 0.01,
                                                ),
                                                Text(
                                                  "Upload Sample Images",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: space * 0.12,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: space * 0.09,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF00BABA),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          height: space * 0.15,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Center(
                                            child: RichText(
                                              text: TextSpan(
                                                  text: DateFormat.E().format(
                                                      widget
                                                          .appointment
                                                          .doctorSlot
                                                          .startTime),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      height: 1.5,
                                                      color: Colors.white),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            ' ${DateFormat.d().format(widget.appointment.doctorSlot.startTime)}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: space * 0.05,
                                      ),
                                      Container(
                                        height: space * 0.09,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          height: space * 0.15,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Center(
                                              child: Text(
                                            "${DateFormat.jm().format(widget.appointment.doctorSlot.startTime)}-${DateFormat.jm().format(widget.appointment.doctorSlot.endTime)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: space * 0.05,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: space * 0.05,
                      ),
                      Container(
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
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Appointment Details",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Text(
                                //   "Edit",
                                //   style: TextStyle(
                                //       color: Color(0xFF00BABA),
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.bold),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: space * 0.02,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date:",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: space * 0.02,
                                    ),
                                    Text(
                                      "Time:",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: space * 0.02,
                                    ),
                                    Text(
                                      "Fee:",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: space * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${DateFormat.yMd().format(widget.appointment.doctorSlot.startTime)}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: space * 0.02,
                                    ),
                                    Text(
                                      "${DateFormat.jm().format(widget.appointment.time)} ",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: space * 0.02,
                                    ),
                                    Text(
                                      widget.appointment.doctorSlot.fees
                                          .toString(),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: space * 0.05,
                      ),
                    ],
                  ),
                  Center(
                    child: (widget.appointment.doctorSlot.chamber.user
                                .userAvatar !=
                            null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: space * 0.3,
                              width: space * 0.3,
                              child: Image(
                                image: Image.memory(base64.decode(widget
                                        .appointment
                                        .doctorSlot
                                        .chamber
                                        .user
                                        .userAvatar
                                        .image))
                                    .image,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
