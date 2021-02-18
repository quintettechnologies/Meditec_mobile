import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/edit_profile_screen.dart';
import 'package:meditec/view/screen/home_screen.dart';

class MyCustomDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    UserProvider user = useProvider(userProvider);
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color(0xFF3C4858)),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              user.loginStatus
                  ? Column(
                      children: [
                        DrawerHeader(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Image(
                                      image: Image.memory(base64.decode(user
                                              .currentUser()
                                              .userAvatar
                                              .image))
                                          .image,
                                      fit: BoxFit.fitHeight,
                                      height: 60,
                                    ),
                                    // child: Image(
                                    //   image:
                                    //       AssetImage('assets/images/profiles/user.png'),
                                    // ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${user.currentUser().name.toString()}',
                                        // 'Alex Horls',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "${user.currentUser().roles['name'].toString().toUpperCase()}",
                                        // "Patient",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Make your profile Premium and Get Offers",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFE8DA6C),
                                            Color(0xFFDEC35F),
                                            Color(0xFFCFA742),
                                            Color(0xFFCD9E3D),
                                            Color(0xFFD4AD49),
                                            Color(0xFFCFA742),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Color(0xFFE6C478))),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),

                        MenuHeader(text: 'Account'), //Devider
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, EditProfileScreen.id);
                            },
                            child: MenuItem(text: 'Edit Profile')),
                        MenuItem(text: 'Change password'),
                        MenuItem(text: 'My appointment'),
                        MenuItem(text: 'Report'),
                        MenuItem(text: 'Prescription'),
                        MenuItem(text: 'Feedback'),
                        MenuItem(text: 'Following'),
                      ],
                    )
                  : DrawerHeader(child: null),
              MenuHeader(text: 'Notification'),
              MenuOption(text: 'Notification', switchValue: false),
              MenuOption(text: 'App notification', switchValue: true),
              MenuHeader(text: 'More'),
              MenuItem(text: 'Language'),
              MenuItem(text: 'Support'),
              user.loginStatus
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Card(
                          color: Color(0xFF3C4858),
                          child: FlatButton(
                            onPressed: () async {
                              bool logout = await user.logout();
                              if (!logout) {
                                Navigator.popAndPushNamed(
                                    context, HomeScreen.id);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                    color: Color(0xFF6A6F77),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  MenuItem({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(color: Color(0xFF969CA7), fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF969CA7),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuOption extends StatelessWidget {
  MenuOption({this.text, this.switchValue});

  final String text;

  final bool switchValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(color: Color(0xFF969CA7), fontSize: 16),
            ),
          ),
          Transform.scale(
            scale: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  border: Border.all(
                    width: 0,
                  )),
              child: CupertinoSwitch(
                value: switchValue,
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuHeader extends StatelessWidget {
  MenuHeader({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/icons/sidebar/user-check.svg'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Divider(color: Colors.white),
        ),
      ],
    );
  }
}
