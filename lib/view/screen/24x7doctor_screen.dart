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

import 'callscreens/pickup/pickup_layout.dart';
import 'chat_page.dart';

class EmergencyDoctorScreen extends StatefulWidget {
  static const String id = 'emergency_doctor_screen';
  @override
  _EmergencyDoctorScreenState createState() => _EmergencyDoctorScreenState();
}

class _EmergencyDoctorScreenState extends State<EmergencyDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    List<Category> categories = context.read(userProvider).categories;
    List<User> doctors = context.read(userProvider).emergencyDoctors;
    bool showButtons = true;
    return PickupLayout(
      scaffold: Scaffold(
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              (doctor.categories.isNotEmpty)
                                                  ? doctor.categories[0].name
                                                  : "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              (doctor.degree != null)
                                                  ? doctor.degree.degreeName
                                                  : "",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              doctor.hospitalName ?? "",
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
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatPage(
                                                                  user:
                                                                      doctor)));
                                                },
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons
                                                          .chat_bubble_rounded),
                                                      SizedBox(
                                                        width: space * 0.01,
                                                      ),
                                                      Text("Chat")
                                                    ],
                                                  ),
                                                ))
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
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: MyCustomFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MyCustomNavBar(),
      ),
    );
  }
}
