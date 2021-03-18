import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/doctor_screen.dart';
import 'package:meditec/view/widget/catagoryButton.dart';
import 'package:meditec/view/widget/catagoryButtonDashboard.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../debouncer.dart';
import '../constants.dart';
import 'doctor_profile_screen.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final debouncer = Debouncer(milliseconds: 2000);
  bool _inProcess = false;
  bool showEmptyMessage = false;
  String message = "Please type something to search";
  TextEditingController searchController;
  FocusNode searchFocus;
  List<User> doctors = [];
  List<User> result = [];

  @override
  void initState() {
    // TODO: implement initState
    searchController = TextEditingController();
    searchFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    List<User> doctors = context.read(userProvider).doctors;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyCustomAppBar(
          isDashboard: true,
          enableSearch: true,
          searchController: searchController,
          searchFocus: searchFocus,
          onChangedCallback: (query) async {
            debouncer.run(() async {
              if (query == "") {
                setState(() {
                  result.clear();
                  message = "Please type something to search";
                  showEmptyMessage = true;
                });
              } else {
                setState(() {
                  _inProcess = true;
                });
                result = await context.read(userProvider).globalSearch(query);
                if (result.isEmpty) {
                  message = "No match found";
                  showEmptyMessage = true;
                } else {
                  showEmptyMessage = false;
                }
                setState(() {
                  _inProcess = false;
                });
              }
            });
          },
        ),
        drawer: MyCustomDrawer(),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: space * 0.01, horizontal: space * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Services',
                        style: TextStyle(
                            fontSize: space * 0.05, color: kPrimaryTextColor),
                      ),
                      SizedBox(height: space * 0.05),
                      FittedBox(
                        child: Row(
                          children: [
                            CatagoryButtonDashBoard(
                              onTap: () {
                                Navigator.pushNamed(context, DoctorScreen.id);
                              },
                              category: 'Doctor',
                              color: Color(0xFFE2F2F8),
                            ),
                            // SizedBox(width: space * 0.05),
                            // CatagoryButtonDashBoard(
                            //   onTap: () {},
                            //   category: 'Hospital',
                            //   color: Color(0xFFE2F1EF),
                            // ),
                            // SizedBox(width: space * 0.05),
                            // CatagoryButtonDashBoard(
                            //   onTap: () {},
                            //   category: 'Ambulance',
                            //   color: Color(0xFFE7F1E4),
                            // ),
                            // SizedBox(width: space * 0.05),
                            // CatagoryButtonDashBoard(
                            //   onTap: () {},
                            //   category: 'Diagnostic',
                            //   color: Color(0xFFD6E7F2),
                            // ),
                          ],
                        ),
                      ),
                      // SizedBox(height: space * 0.05),
                      // FittedBox(
                      //   child: Row(
                      //     children: [
                      //       CatagoryButtonDashBoard(
                      //         onTap: () {},
                      //         category: 'Blood',
                      //         color: Color(0xFFF7E0E0),
                      //       ),
                      //       SizedBox(width: space * 0.05),
                      //       CatagoryButtonDashBoard(
                      //         onTap: () {},
                      //         category: 'Int. Doctor',
                      //         color: Color(0xFFF8EBE1),
                      //       ),
                      //       SizedBox(width: space * 0.05),
                      //       CatagoryButtonDashBoard(
                      //         onTap: () {},
                      //         category: 'Report',
                      //         color: Color(0xFFF7E3E9),
                      //       ),
                      //       SizedBox(width: space * 0.05),
                      //       CatagoryButtonDashBoard(
                      //         onTap: () {},
                      //         category: 'Blog',
                      //         color: Color(0xFFF1E5EF),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: space * 0.05),
                      Text(
                        "What's New",
                        style: TextStyle(
                            fontSize: space * 0.05, color: kPrimaryTextColor),
                      ),
                      SizedBox(height: space * 0.05),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: kSelectedButtonDecoration,
                              child: Text(
                                "Corona Update",
                                style: kSelectedButtonTextStyle,
                              ),
                            ),
                            SizedBox(width: space * 0.03),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: kButtonDecoration,
                              child: Text(
                                "Health",
                                style: kButtonTextStyle,
                              ),
                            ),
                            SizedBox(width: space * 0.03),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: kButtonDecoration,
                              child: Text(
                                "Doctors",
                                style: kButtonTextStyle,
                              ),
                            ),
                            SizedBox(width: space * 0.03),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: kButtonDecoration,
                              child: Text(
                                "Hospital",
                                style: kButtonTextStyle,
                              ),
                            ),
                            SizedBox(width: space * 0.03),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: kButtonDecoration,
                              child: Text(
                                "Medicine",
                                style: kButtonTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: space * 0.05),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Color(0xFFD2D2D2)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image(
                                  image:
                                      AssetImage("assets/images/ads/medik.jpg"),
                                  fit: BoxFit.fitHeight,
                                  height: 120,
                                  width: 220,
                                ),
                                // child: Image(
                                //   image:
                                //       AssetImage('assets/images/profiles/user.png'),
                                // ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Color(0xFFD2D2D2)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image(
                                  image: AssetImage(
                                      "assets/images/ads/pressure.jpg"),
                                  fit: BoxFit.fitHeight,
                                  height: 120,
                                  width: 220,
                                ),
                                // child: Image(
                                //   image:
                                //       AssetImage('assets/images/profiles/user.png'),
                                // ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: space * 0.05),
                      Text(
                        "Top Doctors",
                        style: TextStyle(
                            fontSize: space * 0.05, color: kPrimaryTextColor),
                      ),
                      SizedBox(height: space * 0.05),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            (doctors.length < 1)
                                ? Container()
                                : Container(
                                    padding: EdgeInsets.all(space * 0.01),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF7DCFED),
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: Color(0xFFD2D2D2)),
                                    ),
                                    height: space * 0.31,
                                    width: space * 0.65,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              (doctors[0].userAvatar != null)
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        height: space * 0.2,
                                                        width: space * 0.2,
                                                        child: Image(
                                                          image: Image.memory(
                                                                  base64.decode(
                                                                      doctors[0]
                                                                          .userAvatar
                                                                          .image))
                                                              .image,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doctors[0].name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              doctors[0].degree.degreeName ??
                                                  "",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              doctors[0].categories[0].name ??
                                                  "",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Container(
                                              height: space * 0.05,
                                              //width: space * 0.15,
                                              child: RatingBar(
                                                itemSize: 15,
                                                wrapAlignment:
                                                    WrapAlignment.end,
                                                initialRating: 5,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                ratingWidget: RatingWidget(
                                                  full: Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                  ),
                                                  half: Icon(
                                                    Icons.star_half,
                                                    color: Colors.white,
                                                  ),
                                                  empty: Icon(
                                                    Icons.star_border,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DoctorProfileScreen(
                                                                doctor:
                                                                    doctors[0]),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFF9CD9EF)),
                                                        color:
                                                            Color(0xFF38A1C7)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                space * 0.01,
                                                            horizontal:
                                                                space * 0.03),
                                                    child: Text(
                                                      'Appointment',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            (doctors.length < 2)
                                ? Container()
                                : Container(
                                    padding: EdgeInsets.all(space * 0.01),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFABB85),
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: Color(0xFFD2D2D2)),
                                    ),
                                    height: space * 0.31,
                                    width: space * 0.65,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              (doctors[1].userAvatar != null)
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        height: space * 0.2,
                                                        width: space * 0.2,
                                                        child: Image(
                                                          image: Image.memory(
                                                                  base64.decode(
                                                                      doctors[1]
                                                                          .userAvatar
                                                                          .image))
                                                              .image,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doctors[1].name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              doctors[1].degree.degreeName ??
                                                  "",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              doctors[1].categories[0].name ??
                                                  "",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Container(
                                              height: space * 0.05,
                                              //width: space * 0.15,
                                              child: RatingBar(
                                                itemSize: 15,
                                                wrapAlignment:
                                                    WrapAlignment.end,
                                                initialRating: 5,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                ratingWidget: RatingWidget(
                                                  full: Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                  ),
                                                  half: Icon(
                                                    Icons.star_half,
                                                    color: Colors.white,
                                                  ),
                                                  empty: Icon(
                                                    Icons.star_border,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DoctorProfileScreen(
                                                                doctor:
                                                                    doctors[1]),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFFF5C7A0)),
                                                        color:
                                                            Color(0xFFE59754)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                space * 0.01,
                                                            horizontal:
                                                                space * 0.03),
                                                    child: Text(
                                                      'Appointment',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
                      SizedBox(height: space * 0.05),
                    ],
                  ),
                ),
              ),
              searchFocus.hasFocus
                  ? SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              showEmptyMessage
                                  ? Container(
                                      child: Text(
                                        message,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    )
                                  : Container(),
                              for (User doctor in result)
                                FlatButton(
                                  onPressed: () {},
                                  padding: EdgeInsets.all(space * 0.015),
                                  child: Container(
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
                                          MainAxisAlignment.start,
                                      children: [
                                        (doctor.userAvatar != null)
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
                                                              .decode(doctor
                                                                  .userAvatar
                                                                  .image))
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                doctor.name,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: space * 0.02,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Available",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Color(0xFF00BABA))),
                                              SizedBox(
                                                height: space * 0.05,
                                              ),
                                              Container(
                                                height: space * 0.05,
                                                //width: space * 0.15,
                                                child: RatingBar(
                                                  itemSize: 10,
                                                  wrapAlignment:
                                                      WrapAlignment.end,
                                                  initialRating: 5,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  ratingWidget: RatingWidget(
                                                    full: Icon(
                                                      Icons.star,
                                                      color: Color(0xFF3C4858),
                                                    ),
                                                    half: Icon(
                                                      Icons.star_half,
                                                      color: Color(0xFF3C4858),
                                                    ),
                                                    empty: Icon(
                                                      Icons.star_border,
                                                      color: Color(0xFF3C4858),
                                                    ),
                                                  ),
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 0),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
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
                      ),
                    )
                  : Container(),
              (_inProcess)
                  ? Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      )),
                    )
                  : Center()
            ],
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
      ),
    );
  }
}

