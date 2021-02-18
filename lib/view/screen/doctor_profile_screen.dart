import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/doctor.dart';
import 'package:meditec/providers/doctors_provider.dart';
import 'package:meditec/view/screen/payment_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customFAB.dart';

class DoctorProfileScreen extends HookWidget {
  static const String id = 'doctor_profile_screen';

  DoctorProfileScreen({@required this.index});

  final int index;

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
                  child: Column(
                    children: [
                      SizedBox(
                        height: space * 0.03,
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: space * 0.3,
                              width: space * 0.3,
                              child: Image(
                                image: NetworkImage(doctors[index].photoUrl),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: space * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctors[index].displayName,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                doctors[index].category,
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
                              Text(
                                "Fee - 500",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: space * 0.08,
                      ),
                      Container(
                        height: space * 0.15,
                        alignment: Alignment.center,
                        child: RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: doctors[index].bio,
                            style: TextStyle(
                                fontSize: 13,
                                height: 1.5,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: space * 0.05,
                      ),
                      Row(
                        children: [
                          Text(
                            'Today 05 Sept 2020',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            myCustomDayButton(
                              space: space,
                              day: 'Sat',
                              date: '05',
                            ),
                            myCustomDayButton(
                              space: space,
                              day: 'Sun',
                              date: '06',
                              selected: true,
                            ),
                            myCustomDayButton(
                              space: space,
                              day: 'Mon',
                              date: '07',
                            ),
                            myCustomDayButton(
                              space: space,
                              day: 'Tue',
                              date: '08',
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: space * 0.1,
                            width: space * 0.25,
                            decoration: BoxDecoration(
                                color: Color(0xFFC5C5C5),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "09 - 9.30am",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF8D8D8D)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: space * 0.1,
                            width: space * 0.25,
                            decoration: BoxDecoration(
                                color: Color(0xFFDDFDE1),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "10 - 10.30am",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF495767)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: space * 0.1,
                            width: space * 0.25,
                            decoration: BoxDecoration(
                                color: Color(0xFFC5C5C5),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "11 - 11.30am",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF8D8D8D)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: space * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: space * 0.05,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: space * 0.1,
                            width: space * 0.25,
                            decoration: BoxDecoration(
                                color: Color(0xFFDDFDE1),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "07 - 7.30pm",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF495767)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: space * 0.1,
                            width: space * 0.25,
                            decoration: BoxDecoration(
                                color: Color(0xFFC5C5C5),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "08 - 8.30pm",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF8D8D8D)),
                            ),
                          ),
                          SizedBox(
                            width: space * 0.05,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: space * 0.05,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentScreen(
                                        index: index,
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
