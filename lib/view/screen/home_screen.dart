import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/screen/doctor_screen.dart';
import 'package:meditec/view/screen/login_screen.dart';
import 'package:meditec/view/screen/signup_screen.dart';

import '../constants.dart';
import '../home_background.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          home_background(),
          Center(
            child: Hero(
              tag: 'logo',
              child: SvgPicture.asset(
                'assets/images/meditec_logo.svg',
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Hero(
                  tag: 'login_button',
                  child: GestureDetector(
                    onTap: () {
                      print('Tapped Login');
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF2474FE),
                          border: Border.all(color: Colors.blueAccent)),
                      margin: EdgeInsets.only(top: 10),
                      width: 300,
                      // height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Login',
                          style: kButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: 'signup_buton',
                  child: GestureDetector(
                    onTap: () {
                      print('Tapped Sign Up');
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFF2663E2),
                      ),
                      margin: EdgeInsets.only(top: 10),
                      width: 300,
                      // height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sign Up',
                          style: kButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      print('Tapped Skip');
                      Navigator.pushNamed(context, Dashboard.id);
                    },
                    child: Text(
                      'Skip Now',
                      style: TextStyle(fontSize: 16, color: Color(0xFF6D96EA)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
