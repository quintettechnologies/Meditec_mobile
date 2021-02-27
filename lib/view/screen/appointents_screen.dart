import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:meditec/model/appointment.dart';
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

class AppointmentsScreen extends StatefulWidget {
  static const String id = 'AppointmentsScreen';
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    context.read(userProvider).getAppointments();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    List<Appointment> appointments = context.read(userProvider).appointments;
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
                  'Appointments',
                  style: TextStyle(
                      fontSize: space * 0.05, color: kPrimaryTextColor),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      for (Appointment appointment in appointments)
                        Container(
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
                              (appointment.doctorSlot.user.userAvatar != null)
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: space * 0.17,
                                          width: space * 0.17,
                                          child: Image(
                                            image: Image.memory(base64.decode(
                                                    appointment.doctorSlot.user
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
                                      appointment.doctorSlot.user.name,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      appointment
                                          .doctorSlot.user.categories[0].name,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      appointment.doctorSlot.chamber.name,
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
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date: ${DateFormat.yMEd().format(appointment.doctorSlot.startTime)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "Start: ${DateFormat.jm().format(appointment.doctorSlot.startTime)} ",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "End: ${DateFormat.jm().format(appointment.doctorSlot.endTime)}",
                                      // .substring(11, 16),
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
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
      floatingActionButton: MyCustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
