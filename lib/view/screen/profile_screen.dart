import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/upload_profile_image_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';

import 'callscreens/pickup/pickup_layout.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends HookWidget {
  static const String id = 'profile_view';
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    final User user = useProvider(userProvider).currentUser();

    return PickupLayout(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyCustomAppBar(),
        drawer: MyCustomDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "${user.name}",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: space * 0.02,
                ),
                Container(
                  width: space,
                  height: space * 0.4,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: space * 0.3,
                        width: space * 0.3,
                        child: Stack(
                          fit: StackFit.expand,
                          overflow: Overflow.visible,
                          children: [
                            (user.userAvatar != null)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image(
                                      image: Image.memory(base64
                                              .decode(user.userAvatar.image))
                                          .image,
                                      fit: BoxFit.cover,
                                      height: 70,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Icon(
                                      Icons.account_circle,
                                      color: Color(0xFF00BABA),
                                      size: space * 0.3,
                                    )),
                            Positioned(
                              right: -10,
                              bottom: -10,
                              child: SizedBox(
                                height: space * 0.1,
                                width: space * 0.1,
                                child: FlatButton(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: Colors.white),
                                  ),
                                  color: Color(0xFFF5F6F9),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, UploadProfileImageScreen.id);
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Space(space: space),
                Stack(
                  children: [
                    Container(
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
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "Personal Information",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),
                          ),
                          DetailsWidget(
                            title: "Name",
                            text: user.name,
                            icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Email",
                            text: user.email,
                            icon: Icons.email,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Contact Number",
                            text: user.mobileNumber,
                            icon: Icons.phone,
                            space: space,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, EditProfileScreen.id);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: Color(0xFF00BABA),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Space(space: space),
                Container(
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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        "Health Information",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                        ),
                      ),
                      DetailsWidget(
                        title: "Blood Group",
                        text: user.bloodGroup ?? "",
                        space: space,
                      ),
                      Space(space: space),
                      DetailsWidget(
                        title: "Weight",
                        text: "${user.weight.toString() ?? ""} KG" ?? "",
                        space: space,
                      ),
                      Space(space: space),
                      DetailsWidget(
                        title: "Gender",
                        text: user.gender ?? "",
                        space: space,
                      ),
                      Space(space: space),
                      DetailsWidget(
                        title: "Age",
                        text: user.age.toString() ?? "",
                        space: space,
                      ),
                    ],
                  ),
                ),
                Space(space: space),
                Container(
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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      DetailsWidget(
                        title: "Address",
                        text: "",
                        icon: Icons.location_on,
                        space: space,
                      ),
                      DetailsWidget(
                        title: "Street 1",
                        text: (user.addressBooks != null)
                            ? user.addressBooks.street1
                            : "",
                        icon: null,
                        space: space,
                      ),
                      Space(space: space),
                      DetailsWidget(
                        title: "Street 2",
                        text: (user.addressBooks != null)
                            ? user.addressBooks.street2
                            : "",
                        icon: null,
                        space: space,
                      ),
                      Space(space: space),
                      DetailsWidget(
                        title: "Street 3",
                        text: (user.addressBooks != null)
                            ? user.addressBooks.street3
                            : "",
                        icon: null,
                        space: space,
                      ),
                      Space(space: space),
                      DetailsWidget(
                        title: "City",
                        text: (user.addressBooks != null)
                            ? user.addressBooks.city
                            : "",
                        icon: null,
                        space: space,
                      ),
                      Space(space: space),
                      DetailsWidget(
                        title: "Country",
                        text: (user.addressBooks != null)
                            ? user.addressBooks.country
                            : "",
                        icon: null,
                        space: space,
                      ),
                    ],
                  ),
                ),
              ],
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

class DetailsWidget extends StatelessWidget {
  const DetailsWidget(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.text,
      @required this.space})
      : super(key: key);

  final IconData icon;
  final String title;
  final String text;
  final double space;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Color(0xFF00BABA),
              size: space * 0.06,
            ),
            SizedBox(
              width: space * 0.02,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: space * 0.08,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
