import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/screen/login_screen.dart';
import 'package:meditec/view/screen/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/constants.dart';
import '../home_background.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF00BABA),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: space * 0.3,
          ),
          Center(
            child: Hero(
              tag: 'logo',
              child: SvgPicture.asset(
                'assets/images/meditec_logo.svg',
                height: space * 0.45,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: space * 0.3,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Hero(
                  tag: 'login_button',
                  child: GestureDetector(
                    onTap: () {
                      // print('Tapped Login');
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF000000).withOpacity(0.1),
                                offset: Offset.fromDirection(1),
                                blurRadius: 10,
                                spreadRadius: 1)
                          ]),
                      margin: EdgeInsets.only(top: 10),
                      width: 300,
                      // height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sign in',
                          style: kButtonTextStyle.copyWith(
                              color: Color(0xFF00BABA)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: space * 0.02,
                ),
                Hero(
                  tag: 'signup_buton',
                  child: GestureDetector(
                    onTap: () {
                      // print('Tapped Sign Up');
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF00BABA),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF000000).withOpacity(0.1),
                                offset: Offset.fromDirection(1),
                                blurRadius: 10,
                                spreadRadius: 1)
                          ]),
                      margin: EdgeInsets.only(top: 10),
                      width: 300,
                      // height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sign up',
                          style: kButtonTextStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                //   child: GestureDetector(
                //     onTap: () {
                //       print('Tapped Skip');
                //       Navigator.pushNamed(context, Dashboard.id);
                //     },
                //     child: Text(
                //       'Skip Now',
                //       style: TextStyle(fontSize: 16, color: Color(0xFF6D96EA)),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
