import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meditec/model/appointment.dart';
import 'package:meditec/model/prescriptionReport.dart';
import 'package:meditec/view/screen/report_detail_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';

import '../../constants.dart';
import '../constants.dart';

class ReportsListScreen extends StatefulWidget {
  final Appointment appointment;

  const ReportsListScreen({Key key, @required this.appointment})
      : super(key: key);
  @override
  _ReportsListScreenState createState() => _ReportsListScreenState();
}

class _ReportsListScreenState extends State<ReportsListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(),
      drawer: MyCustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Reports',
                style:
                    TextStyle(fontSize: space * 0.05, color: kPrimaryTextColor),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (PrescriptionReport report in widget.appointment.reports)
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            (report.image != null)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReportDetailScreen(
                                                        report: report,
                                                      )));
                                        },
                                        child: Container(
                                          height: space * 0.17,
                                          width: space * 0.17,
                                          child: Image(
                                            image: Image.memory(
                                                    base64.decode(report.image))
                                                .image,
                                          ),
                                        ),
                                        // child: Container(
                                        //     height: space * 0.17,
                                        //     width: space * 0.17,
                                        //     color: Colors.green,
                                        //     child: Icon(
                                        //       Icons.picture_as_pdf,
                                        //       color: Colors.white,
                                        //       size: space * 0.17,
                                        //     )),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             AppointmentDetailScreen(
                                          //               appointment:
                                          //                   appointment,
                                          //             )));
                                        },
                                        child: Container(
                                          height: space * 0.17,
                                          width: space * 0.17,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              width: space * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
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
      floatingActionButton: MyCustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
