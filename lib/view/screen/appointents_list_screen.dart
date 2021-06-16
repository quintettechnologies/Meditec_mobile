import 'dart:convert';
import 'package:meditec/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:meditec/model/appointment.dart';
import 'package:meditec/model/category.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/appointment_detail_screen.dart';
import 'package:meditec/view/screen/doctor_screen.dart';
import 'package:meditec/view/screen/prescription_page.dart';
import 'package:meditec/view/widget/catagoryButton.dart';
import 'package:meditec/view/widget/catagoryButtonDashboard.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'callscreens/pickup/pickup_layout.dart';
import 'confirm_payment_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  static const String id = 'AppointmentsScreen';
  AppointmentsScreen({this.reload = false});

  final bool reload;
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  ProgressDialog pr;
  List<Appointment> appointments = [];
  @override
  void initState() {
    // TODO: implement initState
    loadAppointments();
    super.initState();
  }

  loadAppointments() async {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.rtl,
      isDismissible: true,
    );
    pr.style(
      message: 'Loading your appointments',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: SpinKitCircle(
        color: Color(0xFF00BABA),
        size: 50.0,
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 19.0,
      ),
    );
    appointments = context.read(userProvider).appointments;
    if (appointments.isEmpty || widget.reload) {
      await fetchAppointments();
    }
  }

  fetchAppointments() async {
    await pr.show();
    await context.read(userProvider).getAppointments().then((value) {
      appointments = context.read(userProvider).appointments;
      setState(() {});
    });
    await pr.hide();
  }

  String buildCategories(List<Category> categories) {
    String category = "";
    if (categories.length == 1) {
      category = categories[0].name;
      return category;
    } else if (categories.length > 1) {
      // for (Category cat in categories) {
      //   category = category + cat.name + " ";
      // }
      for (int i = 0; i < categories.length; i++) {
        if (i == categories.length - 1) {
          category = category + categories[i].name;
        } else {
          category = category + categories[i].name + ", ";
        }
      }
      return category;
    } else {
      return category;
    }
  }

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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: space * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Appointments',
                    style: TextStyle(
                        fontSize: space * 0.05, color: kPrimaryTextColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // SingleChildScrollView(
                  //   child: Column(
                  //     children: [
                  //       for (Appointment appointment in appointments)
                  //         FlatButton(
                  //           onPressed: (appointment.status != "Payment Pending")
                  //               ? () {
                  //                   Navigator.push(
                  //                       context,
                  //                       MaterialPageRoute(
                  //                           builder: (context) =>
                  //                               AppointmentDetailScreen(
                  //                                 appointment: appointment,
                  //                               )));
                  //                 }
                  //               : () {
                  //                   Navigator.push(
                  //                       context,
                  //                       MaterialPageRoute(
                  //                           builder: (context) =>
                  //                               ConfirmPaymentScreen(
                  //                                 appointment: appointment,
                  //                               )));
                  //                 },
                  //           padding: EdgeInsets.zero,
                  //           child: Container(
                  //             margin: EdgeInsets.all(5),
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(10),
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                     color: Color(0xFF000000).withOpacity(0.1),
                  //                     offset: Offset.fromDirection(1),
                  //                     blurRadius: 10,
                  //                     spreadRadius: 1)
                  //               ],
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               children: [
                  //                 (appointment.doctorSlot.chamber.user
                  //                             .userAvatar !=
                  //                         null)
                  //                     ? Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: ClipRRect(
                  //                           borderRadius:
                  //                               BorderRadius.circular(10),
                  //                           child: Container(
                  //                             height: space * 0.17,
                  //                             width: space * 0.17,
                  //                             child: Image(
                  //                               image: Image.memory(base64.decode(
                  //                                       appointment
                  //                                           .doctorSlot
                  //                                           .chamber
                  //                                           .user
                  //                                           .userAvatar
                  //                                           .image))
                  //                                   .image,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       )
                  //                     : Container(),
                  //                 SizedBox(
                  //                   width: space * 0.02,
                  //                 ),
                  //                 Expanded(
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                         appointment
                  //                             .doctorSlot.chamber.user.name,
                  //                         style: TextStyle(
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                       Text(
                  //                         appointment.doctorSlot.chamber.user
                  //                             .categories[0].name,
                  //                         style: TextStyle(fontSize: 12),
                  //                       ),
                  //                       Text(
                  //                         appointment.doctorSlot.chamber.name,
                  //                         style: TextStyle(
                  //                           fontSize: 12,
                  //                         ),
                  //                       ),
                  //
                  //                       // Text(doctors[index].hospital,
                  //                       //     style: TextStyle(
                  //                       //         fontSize: 13,
                  //                       //         fontWeight: FontWeight.w500)),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: space * 0.02,
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Column(
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                         "Date: ${DateFormat.yMEd().format(appointment.doctorSlot.startTime)}",
                  //                         style: TextStyle(
                  //                           fontSize: 14,
                  //                         ),
                  //                       ),
                  //                       Text(
                  //                         "Start: ${DateFormat.jm().format(appointment.time)} ",
                  //                         style: TextStyle(
                  //                           fontSize: 14,
                  //                         ),
                  //                       ),
                  //                       Text(
                  //                         "${appointment.status}",
                  //                         style: TextStyle(
                  //                             fontSize: 12,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //     ],
                  //   ),
                  // ),
                  DefaultTabController(
                    length: 3, // length of tabs
                    initialIndex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                            indicator: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFF495767),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Container(
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                height: space * 0.1,
                                alignment: Alignment.center,
                              ),
                              Container(
                                child: Text(
                                  'Confirmed',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                height: space * 0.1,
                                alignment: Alignment.center,
                              ),
                              Container(
                                child: Text(
                                  'Pending',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                height: space * 0.1,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height *
                              0.65, //height of TabBarView
                          // decoration: BoxDecoration(
                          //     border: Border(
                          //         top: BorderSide(
                          //             color: Colors.grey, width: 0.5))),
                          child: TabBarView(
                            children: <Widget>[
                              Container(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (Appointment appointment
                                          in appointments)
                                        FlatButton(
                                          onPressed: (appointment.status !=
                                                  "Payment Pending")
                                              ? () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AppointmentDetailScreen(
                                                                appointment:
                                                                    appointment,
                                                              )));
                                                }
                                              : () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ConfirmPaymentScreen(
                                                                appointment:
                                                                    appointment,
                                                              )));
                                                },
                                          padding: EdgeInsets.zero,
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(0xFF000000)
                                                        .withOpacity(0.1),
                                                    offset:
                                                        Offset.fromDirection(1),
                                                    blurRadius: 10,
                                                    spreadRadius: 1)
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                (appointment.doctorSlot.chamber
                                                            .user.userAvatar !=
                                                        null)
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Container(
                                                            height:
                                                                space * 0.17,
                                                            width: space * 0.17,
                                                            child: Image(
                                                              image: Image.memory(base64.decode(appointment
                                                                      .doctorSlot
                                                                      .chamber
                                                                      .user
                                                                      .userAvatar
                                                                      .image))
                                                                  .image,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          height: space * 0.17,
                                                          width: space * 0.17,
                                                        ),
                                                      ),
                                                SizedBox(
                                                  width: space * 0.02,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        appointment.doctorSlot
                                                            .chamber.user.name,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        buildCategories(
                                                            appointment
                                                                .doctorSlot
                                                                .chamber
                                                                .user
                                                                .categories),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        appointment.doctorSlot
                                                            .chamber.name,
                                                        style: TextStyle(
                                                          fontSize: 12,
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Date: ${intl.DateFormat.yMEd().format(appointment.doctorSlot.startTime)}",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Start: ${intl.DateFormat.jm().format(appointment.doctorSlot.startTime)} ",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: (appointment
                                                                            .status ==
                                                                        "Payment Complete")
                                                                    ? Colors
                                                                        .green
                                                                    : (appointment.status ==
                                                                            "Complete")
                                                                        ? Color(
                                                                            0xFF00BABA)
                                                                        : Colors
                                                                            .deepOrange,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        padding: EdgeInsets.all(
                                                            space * 0.01),
                                                        child: Text(
                                                          "${appointment.status}",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (Appointment appointment
                                          in appointments)
                                        (appointment.status ==
                                                "Payment Complete")
                                            ? FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AppointmentDetailScreen(
                                                                appointment:
                                                                    appointment,
                                                              )));
                                                },
                                                padding: EdgeInsets.zero,
                                                child: Container(
                                                  margin: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color(
                                                                  0xFF000000)
                                                              .withOpacity(0.1),
                                                          offset: Offset
                                                              .fromDirection(1),
                                                          blurRadius: 10,
                                                          spreadRadius: 1)
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      (appointment
                                                                  .doctorSlot
                                                                  .chamber
                                                                  .user
                                                                  .userAvatar !=
                                                              null)
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      space *
                                                                          0.17,
                                                                  width: space *
                                                                      0.17,
                                                                  child: Image(
                                                                    image: Image.memory(base64.decode(appointment
                                                                            .doctorSlot
                                                                            .chamber
                                                                            .user
                                                                            .userAvatar
                                                                            .image))
                                                                        .image,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height: space *
                                                                    0.17,
                                                                width: space *
                                                                    0.17,
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        width: space * 0.02,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              appointment
                                                                  .doctorSlot
                                                                  .chamber
                                                                  .user
                                                                  .name,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              buildCategories(
                                                                  appointment
                                                                      .doctorSlot
                                                                      .chamber
                                                                      .user
                                                                      .categories),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              appointment
                                                                  .doctorSlot
                                                                  .chamber
                                                                  .name,
                                                              style: TextStyle(
                                                                fontSize: 12,
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Date: ${intl.DateFormat.yMEd().format(appointment.doctorSlot.startTime)}",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Start: ${intl.DateFormat.jm().format(appointment.doctorSlot.startTime)} ",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: (appointment.status == "Payment Complete")
                                                                      ? (appointment.status == "Complete")
                                                                          ? Color(0xFFBABA)
                                                                          : Colors.green
                                                                      : Colors.deepOrange,
                                                                  borderRadius: BorderRadius.circular(5)),
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      space *
                                                                          0.01),
                                                              child: Text(
                                                                "${appointment.status}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container()
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (Appointment appointment
                                          in appointments)
                                        (appointment.status ==
                                                "Payment Pending")
                                            ? FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ConfirmPaymentScreen(
                                                                appointment:
                                                                    appointment,
                                                              )));
                                                },
                                                padding: EdgeInsets.zero,
                                                child: Container(
                                                  margin: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color(
                                                                  0xFF000000)
                                                              .withOpacity(0.1),
                                                          offset: Offset
                                                              .fromDirection(1),
                                                          blurRadius: 10,
                                                          spreadRadius: 1)
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      (appointment
                                                                  .doctorSlot
                                                                  .chamber
                                                                  .user
                                                                  .userAvatar !=
                                                              null)
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      space *
                                                                          0.17,
                                                                  width: space *
                                                                      0.17,
                                                                  child: Image(
                                                                    image: Image.memory(base64.decode(appointment
                                                                            .doctorSlot
                                                                            .chamber
                                                                            .user
                                                                            .userAvatar
                                                                            .image))
                                                                        .image,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height: space *
                                                                    0.17,
                                                                width: space *
                                                                    0.17,
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        width: space * 0.02,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              appointment
                                                                  .doctorSlot
                                                                  .chamber
                                                                  .user
                                                                  .name,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              buildCategories(
                                                                  appointment
                                                                      .doctorSlot
                                                                      .chamber
                                                                      .user
                                                                      .categories),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              appointment
                                                                  .doctorSlot
                                                                  .chamber
                                                                  .name,
                                                              style: TextStyle(
                                                                fontSize: 12,
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Date: ${intl.DateFormat.yMEd().format(appointment.doctorSlot.startTime)}",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Start: ${intl.DateFormat.jm().format(appointment.doctorSlot.startTime)} ",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: (appointment.status == "Payment Complete")
                                                                      ? (appointment.status == "Complete")
                                                                          ? Color(0xFFBABA)
                                                                          : Colors.green
                                                                      : Colors.deepOrange,
                                                                  borderRadius: BorderRadius.circular(5)),
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      space *
                                                                          0.01),
                                                              child: Text(
                                                                "${appointment.status}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container()
                                    ],
                                  ),
                                ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await fetchAppointments();
          },
          backgroundColor: Color(0xFF00BABA),
          child: Center(
            child: Icon(
              Icons.refresh,
              size: 40,
            ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MyCustomNavBar(),
      ),
    );
  }
}
