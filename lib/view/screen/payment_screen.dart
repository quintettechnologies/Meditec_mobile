import 'dart:convert';

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:meditec/model/appointment.dart';
import 'package:meditec/model/doctor.dart';
import 'package:meditec/model/doctorSlot.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/doctors_provider.dart';
import 'package:meditec/view/screen/appointents_list_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:meditec/providers/user_provider.dart';

import 'callscreens/pickup/pickup_layout.dart';

class PaymentScreen extends StatefulWidget {
  static const String id = 'doctor_profile_screen';

  PaymentScreen({@required this.doctor, @required this.doctorSlot});

  final User doctor;
  final DoctorSlot doctorSlot;
  @override
  _PaymentScreenScreenState createState() => _PaymentScreenScreenState();
}

class _PaymentScreenScreenState extends State<PaymentScreen> {
  Appointment appointment = Appointment();
  bool forFNF = false;
  TextEditingController nameController;
  TextEditingController ageController;
  TextEditingController weightController;
  TextEditingController bloodGroupController;
  TextEditingController genderController;
  FocusNode nameFocus;
  FocusNode ageFocus;
  FocusNode weightFocus;
  FocusNode bloodGroupFocus;
  FocusNode genderFocus;

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController();
    ageController = TextEditingController();
    weightController = TextEditingController();
    bloodGroupController = TextEditingController();
    genderController = TextEditingController();
    nameFocus = FocusNode();
    ageFocus = FocusNode();
    weightFocus = FocusNode();
    bloodGroupFocus = FocusNode();
    genderFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    ageController.dispose();
    weightController.dispose();
    bloodGroupController.dispose();
    genderController.dispose();
    nameFocus.dispose();
    ageFocus.dispose();
    weightFocus.dispose();
    bloodGroupFocus.dispose();
    genderFocus.dispose();
    super.dispose();
  }

  setAppointment(User user) {
    appointment.user = user;
    appointment.doctorSlot = widget.doctorSlot;
    if (forFNF) {
      appointment.originalUser = false;
      appointment.friendlyUserName = nameController.text.trim();
      appointment.friendlyUserAge = int.tryParse(ageController.text.trim());
      appointment.friendlyUserWeight =
          double.tryParse(weightController.text.trim());
      appointment.friendlyUserBloodGroup = bloodGroupController.text.trim();
      appointment.friendlyUserGender = genderController.text.trim();
    } else {
      appointment.originalUser = true;
      appointment.friendlyUserName = null;
      appointment.friendlyUserAge = null;
      appointment.friendlyUserWeight = null;
      appointment.friendlyUserBloodGroup = null;
      appointment.friendlyUserGender = null;
    }
  }

  bool validate() {
    if (forFNF) {
      if (appointment.friendlyUserName == null ||
          appointment.friendlyUserName == "") {
        Fluttertoast.showToast(
            msg: "Patient Name Cannot Be Empty!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else if (appointment.friendlyUserAge == null ||
          appointment.friendlyUserAge == 0) {
        Fluttertoast.showToast(
            msg: "Patient Age Cannot Be Empty!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else if (appointment.friendlyUserWeight == null ||
          appointment.friendlyUserWeight == 0) {
        Fluttertoast.showToast(
            msg: "Patient Weight Cannot Be Empty!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else if (appointment.friendlyUserBloodGroup == null ||
          appointment.friendlyUserBloodGroup == "") {
        Fluttertoast.showToast(
            msg: "Patient Blood Group Cannot Be Empty!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else if (appointment.friendlyUserGender == null ||
          appointment.friendlyUserGender == "") {
        Fluttertoast.showToast(
            msg: "Patient Gender Cannot Be Empty!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    final User user = context.read(userProvider).currentUser();
    return PickupLayout(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyCustomAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: space * 0.01, horizontal: space * 0.05),
              child: Consumer(
                builder: (context, watch, child) {
                  List<Doctor> doctors = watch(doctorsProvider);
                  return Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.doctor.name,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.doctor.categories[0].name,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        widget.doctor.degree.degreeName,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        widget.doctor.hospitalName ?? "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Container(
                                        height: space * 0.12,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: space * 0.09,
                                              width: space * 0.09,
                                              decoration: BoxDecoration(
                                                  color: Colors.deepOrange,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Icon(
                                                Icons.videocam,
                                                color: Colors.white,
                                                size: space * 0.06,
                                              ),
                                            ),
                                            SizedBox(
                                              width: space * 0.05,
                                            ),
                                            Container(
                                              height: space * 0.09,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF00BABA),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Container(
                                                height: space * 0.15,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Center(
                                                  child: RichText(
                                                    text: TextSpan(
                                                        text: DateFormat.E()
                                                            .format(widget
                                                                .doctorSlot
                                                                .startTime),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            height: 1.5,
                                                            color:
                                                                Colors.white),
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                                  ' ${DateFormat.d().format(widget.doctorSlot.startTime)}',
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
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Container(
                                                height: space * 0.15,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Center(
                                                    child: Text(
                                                  "${DateFormat.jm().format(widget.doctorSlot.startTime)}-${DateFormat.jm().format(widget.doctorSlot.endTime)}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Appointment Details",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                              color: Color(0xFF00BABA),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
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
                                            "${DateFormat.yMd().format(widget.doctorSlot.startTime)}",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: space * 0.02,
                                          ),
                                          Text(
                                            "${DateFormat.jm().format(widget.doctorSlot.startTime)} ",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: space * 0.02,
                                          ),
                                          Text(
                                            widget.doctorSlot.fees.toString(),
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: space * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "For Someone Else",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                CustomSwitch(
                                  activeColor: Colors.green,
                                  value: forFNF,
                                  onChanged: (value) {
                                    print("VALUE : $value");
                                    setState(() {
                                      forFNF = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: space * 0.05,
                            ),
                            forFNF
                                ? Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.1),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Patient Details",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            TextEditingField(
                                              text: "Name",
                                              space: space,
                                              controller: nameController,
                                              focusNode: nameFocus,
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            TextEditingField(
                                              text: "Age",
                                              space: space,
                                              controller: ageController,
                                              focusNode: ageFocus,
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            TextEditingField(
                                              text: "Weight",
                                              space: space,
                                              controller: weightController,
                                              focusNode: weightFocus,
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            TextEditingField(
                                              text: "Blood Group",
                                              space: space,
                                              controller: bloodGroupController,
                                              focusNode: bloodGroupFocus,
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            TextEditingField(
                                              text: "Gender",
                                              space: space,
                                              controller: genderController,
                                              focusNode: genderFocus,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: space * 0.05,
                                      ),
                                    ],
                                  )
                                : Container(),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payment via',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: space * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.1),
                                                offset: Offset.fromDirection(1),
                                                blurRadius: 10,
                                                spreadRadius: 1)
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10),
                                        height: space * 0.18,
                                        width: space * 0.25,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/payments/bkash.png'),
                                        ),
                                      ),
                                      Container(
                                        height: space * 0.18,
                                        width: space * 0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.1),
                                                offset: Offset.fromDirection(1),
                                                blurRadius: 10,
                                                spreadRadius: 1)
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/payments/nagad.png'),
                                        ),
                                      ),
                                      Container(
                                        height: space * 0.18,
                                        width: space * 0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.1),
                                                offset: Offset.fromDirection(1),
                                                blurRadius: 10,
                                                spreadRadius: 1)
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/payments/rocket.png'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: space * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.1),
                                                offset: Offset.fromDirection(1),
                                                blurRadius: 10,
                                                spreadRadius: 1)
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10),
                                        height: space * 0.18,
                                        width: space * 0.25,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/payments/visa.png'),
                                        ),
                                      ),
                                      Container(
                                          height: space * 0.18,
                                          width: space * 0.25,
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
                                          padding: EdgeInsets.all(20),
                                          child: SvgPicture.asset(
                                            'assets/images/payments/mastercard.svg',
                                          )),
                                      Container(
                                        height: space * 0.18,
                                        width: space * 0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.1),
                                                offset: Offset.fromDirection(1),
                                                blurRadius: 10,
                                                spreadRadius: 1)
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/payments/nexuspay.png'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: space * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    setAppointment(user);
                                    bool valid = validate();
                                    if (valid) {
                                      String status = await context
                                          .read(userProvider)
                                          .bookAppointmentPayLater(appointment);
                                      if (status == "success") {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Appointment booked successfully!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Navigator.pushNamed(
                                            context, AppointmentsScreen.id);
                                      } else if (status == "taken") {
                                        Fluttertoast.showToast(
                                            msg:
                                                "You have already booked an appointment at this time slot.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else if (status == "overloaded") {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Sorry this time slot is already full.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Sorry, failed to book an appointment",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: space * .12,
                                    width: space * 0.36,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF00BABA),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Pay Later",
                                        style: TextStyle(
                                            fontSize: space * 0.04,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    setAppointment(user);
                                    bool valid = validate();
                                    if (valid) {
                                      String status = await context
                                          .read(userProvider)
                                          .bookAppointment(appointment);
                                      if (status == "success") {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Appointment booked successfully!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Navigator.pushNamed(
                                            context, AppointmentsScreen.id);
                                      } else if (status == "taken") {
                                        Fluttertoast.showToast(
                                            msg:
                                                "You have already booked an appointment at this time slot.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else if (status == "overloaded") {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Sorry this time slot is already full.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Sorry, failed to book an appointment",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: space * .12,
                                    width: space * 0.36,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF00BABA),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Make Payment",
                                        style: TextStyle(
                                            fontSize: space * 0.04,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: space * 0.1,
                            ),
                          ],
                        ),
                        Center(
                          child: (widget.doctor.userAvatar != null)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: space * 0.3,
                                    width: space * 0.3,
                                    child: Image(
                                      image: Image.memory(base64.decode(
                                              widget.doctor.userAvatar.image))
                                          .image,
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MyCustomFAB(),
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

class TextEditingField extends StatelessWidget {
  TextEditingField(
      {@required this.text,
      @required this.controller,
      @required this.space,
      @required this.focusNode});

  final double space;
  final TextEditingController controller;
  final String text;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: space * 0.1,
          width: space * 0.5,
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
