import 'dart:convert';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:meditec/model/category.dart';
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

import 'callscreens/pickup/pickup_layout.dart';

class DoctorProfileScreen extends StatefulWidget {
  static const String id = 'doctor_profile_screen';

  DoctorProfileScreen({@required this.doctor});

  final User doctor;
  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  bool loading = false;
  bool selected = false;
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSlotsByDate();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   context.read(userProvider).selectedSlot = DoctorSlot();
  //   super.dispose();
  // }

  getSlotsByDate() async {
    setState(() {
      loading = true;
    });
    selected = false;
    context.read(userProvider).selectedSlot = DoctorSlot();
    await context
        .read(userProvider)
        .getDoctorSlotsByDate(_selectedValue, widget.doctor.chambers[0].id);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DoctorSlot> doctorSlots = context.read(userProvider).doctorSlots;
    DoctorSlot selectedSlot = context.read(userProvider).selectedSlot;
    final double space = MediaQuery.of(context).size.width;
    final double verticalSpace = MediaQuery.of(context).size.height;
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

    return PickupLayout(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyCustomAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: space * 0.05),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              (widget.doctor.userAvatar != null)
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: space * 0.3,
                                        width: space * 0.3,
                                        child: Image(
                                          image: Image.memory(base64.decode(
                                                  widget
                                                      .doctor.userAvatar.image))
                                              .image,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: space * 0.3,
                                      width: space * 0.3,
                                    ),
                              Text(
                                "${"Fee " + widget.doctor.doctorFee.toString() ?? ""}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: space * 0.05,
                        ),
                        Container(
                          width: space * 0.55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.doctor.name,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                buildCategories(widget.doctor.categories),
                                style: TextStyle(
                                  color: Color(0xFF00BABA),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              Text(
                                widget.doctor.degree.degreeName,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "BMDC No. ${widget.doctor.doctorRegistrationNumber.toString() ?? ""}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.doctor.hospitalName ?? "",
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
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: space * 0.02,
                    ),
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
                          // print(_selectedValue.toIso8601String());
                          await getSlotsByDate();
                        },
                      ),
                    ),
                    SizedBox(
                      height: space * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Available Time",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: space * 0.02,
                    ),
                    SizedBox(
                      height: verticalSpace * 0.25,
                      child: loading
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              width: space,
                              color: Colors.white,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: space * 0.01,
                                      childAspectRatio: 2.5 / 1),
                              shrinkWrap: true,
                              itemCount: doctorSlots.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return FlatButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: (!doctorSlots[index].booked &&
                                            doctorSlots[index]
                                                .startTime
                                                .isAfter(DateTime.now()))
                                        ? () {
                                            context
                                                .read(userProvider)
                                                .selectSlot(doctorSlots[index]);
                                            selected = true;
                                            setState(() {});
                                          }
                                        : null,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(space * 0.01),
                                      margin: EdgeInsets.zero,
                                      height: space * 0.1,
                                      width: space * 0.36,
                                      decoration: BoxDecoration(
                                          color: (doctorSlots[index].booked ||
                                                  doctorSlots[index]
                                                      .startTime
                                                      .isBefore(DateTime.now())
                                              ? Colors.grey
                                              : (selectedSlot.id ==
                                                      doctorSlots[index].id)
                                                  ? Color(0xFF00BABA)
                                                  : Color(0xFFDDFDE1)),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Text(
                                        "${DateFormat.jm().format(doctorSlots[index].startTime)} - ${DateFormat.jm().format(doctorSlots[index].endTime)}",
                                        style: TextStyle(
                                          fontSize: space * 0.03,
                                          fontWeight: FontWeight.bold,
                                          color: (doctorSlots[index].booked ||
                                                  doctorSlots[index]
                                                      .startTime
                                                      .isBefore(DateTime.now()))
                                              ? Colors.white
                                              : (selectedSlot.id ==
                                                      doctorSlots[index].id)
                                                  ? Colors.white
                                                  : Color(0xFF495767),
                                        ),
                                      ),
                                    ));
                              }),
                    ),
                    (doctorSlots.isNotEmpty && selected)
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
