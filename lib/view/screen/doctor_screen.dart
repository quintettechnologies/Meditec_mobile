import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/category_doctor_screen.dart';
import 'package:meditec/view/screen/doctor_profile_screen.dart';
import 'package:meditec/view/widget/catagoryButton.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:meditec/model/category.dart';
import '../constants.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DoctorScreen extends StatefulWidget {
  static const String id = 'doctor_screen';
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    List<Category> categories = context.read(userProvider).categories;
    List<User> doctors = context.read(userProvider).doctors;
    bool showButtons = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(
        enableSearch: true,
      ),
      drawer: MyCustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: space * 0.01, horizontal: space * 0.07),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category',
                  style: TextStyle(
                      fontSize: space * 0.05, color: kPrimaryTextColor),
                ),
                SizedBox(height: 10),
                // FittedBox(
                //   child: Row(
                //     children: [
                //       CategoryButton(
                //         category: 'Heart',
                //         color: Color(0xFFE3FFFF),
                //       ),
                //       SizedBox(width: space * 0.05),
                //       CategoryButton(
                //         category: 'Dental',
                //         color: Color(0xFFE3E8FF),
                //       ),
                //       SizedBox(width: space * 0.05),
                //       CategoryButton(
                //         category: 'Brain',
                //         color: Color(0xFFFFE3F1),
                //       ),
                //       SizedBox(width: space * 0.05),
                //       CategoryButton(
                //         category: 'Bone',
                //         color: Color(0xFFFFF3E3),
                //       ),
                //     ],
                //   ),
                // ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (Category category in categories)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              bool list = await context
                                  .read(userProvider)
                                  .getCategoryDoctorList(category.id);
                              if (list) {
                                Navigator.pushNamed(
                                    context, CategoryDoctorScreen.id);
                              }
                            },
                            child: Container(
                              // padding: EdgeInsets.all(10),
                              height: space * 0.25,
                              width: space * 0.25,
                              decoration: kButtonDecoration,
                              child: Column(
                                children: [
                                  ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              height: space * 0.1,
                                              width: space * 0.1,
                                              // child: Icon(
                                              //   Icons.account_circle,
                                              //   size: space * 0.1,
                                              //   color: Color(0xFF00BABA),
                                              // )
                                              child: SvgPicture.asset(
                                                "assets/icons/doctor_page/${category.name}.svg",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ) ??
                                      Container(),
                                  Text(
                                    category.name,
                                    style: kButtonTextStyle.copyWith(
                                        fontSize: space * 0.036),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          indicator: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF495767),
                                width: 0.5,
                              ),
                            ),
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Container(
                              child: Text(
                                'Top Specialists',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              height: space * 0.1,
                              alignment: Alignment.center,
                            ),
                            Container(
                              child: Text(
                                '24/7 Doctor',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              height: space * 0.1,
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: space * 1, //height of TabBarView
                        // decoration: BoxDecoration(
                        //     border: Border(
                        //         top: BorderSide(
                        //             color: Colors.grey, width: 0.5))),
                        child: TabBarView(
                          children: <Widget>[
                            Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    for (User doctor in doctors)
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorProfileScreen(
                                                      doctor: doctor),
                                            ),
                                          );
                                        },
                                        padding: EdgeInsets.all(space * 0.015),
                                        child: Container(
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              (doctor.userAvatar != null)
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Container(
                                                          height: space * 0.17,
                                                          width: space * 0.17,
                                                          child: Image(
                                                            image: Image.memory(
                                                                    base64.decode(doctor
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
                                                    Text(
                                                      (doctor.degree != null)
                                                          ? doctor
                                                              .degree.degreeName
                                                          : "",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      (doctor.categories
                                                              .isNotEmpty)
                                                          ? doctor.categories[0]
                                                              .name
                                                          : "",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    // Text(
                                                    //     doctor
                                                    //         .chambers[0].adress,
                                                    //     style: TextStyle(
                                                    //         fontSize: 13,
                                                    //         fontWeight:
                                                    //             FontWeight
                                                    //                 .w500)),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: space * 0.02,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Available",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFF00BABA))),
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
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        ratingWidget:
                                                            RatingWidget(
                                                          full: Icon(
                                                            Icons.star,
                                                            color: Color(
                                                                0xFF3C4858),
                                                          ),
                                                          half: Icon(
                                                            Icons.star_half,
                                                            color: Color(
                                                                0xFF3C4858),
                                                          ),
                                                          empty: Icon(
                                                            Icons.star_border,
                                                            color: Color(
                                                                0xFF3C4858),
                                                          ),
                                                        ),
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 0),
                                                        onRatingUpdate:
                                                            (rating) {
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
                            Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    for (User doctor in doctors)
                                      Padding(
                                        padding: EdgeInsets.all(space * 0.015),
                                        child: InkWell(
                                          onTap: () {
                                            UrlLauncher.launch(
                                                "tel://${doctor.mobileNumber}");
                                          },
                                          child: Container(
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                (doctor.userAvatar != null)
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Container(
                                                            height:
                                                                space * 0.17,
                                                            width: space * 0.17,
                                                            child: Image(
                                                              image: Image.memory(
                                                                      base64.decode(doctor
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        doctor.name,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        (doctor.degree != null)
                                                            ? doctor.degree
                                                                .degreeName
                                                            : "",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        (doctor.categories
                                                                .isNotEmpty)
                                                            ? doctor
                                                                .categories[0]
                                                                .name
                                                            : "",
                                                        style: TextStyle(
                                                            fontSize: 12),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Available",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF00BABA))),
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
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          ratingWidget:
                                                              RatingWidget(
                                                            full: Icon(
                                                              Icons.star,
                                                              color: Color(
                                                                  0xFF3C4858),
                                                            ),
                                                            half: Icon(
                                                              Icons.star_half,
                                                              color: Color(
                                                                  0xFF3C4858),
                                                            ),
                                                            empty: Icon(
                                                              Icons.star_border,
                                                              color: Color(
                                                                  0xFF3C4858),
                                                            ),
                                                          ),
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      0),
                                                          onRatingUpdate:
                                                              (rating) {
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
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                            // Container(
                            //   child: Consumer(
                            //     builder: (context, watch, child) {
                            //       List<Doctor> doctors = watch(doctorsProvider);
                            //       return ListView.builder(
                            //         itemCount: doctors.length,
                            //         itemBuilder: (BuildContext ctxt, int index) =>
                            //             FlatButton(
                            //           onPressed: () {
                            //             Navigator.pushNamed(
                            //                 context, DoctorProfileScreen.id);
                            //           },
                            //           padding: EdgeInsets.all(space * 0.015),
                            //           child: Container(
                            //             decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               borderRadius: BorderRadius.circular(10),
                            //               boxShadow: [
                            //                 BoxShadow(
                            //                     color: Color(0xFF000000)
                            //                         .withOpacity(0.1),
                            //                     offset: Offset.fromDirection(1),
                            //                     blurRadius: 10,
                            //                     spreadRadius: 1)
                            //               ],
                            //             ),
                            //             child: Row(
                            //               children: [
                            //                 Padding(
                            //                   padding: const EdgeInsets.all(8.0),
                            //                   child: ClipRRect(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10),
                            //                     child: Container(
                            //                       height: space * 0.17,
                            //                       width: space * 0.17,
                            //                       child: Image(
                            //                         image: NetworkImage(
                            //                             doctors[index].photoUrl),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 SizedBox(
                            //                   width: space * 0.02,
                            //                 ),
                            //                 Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     Text(
                            //                       doctors[index].displayName,
                            //                       style: TextStyle(
                            //                           fontSize: 14,
                            //                           fontWeight:
                            //                               FontWeight.bold),
                            //                     ),
                            //                     Text(
                            //                       doctors[index].degrees,
                            //                       style: TextStyle(fontSize: 12),
                            //                     ),
                            //                     Text(
                            //                       doctors[index].category,
                            //                       style: TextStyle(fontSize: 12),
                            //                     ),
                            //                     Text(doctors[index].hospital,
                            //                         style: TextStyle(
                            //                             fontSize: 13,
                            //                             fontWeight:
                            //                                 FontWeight.w500)),
                            //                   ],
                            //                 ),
                            //                 SizedBox(
                            //                   width: space * 0.02,
                            //                 ),
                            //                 Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.end,
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.spaceBetween,
                            //                   children: [
                            //                     Text(doctors[index].status,
                            //                         style: TextStyle(
                            //                             fontSize: 12,
                            //                             fontWeight:
                            //                                 FontWeight.bold,
                            //                             color:
                            //                                 Color(0xFF00BABA))),
                            //                     SizedBox(
                            //                       height: space * 0.05,
                            //                     ),
                            //                     Container(
                            //                       height: space * 0.05,
                            //                       //width: space * 0.15,
                            //                       child: RatingBar(
                            //                         itemSize: 10,
                            //                         wrapAlignment:
                            //                             WrapAlignment.end,
                            //                         initialRating: (doctors[index]
                            //                                     .rating ==
                            //                                 null)
                            //                             ? 5
                            //                             : doctors[index].rating,
                            //                         direction: Axis.horizontal,
                            //                         allowHalfRating: true,
                            //                         itemCount: 5,
                            //                         ratingWidget: RatingWidget(
                            //                           full: Icon(
                            //                             Icons.star,
                            //                             color: Color(0xFF3C4858),
                            //                           ),
                            //                           half: Icon(
                            //                             Icons.star_half,
                            //                             color: Color(0xFF3C4858),
                            //                           ),
                            //                           empty: Icon(
                            //                             Icons.star_border,
                            //                             color: Color(0xFF3C4858),
                            //                           ),
                            //                         ),
                            //                         itemPadding:
                            //                             EdgeInsets.symmetric(
                            //                                 horizontal: 0),
                            //                         onRatingUpdate: (rating) {
                            //                           print(rating);
                            //                         },
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: MyCustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
