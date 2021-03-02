import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../constants.dart';

class CategoryDoctorScreen extends StatefulWidget {
  static const String id = 'category_doctor_screen';
  @override
  _CategoryDoctorScreenState createState() => _CategoryDoctorScreenState();
}

class _CategoryDoctorScreenState extends State<CategoryDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    List<User> doctors = context.read(userProvider).categoryDoctors;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(),
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
                  'Doctors',
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
                            padding: EdgeInsets.all(space * 0.015),
                            child: Container(
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  (doctor.userAvatar != null)
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              height: space * 0.17,
                                              width: space * 0.17,
                                              child: Image(
                                                image: Image.memory(
                                                        base64.decode(doctor
                                                            .userAvatar.image))
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
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          doctor.degree.degreeName,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          doctor.categories[0].name,
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
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF00BABA))),
                                        SizedBox(
                                          height: space * 0.05,
                                        ),
                                        Container(
                                          height: space * 0.05,
                                          //width: space * 0.15,
                                          child: RatingBar(
                                            itemSize: 10,
                                            wrapAlignment: WrapAlignment.end,
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
                                            itemPadding: EdgeInsets.symmetric(
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
