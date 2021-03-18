import 'dart:convert';

import 'package:date_picker_timeline/date_picker_widget.dart';
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
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  getSlotsByDate() async {
    context.read(userProvider).selectedSlot = DoctorSlot();
    await context
        .read(userProvider)
        .getDoctorSlotsByDate(_selectedValue, widget.doctor.chambers[0].id);
  }

  @override
  Widget build(BuildContext context) {
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
                                widget.doctor.degree.degreeName,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.doctor.categories[0].name,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),

                              // Text(
                              //   widget.doctor.chambers[0].adress,
                              //   style: TextStyle(
                              //     fontSize: 16,
                              //   ),
                              // ),
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
                      //       'Today ${DateFormat.yMMMMd(_selectedValue).toString()}',
                      //       style: TextStyle(
                      //           fontSize: 16, fontWeight: FontWeight.bold),
                      //     ),
                      //     Icon(Icons.keyboard_arrow_down)
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Select Date",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Container(
                        child: DatePicker(
                          DateTime.now(),
                          width: 60,
                          height: 80,
                          controller: _controller,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Colors.black,
                          selectedTextColor: Colors.white,
                          inactiveDates: [
                            // DateTime.now().add(Duration(days: )),
                            // DateTime.now().add(Duration(days: 4)),
                            // DateTime.now().add(Duration(days: 7))
                          ],
                          onDateChange: (date) async {
                            _selectedValue = date;
                            print(_selectedValue.toIso8601String());
                            await getSlotsByDate();
                            setState(() {});
                          },
                        ),
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
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(space * 0.01),
                                    height: space * 0.1,
                                    width: space * 0.36,
                                    decoration: BoxDecoration(
                                        color:
                                            (selectedSlot.id == doctorSlot.id)
                                                ? Color(0xFF00BABA)
                                                : Color(0xFFDDFDE1),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Text(
                                      "${DateFormat.jm().format(doctorSlot.startTime)} - ${DateFormat.jm().format(doctorSlot.endTime)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            (selectedSlot.id == doctorSlot.id)
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                  )),
                            ),
                        ],
                      ),
                      (doctorSlots.isNotEmpty)
                          ? TextButton(
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
                            )
                          : Container(),
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
