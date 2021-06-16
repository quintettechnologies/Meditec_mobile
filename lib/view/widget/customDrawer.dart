import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/appointents_list_screen.dart';
import 'package:meditec/view/screen/appointment_reports_list_screen.dart';
import 'package:meditec/view/screen/appointment_samples_list_screen.dart';
import 'package:meditec/view/screen/changePassword_Screen.dart';
import 'package:meditec/view/screen/edit_profile_screen.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:meditec/view/screen/home_screen.dart';
import 'package:meditec/view/screen/prescriptions_list_screen.dart';
import 'package:meditec/view/screen/profile_screen.dart';

class MyCustomDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    UserProvider user = useProvider(userProvider);
    double height = MediaQuery.of(context).size.height;
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  (user.currentUser().userAvatar != null)
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Image(
                                            image: Image.memory(base64.decode(
                                                    user
                                                        .currentUser()
                                                        .userAvatar
                                                        .image))
                                                .image,
                                            fit: BoxFit.fitHeight,
                                            height: 100,
                                          ),
                                          // child: Image(
                                          //   image:
                                          //       AssetImage('assets/images/profiles/user.png'),
                                          // ),
                                        )
                                      : Container(),
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
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${user.currentUser().roles.name.toString().toUpperCase()}",
                                        // "Patient",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              // Row(
                              //   children: [
                              //     Container(
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Text(
                              //           "Make your profile Premium and Get Offers",
                              //           style: TextStyle(color: Colors.white),
                              //         ),
                              //       ),
                              //       decoration: BoxDecoration(
                              //           gradient: LinearGradient(
                              //             colors: [
                              //               Color(0xFFE8DA6C),
                              //               Color(0xFFDEC35F),
                              //               Color(0xFFCFA742),
                              //               Color(0xFFCD9E3D),
                              //               Color(0xFFD4AD49),
                              //               Color(0xFFCFA742),
                              //             ],
                              //           ),
                              //           borderRadius: BorderRadius.all(
                              //             Radius.circular(10),
                              //           ),
                              //           border: Border.all(
                              //               color: Color(0xFFE6C478))),
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                        ),

                        MenuHeader(text: 'Account'), //Devider
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, ProfileScreen.id);
                            },
                            child: MenuItem(text: 'Edit Profile')),
                        // MenuItem(text: 'Change password'),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, AppointmentsScreen.id);
                            },
                            child: MenuItem(text: 'My appointments')),

                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, PrescriptionListScreen.id);
                            },
                            child: MenuItem(text: 'Prescriptions')),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, AppointmentReportListScreen.id);
                            },
                            child: MenuItem(text: 'Previous Reports')),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, AppointmentSampleListScreen.id);
                            },
                            child: MenuItem(text: 'Previous Samples')),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, ChangePasswordScreen.id);
                            },
                            child: MenuItem(text: 'Change Password')),
                        // MenuItem(text: 'Feedback'),
                        // MenuItem(text: 'Following'),
                      ],
                    )
                  : DrawerHeader(child: null),
              // MenuHeader(text: 'Notification'),
              // MenuOption(text: 'Notification', switchValue: false),
              // MenuOption(text: 'App notification', switchValue: true),
              MenuHeader(text: 'More'),
              MenuItem(text: 'Language'),
              MenuItem(text: 'Rating'),
              GestureDetector(
                  onTap: () {
                    UrlLauncher.launch("https://www.facebook.com/dacicilbd");
                  },
                  child: MenuItem(text: 'Facebook Page')), // facebook page
              GestureDetector(
                  onTap: () => showAboutDialog(
                          context: context,
                          applicationName: "Cicil",
                          applicationIcon: SvgPicture.asset(
                            'assets/images/meditec_logo.svg',
                            height: height * 0.12,
                            color: Color(0xFF00BABA),
                          ),
                          applicationLegalese: "Ⓒ 2021 Cicil",
                          applicationVersion: "June 2021",
                          children: [
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Text(
                                "About us:\n\nCicil Limited is a one-stop digital Medical service provider app for the people, from anywhere anyone can get medical consultation from reputed doctors for her/his any kind of health issues.\n\nCicil\'s mission is to bring Excellency in health sector by providing outstanding services to every  patient across the worldwide.")
                          ]),
                  child: MenuItem(text: 'About Us')), // about us
              GestureDetector(
                  onTap: () => showAboutDialog(
                        context: context,
                        applicationName: "Cicil",
                        applicationIcon: SvgPicture.asset(
                          'assets/images/meditec_logo.svg',
                          height: height * 0.12,
                          color: Color(0xFF00BABA),
                        ),
                        applicationLegalese: "Ⓒ 2021 Cicil",
                        applicationVersion: "June 2021",
                        children: [
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text("Contact Us"),
                          GestureDetector(
                            onTap: () =>
                                UrlLauncher.launch("http://www.dacicil.com"),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    CupertinoIcons.globe,
                                    color: Color(0xFF00BABA),
                                  ),
                                  SizedBox(
                                    width: height * 0.03,
                                  ),
                                  Text("www.dacicil.com"),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => UrlLauncher.launch(
                                "mailto:cicillimited@gmail.com"),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    CupertinoIcons.at,
                                    color: Color(0xFF00BABA),
                                  ),
                                  SizedBox(
                                    width: height * 0.03,
                                  ),
                                  Text("cicillimited@gmail.com"),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                UrlLauncher.launch("tel://01683418416"),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    CupertinoIcons.phone,
                                    color: Color(0xFF00BABA),
                                  ),
                                  SizedBox(
                                    width: height * 0.03,
                                  ),
                                  Text("01683418416"),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.location,
                                  color: Color(0xFF00BABA),
                                ),
                                SizedBox(
                                  width: height * 0.03,
                                ),
                                Expanded(
                                  child: Text(
                                      "House: 03, Block: A, Section: 04 , Housing State Cumilla, Bangladesh"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  child: MenuItem(text: 'Contact Us')), // contact us
              // MenuItem(text: 'Support & FAQ'),
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
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                    (Route<dynamic> route) => false);
                                // Navigator.popAndPushNamed(
                                //     context, HomeScreen.id);
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
