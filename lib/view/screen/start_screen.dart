import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';

class StartScreen extends StatefulWidget {
  static const String id = 'start_screen';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  SharedPreferences loginData;
  bool newUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool('login') ?? true);
    // print(newUser);
    if (newUser == false) {
      context.read(userProvider).number = loginData.getString("number");
      context.read(userProvider).authToken = loginData.getString("authToken");
      context.read(userProvider).newNotification =
          loginData.getBool("newNotification") ?? false;
      bool login = await context.read(userProvider).loginRenew();
      if (login) {
        Fluttertoast.showToast(
            msg: "Successfully signed in",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.popAndPushNamed(context, Dashboard.id);
      } else {
        Fluttertoast.showToast(
            msg: "Please Sign In",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xFF00BABA),
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.popAndPushNamed(context, HomeScreen.id);
      }
    } else {
      Navigator.popAndPushNamed(context, HomeScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Color(0xFF00BABA),
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: space * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Hero(
                    tag: 'logo',
                    child: SvgPicture.asset(
                      'assets/images/meditec_logo.svg',
                      height: space * 0.6,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        child: SizedBox(
                          height: 20,
                          child: SpinKitWave(
                            color: Colors.white,
                            size: space * 0.45,
                            itemCount: 50,
                          ),
                        ),
                      ),
                      Text(
                        'Loading',
                        style: kButtonTextStyle.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