// class Dashboard extends StatefulWidget {
//   static const String id = 'dashboard';
//   @override
//   _DashboardState createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   @override
//   Widget build(BuildContext context) {
//     final double space = MediaQuery.of(context).size.width;
//     List<User> doctors = context.read(userProvider).doctors;
//     return WillPopScope(
//         onWillPop: () async {
//           return false;
//         },
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           appBar: MyCustomAppBar(
//             isDashboard: true,
//             enableSearch: true,
//           ),
//           drawer: MyCustomDrawer(),
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     vertical: space * 0.01, horizontal: space * 0.05),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Services',
//                       style: TextStyle(
//                           fontSize: space * 0.05, color: kPrimaryTextColor),
//                     ),
//                     SizedBox(height: space * 0.05),
//                     FittedBox(
//                       child: Row(
//                         children: [
//                           CatagoryButtonDashBoard(
//                             onTap: () {
//                               Navigator.pushNamed(context, DoctorScreen.id);
//                             },
//                             category: 'Doctor',
//                             color: Color(0xFFE2F2F8),
//                           ),
//                           // SizedBox(width: space * 0.05),
//                           // CatagoryButtonDashBoard(
//                           //   onTap: () {},
//                           //   category: 'Hospital',
//                           //   color: Color(0xFFE2F1EF),
//                           // ),
//                           // SizedBox(width: space * 0.05),
//                           // CatagoryButtonDashBoard(
//                           //   onTap: () {},
//                           //   category: 'Ambulance',
//                           //   color: Color(0xFFE7F1E4),
//                           // ),
//                           // SizedBox(width: space * 0.05),
//                           // CatagoryButtonDashBoard(
//                           //   onTap: () {},
//                           //   category: 'Diagnostic',
//                           //   color: Color(0xFFD6E7F2),
//                           // ),
//                         ],
//                       ),
//                     ),
//                     // SizedBox(height: space * 0.05),
//                     // FittedBox(
//                     //   child: Row(
//                     //     children: [
//                     //       CatagoryButtonDashBoard(
//                     //         onTap: () {},
//                     //         category: 'Blood',
//                     //         color: Color(0xFFF7E0E0),
//                     //       ),
//                     //       SizedBox(width: space * 0.05),
//                     //       CatagoryButtonDashBoard(
//                     //         onTap: () {},
//                     //         category: 'Int. Doctor',
//                     //         color: Color(0xFFF8EBE1),
//                     //       ),
//                     //       SizedBox(width: space * 0.05),
//                     //       CatagoryButtonDashBoard(
//                     //         onTap: () {},
//                     //         category: 'Report',
//                     //         color: Color(0xFFF7E3E9),
//                     //       ),
//                     //       SizedBox(width: space * 0.05),
//                     //       CatagoryButtonDashBoard(
//                     //         onTap: () {},
//                     //         category: 'Blog',
//                     //         color: Color(0xFFF1E5EF),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     SizedBox(height: space * 0.05),
//                     Text(
//                       "What's New",
//                       style: TextStyle(
//                           fontSize: space * 0.05, color: kPrimaryTextColor),
//                     ),
//                     SizedBox(height: space * 0.05),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: kSelectedButtonDecoration,
//                             child: Text(
//                               "Corona Update",
//                               style: kSelectedButtonTextStyle,
//                             ),
//                           ),
//                           SizedBox(width: space * 0.03),
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: kButtonDecoration,
//                             child: Text(
//                               "Health",
//                               style: kButtonTextStyle,
//                             ),
//                           ),
//                           SizedBox(width: space * 0.03),
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: kButtonDecoration,
//                             child: Text(
//                               "Doctors",
//                               style: kButtonTextStyle,
//                             ),
//                           ),
//                           SizedBox(width: space * 0.03),
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: kButtonDecoration,
//                             child: Text(
//                               "Hospital",
//                               style: kButtonTextStyle,
//                             ),
//                           ),
//                           SizedBox(width: space * 0.03),
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: kButtonDecoration,
//                             child: Text(
//                               "Medicine",
//                               style: kButtonTextStyle,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: space * 0.05),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(color: Color(0xFFD2D2D2)),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(5.0),
//                               child: Image(
//                                 image:
//                                     AssetImage("assets/images/ads/medik.jpg"),
//                                 fit: BoxFit.fitHeight,
//                                 height: 120,
//                                 width: 220,
//                               ),
//                               // child: Image(
//                               //   image:
//                               //       AssetImage('assets/images/profiles/user.png'),
//                               // ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(color: Color(0xFFD2D2D2)),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(5.0),
//                               child: Image(
//                                 image: AssetImage(
//                                     "assets/images/ads/pressure.jpg"),
//                                 fit: BoxFit.fitHeight,
//                                 height: 120,
//                                 width: 220,
//                               ),
//                               // child: Image(
//                               //   image:
//                               //       AssetImage('assets/images/profiles/user.png'),
//                               // ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: space * 0.05),
//                     Text(
//                       "Top Doctors",
//                       style: TextStyle(
//                           fontSize: space * 0.05, color: kPrimaryTextColor),
//                     ),
//                     SizedBox(height: space * 0.05),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Color(0xFF7DCFED),
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(color: Color(0xFFD2D2D2)),
//                             ),
//                             height: 130,
//                             width: 250,
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     children: [
//                                       (doctors[0].userAvatar != null)
//                                           ? ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               child: Container(
//                                                 height: space * 0.2,
//                                                 width: space * 0.2,
//                                                 child: Image(
//                                                   image: Image.memory(base64
//                                                           .decode(doctors[0]
//                                                               .userAvatar
//                                                               .image))
//                                                       .image,
//                                                 ),
//                                               ),
//                                             )
//                                           : Container(),
//                                     ],
//                                   ),
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       doctors[0].name,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(
//                                       doctors[0].degree.degreeName,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       doctors[0].categories[0].name,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Container(
//                                       height: space * 0.05,
//                                       //width: space * 0.15,
//                                       child: RatingBar(
//                                         itemSize: 15,
//                                         wrapAlignment: WrapAlignment.end,
//                                         initialRating: 5,
//                                         direction: Axis.horizontal,
//                                         allowHalfRating: true,
//                                         itemCount: 5,
//                                         ratingWidget: RatingWidget(
//                                           full: Icon(
//                                             Icons.star,
//                                             color: Colors.white,
//                                           ),
//                                           half: Icon(
//                                             Icons.star_half,
//                                             color: Colors.white,
//                                           ),
//                                           empty: Icon(
//                                             Icons.star_border,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         itemPadding:
//                                             EdgeInsets.symmetric(horizontal: 0),
//                                         onRatingUpdate: (rating) {
//                                           print(rating);
//                                         },
//                                       ),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     DoctorProfileScreen(
//                                                         doctor: doctors[0]),
//                                               ),
//                                             );
//                                           },
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(5),
//                                                 border: Border.all(
//                                                     color: Color(0xFF9CD9EF)),
//                                                 color: Color(0xFF38A1C7)),
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: space * 0.01,
//                                                 horizontal: space * 0.03),
//                                             child: Text(
//                                               'Appointment',
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Color(0xFFFABB85),
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(color: Color(0xFFD2D2D2)),
//                             ),
//                             height: 130,
//                             width: 250,
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     children: [
//                                       (doctors[1].userAvatar != null)
//                                           ? ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               child: Container(
//                                                 height: space * 0.2,
//                                                 width: space * 0.2,
//                                                 child: Image(
//                                                   image: Image.memory(base64
//                                                           .decode(doctors[1]
//                                                               .userAvatar
//                                                               .image))
//                                                       .image,
//                                                 ),
//                                               ),
//                                             )
//                                           : Container(),
//                                     ],
//                                   ),
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       doctors[1].name,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(
//                                       doctors[1].degree.degreeName,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       doctors[1].categories[0].name,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Container(
//                                       height: space * 0.05,
//                                       //width: space * 0.15,
//                                       child: RatingBar(
//                                         itemSize: 15,
//                                         wrapAlignment: WrapAlignment.end,
//                                         initialRating: 5,
//                                         direction: Axis.horizontal,
//                                         allowHalfRating: true,
//                                         itemCount: 5,
//                                         ratingWidget: RatingWidget(
//                                           full: Icon(
//                                             Icons.star,
//                                             color: Colors.white,
//                                           ),
//                                           half: Icon(
//                                             Icons.star_half,
//                                             color: Colors.white,
//                                           ),
//                                           empty: Icon(
//                                             Icons.star_border,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         itemPadding:
//                                             EdgeInsets.symmetric(horizontal: 0),
//                                         onRatingUpdate: (rating) {
//                                           print(rating);
//                                         },
//                                       ),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     DoctorProfileScreen(
//                                                         doctor: doctors[1]),
//                                               ),
//                                             );
//                                           },
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(5),
//                                                 border: Border.all(
//                                                     color: Color(0xFFF5C7A0)),
//                                                 color: Color(0xFFE59754)),
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: space * 0.01,
//                                                 horizontal: space * 0.03),
//                                             child: Text(
//                                               'Appointment',
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: space * 0.05),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           floatingActionButton: MyCustomFAB(),
//           floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerDocked,
//           bottomNavigationBar: MyCustomNavBar(),
//         ));
//   }
// }
