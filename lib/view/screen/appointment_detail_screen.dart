import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:meditec/model/appointment.dart';
import 'package:meditec/model/message.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/resources/firebase_api.dart';
import 'package:meditec/view/screen/chat_page.dart';
import 'package:meditec/view/screen/reports_list_screen.dart';
import 'package:meditec/view/screen/samples_list_screen.dart';
import 'package:meditec/view/screen/upload_previous_report_page.dart';
import 'package:meditec/view/screen/upload_sample_screen.dart';
import 'package:meditec/view/screen/video_call_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'callscreens/pickup/pickup_layout.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return PickupLayout(
      scaffold: Scaffold(
        appBar: MyCustomAppBar(),
        bottomNavigationBar: MyCustomNavBar(),
        floatingActionButton: MyCustomFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: space * 0.15,
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                      widget.appointment.doctorSlot.chamber.user
                                          .name,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.appointment.doctorSlot.chamber.user
                                          .categories[0].name,
                                      style: TextStyle(
                                        color: Color(0xFF00BABA),
                                        fontWeight: FontWeight.bold,
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
                                    Text(
                                      widget.appointment.doctorSlot.chamber.user
                                          .hospitalName,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: space * 0.12,
                                          width: space * 0.9,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             VideoCall(
                                                  //               appointment: widget
                                                  //                   .appointment,
                                                  //             )));
                                                },
                                                child: Container(
                                                  height: space * 0.09,
                                                  width: space * 0.4,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: space * 0.01),
                                                  decoration: BoxDecoration(
                                                      color: Colors.deepOrange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
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
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: space * 0.02,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatPage(
                                                                  user: widget
                                                                      .appointment
                                                                      .doctorSlot
                                                                      .chamber
                                                                      .user)));
                                                },
                                                child: Container(
                                                  height: space * 0.09,
                                                  width: space * 0.4,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: space * 0.01),
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    children: [
                                                      // Icon(
                                                      //   Icons.chat_bubble_rounded,
                                                      //   color: messageColor,
                                                      //   size: space * 0.06,
                                                      // ),
                                                      StreamBuilder<
                                                          List<Message>>(
                                                        stream: FirebaseApi.getMessages(
                                                            doctorID: widget
                                                                .appointment
                                                                .doctorSlot
                                                                .chamber
                                                                .user
                                                                .userId
                                                                .toString(),
                                                            patientID: context
                                                                .read(
                                                                    userProvider)
                                                                .currentUser()
                                                                .userId
                                                                .toString()),
                                                        builder: (context,
                                                            snapshot) {
                                                          switch (snapshot
                                                              .connectionState) {
                                                            case ConnectionState
                                                                .waiting:
                                                              return Icon(
                                                                Icons
                                                                    .chat_bubble_rounded,
                                                                color: Colors
                                                                    .white,
                                                                size: space *
                                                                    0.06,
                                                              );
                                                            default:
                                                              if (snapshot
                                                                  .hasError) {
                                                                return Icon(
                                                                  Icons
                                                                      .chat_bubble_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                  size: space *
                                                                      0.06,
                                                                );
                                                              } else {
                                                                final messages =
                                                                    snapshot
                                                                        .data;
                                                                return messages
                                                                        .isEmpty
                                                                    ? Icon(
                                                                        Icons
                                                                            .chat_bubble_rounded,
                                                                        color: Colors
                                                                            .white,
                                                                        size: space *
                                                                            0.06,
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .chat_bubble_rounded,
                                                                        color: Colors
                                                                            .yellowAccent,
                                                                        size: space *
                                                                            0.06,
                                                                      );
                                                              }
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: space * 0.01,
                                                      ),
                                                      Text(
                                                        "Send Messages",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: space * 0.12,
                                          width: space * 0.9,
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
                                                          ReportsListScreen(
                                                        appointment:
                                                            widget.appointment,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: space * 0.09,
                                                  width: space * 0.4,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: space * 0.01),
                                                  decoration: BoxDecoration(
                                                      color: Colors.brown,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
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
                                                      Expanded(
                                                        child: Text(
                                                          "Previous Prescription",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: space * 0.02,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SampleListScreen(
                                                        appointment:
                                                            widget.appointment,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: space * 0.09,
                                                  width: space * 0.4,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: space * 0.01),
                                                  decoration: BoxDecoration(
                                                      color: Colors.teal,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
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
                                                        "Disease Photo",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Container(
                                        //   height: space * 0.12,
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.center,
                                        //     children: [
                                        //       Container(
                                        //         height: space * 0.09,
                                        //         decoration: BoxDecoration(
                                        //             color: Color(0xFF00BABA),
                                        //             borderRadius:
                                        //                 BorderRadius.circular(
                                        //                     10)),
                                        //         child: Container(
                                        //           height: space * 0.15,
                                        //           alignment: Alignment.center,
                                        //           padding: EdgeInsets.symmetric(
                                        //               horizontal: 10),
                                        //           child: Center(
                                        //             child: RichText(
                                        //               text: TextSpan(
                                        //                   text: DateFormat.E()
                                        //                       .format(widget
                                        //                           .appointment
                                        //                           .doctorSlot
                                        //                           .startTime),
                                        //                   style: TextStyle(
                                        //                       fontSize: 16,
                                        //                       height: 1.5,
                                        //                       color:
                                        //                           Colors.white),
                                        //                   children: [
                                        //                     TextSpan(
                                        //                         text:
                                        //                             ' ${DateFormat.d().format(widget.appointment.doctorSlot.startTime)}',
                                        //                         style: TextStyle(
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .bold))
                                        //                   ]),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       SizedBox(
                                        //         width: space * 0.05,
                                        //       ),
                                        //       Container(
                                        //         height: space * 0.09,
                                        //         decoration: BoxDecoration(
                                        //             color: Colors.green,
                                        //             borderRadius:
                                        //                 BorderRadius.circular(
                                        //                     10)),
                                        //         child: Container(
                                        //           height: space * 0.15,
                                        //           alignment: Alignment.center,
                                        //           padding: EdgeInsets.symmetric(
                                        //               horizontal: 10),
                                        //           child: Center(
                                        //               child: Text(
                                        //             "${DateFormat.jm().format(widget.appointment.doctorSlot.startTime)}-${DateFormat.jm().format(widget.appointment.doctorSlot.endTime)}",
                                        //             style: TextStyle(
                                        //                 fontWeight:
                                        //                     FontWeight.bold,
                                        //                 fontSize: 16,
                                        //                 color: Colors.white),
                                        //           )),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: space * 0.05,
                                ),
                              ],
                            ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${DateFormat.yMd().format(widget.appointment.doctorSlot.startTime)}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: space * 0.02,
                                      ),
                                      Text(
                                        "${DateFormat.jm().format(widget.appointment.doctorSlot.startTime)} ",
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
                        (widget.appointment.originalUser ||
                                widget.appointment.originalUser == null)
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xFF000000).withOpacity(0.1),
                                        offset: Offset.fromDirection(1),
                                        blurRadius: 10,
                                        spreadRadius: 1)
                                  ],
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Patient Details",
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "Age",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "Weight",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "Gender",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "Blood Group",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: space * 0.05,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${context.read(userProvider).currentUser().name}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "${context.read(userProvider).currentUser().age ?? ""}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "${context.read(userProvider).currentUser().weight ?? ""}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "${context.read(userProvider).currentUser().gender ?? ""}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "${context.read(userProvider).currentUser().bloodGroup ?? ""}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xFF000000).withOpacity(0.1),
                                        offset: Offset.fromDirection(1),
                                        blurRadius: 10,
                                        spreadRadius: 1)
                                  ],
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Patient Details",
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "Age",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "Weight",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "Gender",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "Blood Group",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: space * 0.05,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${widget.appointment.friendlyUserName}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "${widget.appointment.friendlyUserAge ?? ""}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "${widget.appointment.friendlyUserWeight ?? ""}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "${widget.appointment.friendlyUserGender ?? ""}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "${widget.appointment.friendlyUserBloodGroup ?? ""}",
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
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: space * 0.3,
                                width: space * 0.3,
                                color: Colors.blueAccent,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
