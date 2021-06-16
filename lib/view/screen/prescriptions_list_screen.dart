import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:meditec/model/appointment.dart';
import 'package:meditec/model/index.dart';
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
import 'package:meditec/constants.dart';
import 'callscreens/pickup/pickup_layout.dart';

class PrescriptionListScreen extends StatefulWidget {
  static const String id = 'PrescriptionListScreen';
  @override
  _PrescriptionListScreenState createState() => _PrescriptionListScreenState();
}

class _PrescriptionListScreenState extends State<PrescriptionListScreen> {
  bool loading = false;
  List<Appointment> appointments = [];
  List<Appointment> appointmentsDisplay = [];
  @override
  void initState() {
    // TODO: implement initState
    loadAppointments();
    super.initState();
  }

  loadAppointments() async {
    appointments = context.read(userProvider).appointments;
    if (appointments.isEmpty) {
      await fetchAppointments();
    }
    filterAppointments();
  }

  fetchAppointments() async {
    setState(() {
      loading = true;
    });
    await context.read(userProvider).getAppointments().then((value) {
      appointments = context.read(userProvider).appointments;
      setState(() {
        loading = false;
      });
    });
  }

  filterAppointments() {
    appointmentsDisplay.clear();
    for (Appointment appointment in appointments) {
      if (appointment.prescriptionExist) {
        appointmentsDisplay.add(appointment);
      }
    }
    setState(() {});
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
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: space * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Prescriptions',
                            style: TextStyle(
                                fontSize: space * 0.05,
                                color: kPrimaryTextColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            for (Appointment appointment in appointmentsDisplay)
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  bool get = await context
                                      .read(userProvider)
                                      .getFullPrescription(appointment.id);
                                  if (get) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PrescriptionPage(
                                                  prescription: context
                                                      .read(userProvider)
                                                      .prescriptionTemp,
                                                )));
                                  } else {
                                    setState(() {
                                      loading = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Sorry, not prescribed yet.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xFF000000)
                                              .withOpacity(0.1),
                                          offset: Offset.fromDirection(1),
                                          blurRadius: 10,
                                          spreadRadius: 1)
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      (appointment.doctorSlot.chamber.user
                                                  .userAvatar !=
                                              null)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  height: space * 0.17,
                                                  width: space * 0.17,
                                                  child: Image(
                                                    image: Image.memory(base64
                                                            .decode(appointment
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
                                                  const EdgeInsets.all(8.0),
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
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              appointment
                                                  .doctorSlot.chamber.user.name,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              appointment.doctorSlot.chamber
                                                  .user.speciality.speciality,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              appointment
                                                  .doctorSlot.chamber.name,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                      appointmentsDisplay.isEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'You have no prescriptions.',
                                  style: TextStyle(
                                      fontSize: space * 0.04,
                                      color: kPrimaryTextColor),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
                loading
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: space,
                        color: Colors.white,
                        child: Center(
                          child: SpinKitCircle(
                            color: Color(0xFF00BABA),
                            size: 50,
                          ),
                        ),
                      )
                    : Container()
              ],
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
          backgroundColor: Color(0xFF00BABA),
          onPressed: () async {
            await fetchAppointments();
            filterAppointments();
          },
          child: Icon(
            Icons.refresh,
            size: 40,
          ),
        ),
        bottomNavigationBar: MyCustomNavBar(),
      ),
    );
  }
}
