import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:meditec/model/chamber.dart';
import 'package:meditec/model/doctor.dart';
import 'package:meditec/model/doctorSlot.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/doctors_provider.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/payment_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customFAB.dart';

class DoctorProfileScreen extends StatefulWidget {
  static const String id = 'doctor_profile_screen';

  DoctorProfileScreen({@required this.doctor});

  final User doctor;
  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Chamber> chambers = widget.doctor.chambers;
    List<DoctorSlot> doctorSlots = context.read(userProvider).doctorSlots;
    DoctorSlot selectedSlot = context.read(userProvider).selectedSlot;
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: space * 0.03,
                      ),
                      Row(
                        children: [
                          (widget.doctor.userAvatar != null)
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
                          SizedBox(
                            width: space * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.doctor.name,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.doctor.categories[0].name,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                height: space * 0.12,
                                width: space * 0.43,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: space * 0.09,
                                      width: space * 0.09,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.chat_bubble_rounded,
                                        color: Colors.white,
                                        size: space * 0.06,
                                      ),
                                    ),
                                    SizedBox(
                                      width: space * 0.05,
                                    ),
                                    Container(
                                      height: space * 0.09,
                                      width: space * 0.09,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: space * 0.06,
                                      ),
                                    ),
                                    SizedBox(
                                      width: space * 0.01,
                                    ),
                                  ],
                                ),
                              ),
                              // Text(
                              //   "Fee - 500",
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: space * 0.08,
                      ),
                      // Container(
                      //   height: space * 0.15,
                      //   alignment: Alignment.center,
                      //   child: RichText(
                      //     overflow: TextOverflow.clip,
                      //     text: TextSpan(
                      //       text:
                      //           "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
                      //       style: TextStyle(
                      //           fontSize: 13,
                      //           height: 1.5,
                      //           color: Colors.black87),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: space * 0.05,
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Today 05 Sept 2020',
                      //       style: TextStyle(
                      //           fontSize: 16, fontWeight: FontWeight.bold),
                      //     ),
                      //     Icon(Icons.keyboard_arrow_down)
                      //   ],
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       myCustomDayButton(
                      //         space: space,
                      //         day: 'Sat',
                      //         date: '05',
                      //       ),
                      //       myCustomDayButton(
                      //         space: space,
                      //         day: 'Sun',
                      //         date: '06',
                      //         selected: true,
                      //       ),
                      //       myCustomDayButton(
                      //         space: space,
                      //         day: 'Mon',
                      //         date: '07',
                      //       ),
                      //       myCustomDayButton(
                      //         space: space,
                      //         day: 'Tue',
                      //         date: '08',
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Container(
                      //       alignment: Alignment.center,
                      //       height: space * 0.1,
                      //       width: space * 0.25,
                      //       decoration: BoxDecoration(
                      //           color: Color(0xFFC5C5C5),
                      //           borderRadius: BorderRadius.circular(50)),
                      //       child: Text(
                      //         "09 - 9.30am",
                      //         style: TextStyle(
                      //             fontSize: 14, color: Color(0xFF8D8D8D)),
                      //       ),
                      //     ),
                      //     Container(
                      //       alignment: Alignment.center,
                      //       height: space * 0.1,
                      //       width: space * 0.25,
                      //       decoration: BoxDecoration(
                      //           color: Color(0xFFDDFDE1),
                      //           borderRadius: BorderRadius.circular(50)),
                      //       child: Text(
                      //         "10 - 10.30am",
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.bold,
                      //             color: Color(0xFF495767)),
                      //       ),
                      //     ),
                      //     Container(
                      //       alignment: Alignment.center,
                      //       height: space * 0.1,
                      //       width: space * 0.25,
                      //       decoration: BoxDecoration(
                      //           color: Color(0xFFC5C5C5),
                      //           borderRadius: BorderRadius.circular(50)),
                      //       child: Text(
                      //         "11 - 11.30am",
                      //         style: TextStyle(
                      //             fontSize: 14, color: Color(0xFF8D8D8D)),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: space * 0.05,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     SizedBox(
                      //       width: space * 0.05,
                      //     ),
                      //     Container(
                      //       alignment: Alignment.center,
                      //       height: space * 0.1,
                      //       width: space * 0.25,
                      //       decoration: BoxDecoration(
                      //           color: Color(0xFFDDFDE1),
                      //           borderRadius: BorderRadius.circular(50)),
                      //       child: Text(
                      //         "07 - 7.30pm",
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.bold,
                      //             color: Color(0xFF495767)),
                      //       ),
                      //     ),
                      //     Container(
                      //       alignment: Alignment.center,
                      //       height: space * 0.1,
                      //       width: space * 0.25,
                      //       decoration: BoxDecoration(
                      //           color: Color(0xFFC5C5C5),
                      //           borderRadius: BorderRadius.circular(50)),
                      //       child: Text(
                      //         "08 - 8.30pm",
                      //         style: TextStyle(
                      //             fontSize: 14, color: Color(0xFF8D8D8D)),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: space * 0.05,
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: space * 0.05,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Chambers",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: space * 0.02,
                      ),
                      Column(
                        children: [
                          for (Chamber chamber in chambers)
                            Padding(
                              padding: EdgeInsets.only(bottom: space * 0.05),
                              child: FlatButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    bool list = await context
                                        .read(userProvider)
                                        .getDoctorSlots(chamber.id.toString());
                                    if (list) {
                                      setState(() {
                                        doctorSlots = context
                                            .read(userProvider)
                                            .doctorSlots;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: space * 0.8,
                                    height: space * 0.2,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              chamber.name,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              chamber.adress,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            //Text(chamber.address),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Slots",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: space * 0.02,
                      ),
                      Column(
                        children: [
                          for (DoctorSlot doctorSlot in doctorSlots)
                            Padding(
                              padding: EdgeInsets.only(bottom: space * 0.05),
                              child: FlatButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    context
                                        .read(userProvider)
                                        .selectSlot(doctorSlot);
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: space * 0.8,
                                    height: space * 0.25,
                                    decoration: BoxDecoration(
                                      color: (selectedSlot.id == doctorSlot.id)
                                          ? Colors.grey
                                          : Colors.white,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              doctorSlot.name,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: space * 0.02,
                                            ),
                                            Text(
                                              "Date: ${DateFormat.yMd().format(doctorSlot.startTime)} ",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              "Start: ${DateFormat.jm().format(doctorSlot.startTime)} ",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              "Fee: ${doctorSlot.fees.toString()}",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            //Text(chamber.address),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                        ],
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentScreen(
                                        doctor: widget.doctor,
                                        doctorSlot: selectedSlot,
                                      )));
                        },
                        child: Container(
                          height: space * .12,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xFF00BABA),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Book an Appointment",
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
