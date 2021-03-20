import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditec/model/appointment.dart';
import 'package:meditec/model/index.dart';
import 'package:meditec/model/prescriptionReport.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/report_detail_screen.dart';
import 'package:meditec/view/screen/sample_preview_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';
import '../constants.dart';

class SampleListScreen extends StatefulWidget {
  final Appointment appointment;

  const SampleListScreen({Key key, @required this.appointment})
      : super(key: key);
  @override
  _SampleListScreenState createState() => _SampleListScreenState();
}

class _SampleListScreenState extends State<SampleListScreen> {
  List<SamplePicture> samples = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    getSamples();
    super.initState();
  }

  getSamples() async {
    setState(() {
      isLoading = true;
    });
    samples = await context.read(userProvider).getPreviousSamples(
          widget.appointment.id,
        );
    setState(() {
      isLoading = false;
    });
  }

  deleteSample(SamplePicture sample) async {
    setState(() {
      isLoading = true;
    });
    bool delete = await context.read(userProvider).deletePreviousSample(sample);
    if (delete) {
      getSamples();
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong! please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        isLoading = false;
      });
    }
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
          child: Stack(
            children: [
              Container(
                width: space * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Samples',
                      style: TextStyle(
                          fontSize: space * 0.05, color: kPrimaryTextColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        for (SamplePicture sample in samples)
                          Padding(
                            padding: EdgeInsets.all(space * 0.01),
                            child: Container(
                              width: space * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  width: space * 0.9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      (sample.image != null)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SamplePreviewScreen(
                                                                  sample:
                                                                      sample,
                                                                )));
                                                  },
                                                  child: Container(
                                                    height: space * 0.17,
                                                    width: space * 0.17,
                                                    child: Image(
                                                      image: Image.memory(
                                                              base64.decode(
                                                                  sample.image))
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: GestureDetector(
                                                  onTap: () {},
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
                                      Padding(
                                        padding: EdgeInsets.all(space * 0.02),
                                        child: TextButton(
                                          onPressed: () {
                                            deleteSample(sample);
                                          },
                                          child: Container(
                                            height: space * 0.1,
                                            width: space * 0.1,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.redAccent),
                                            child: Icon(
                                              Icons.delete_forever,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        (samples.isEmpty)
                            ? Text(
                                'No previous documents to show',
                                style: TextStyle(
                                    fontSize: space * 0.04,
                                    color: kPrimaryTextColor),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
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
      floatingActionButton: MyCustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
