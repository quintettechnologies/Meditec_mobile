import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/doctor.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/doctors_provider.dart';
import 'package:meditec/view/screen/video_call_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customFAB.dart';

class PaymentScreen extends HookWidget {
  static const String id = 'doctor_profile_screen';

  PaymentScreen({@required this.doctor});

  final User doctor;

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Scaffold(
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      doctor.name,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      doctor.categories[0].name,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      doctor.degree.degreeName,
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
                                                    BorderRadius.circular(10)),
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
                                                    BorderRadius.circular(10)),
                                            child: Container(
                                              height: space * 0.15,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Center(
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: 'Sun',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.white),
                                                      children: [
                                                        TextSpan(
                                                            text: ' 06',
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
                                                "10-10.30am",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Appointment Details",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: Color(0xFF00BABA),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
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
                                          "12th Jan",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: space * 0.02,
                                        ),
                                        Text(
                                          "11:00 AM",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: space * 0.02,
                                        ),
                                        Text(
                                          "500.00BDT",
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
                                                offset: Offset.fromDirection(1),
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
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoCall(
                                            doctor: doctor,
                                          )));
                            },
                            padding: EdgeInsets.zero,
                            child: Container(
                              height: space * .12,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xFF00BABA),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Make Payment",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: space * 0.1,
                          ),
                        ],
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: space * 0.3,
                            width: space * 0.3,
                            child: Image(
                              image: Image.memory(
                                      base64.decode(doctor.userAvatar.image))
                                  .image,
                            ),
                          ),
                        ),
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
    );
  }
}

class myCustomDayButton extends StatelessWidget {
  const myCustomDayButton({
    Key key,
    @required this.space,
    @required this.day,
    @required this.date,
    this.selected = false,
  }) : super(key: key);

  final double space;
  final String day;
  final String date;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: space * 0.12,
      height: space * 0.15,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: selected ? Color(0xFF3C4858) : Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
                fontSize: 16, color: selected ? Colors.white : Colors.black87),
          ),
          Text(
            date,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black87),
          ),
        ],
      ),
    );
  }
}
