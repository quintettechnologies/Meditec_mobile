import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/doctor_profile_screen.dart';
import 'package:meditec/view/widget/catagoryButton.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:meditec/model/category.dart';
import '../../debouncer.dart';
import 'callscreens/pickup/pickup_layout.dart';
import 'package:meditec/constants.dart';

class CategoryDoctorScreen extends StatefulWidget {
  static const String id = 'category_doctor_screen';
  @override
  _CategoryDoctorScreenState createState() => _CategoryDoctorScreenState();
}

class _CategoryDoctorScreenState extends State<CategoryDoctorScreen> {
  final debouncer = Debouncer(milliseconds: 500);
  bool showEmptyMessage = false;
  String message = "Please type something to search";
  TextEditingController searchController;
  FocusNode searchFocus;
  List<User> result = [];
  bool _inProcess = false;

  void initState() {
    // TODO: implement initState
    searchController = TextEditingController();
    searchFocus = FocusNode();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        searchFocus.unfocus();
      }
    });
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
    List<User> doctors = context.read(userProvider).categoryDoctors;
    Category selectedCategory = context.read(userProvider).selectedCategory;

    return PickupLayout(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyCustomAppBar(
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: space * 0.05),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${selectedCategory.name}",
                        style: TextStyle(
                            fontSize: space * 0.05, color: kPrimaryTextColor),
                      ),
                      SizedBox(height: 10),
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
                                            DoctorProfileScreen(doctor: doctor),
                                      ),
                                    );
                                  },
                                  padding: EdgeInsets.symmetric(
                                      vertical: space * 0.015),
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
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: space * 0.17,
                                                  width: space * 0.17,
                                                ),
                                              ),
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
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                doctor.speciality.speciality,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                doctor.degree.degreeName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                doctor.hospitalName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                "${"Fee " + doctor.doctorFee.toString() ?? ""}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 12),
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
                                                  ignoreGestures: true,
                                                  updateOnDrag: false,
                                                  maxRating: doctor.feedBackAvg,
                                                  initialRating:
                                                      doctor.feedBackAvg,
                                                  itemSize: 10,
                                                  wrapAlignment:
                                                      WrapAlignment.end,
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
                                                    // print(rating);
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
                    ],
                  ),
                ),
              ),
              searchFocus.hasFocus
                  ? SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                Colors.white.withOpacity(0.5).withAlpha(1000)),
                        height: MediaQuery.of(context).size.height * 0.85,
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
                                  onPressed: (doctor.roles.name.toUpperCase() ==
                                          "DOCTOR")
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorProfileScreen(
                                                      doctor: doctor),
                                            ),
                                          );
                                        }
                                      : null,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: space * 0.015,
                                      vertical: space * 0.01),
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
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: space * 0.17,
                                                  width: space * 0.17,
                                                ),
                                              ),
                                        SizedBox(
                                          width: space * 0.02,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${doctor.name}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              (doctor.roles.name
                                                          .toUpperCase() ==
                                                      "DOCTOR")
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          (doctor.categories
                                                                  .isNotEmpty)
                                                              ? doctor
                                                                  .categories[0]
                                                                  .name
                                                              : "",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          (doctor.degree !=
                                                                  null)
                                                              ? doctor.degree
                                                                  .degreeName
                                                              : "",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          doctor.hospitalName ??
                                                              "",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: space * 0.02,
                                        ),
                                        (doctor.roles.name.toUpperCase() ==
                                                "DOCTOR")
                                            ? Padding(
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
                                                          // print(rating);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
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
        floatingActionButton: MyCustomFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MyCustomNavBar(),
      ),
    );
  }
}
