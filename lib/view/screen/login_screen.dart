import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/screen/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numberController;
  TextEditingController passwordController;
  bool _inProcess = false;
  bool _numberValidator = false;
  bool _passWordValidator = false;

  @override
  void initState() {
    // TODO: implement initState
    numberController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    final double vSpace = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF00BABA),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 60,
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    height: vSpace * 0.3,
                    color: Color(0xFF00BABA),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: SvgPicture.asset(
                            'assets/images/meditec_logo.svg',
                            height: space * 0.4,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: vSpace * 0.02,
                        ),
                        Container(
                          // width: space * 0.7,
                          padding:
                              EdgeInsets.symmetric(horizontal: space * 0.15),
                          height: vSpace * 0.67,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Number',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF00BABA)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      controller: numberController,
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 0.8,
                                        color: Colors.black,
                                      ),
                                      obscureText: false,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Number',
                                        errorText: _numberValidator
                                            ? 'Number Can\'t Be Empty'
                                            : null,
                                        errorStyle: TextStyle(fontSize: 16),
                                        hintStyle: TextStyle(fontSize: 16),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Password',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF00BABA)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      controller: passwordController,
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 0.8,
                                        color: Colors.black,
                                      ),
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Password',
                                        errorText: _passWordValidator
                                            ? 'Password Can\'t Be Empty'
                                            : null,
                                        hintStyle: TextStyle(fontSize: 16),
                                        errorStyle: TextStyle(fontSize: 16),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Hero(
                                tag: 'login_button',
                                child: Consumer(
                                  builder: (context, watch, child) {
                                    return GestureDetector(
                                      onTap: () async {
                                        numberController.text.isEmpty
                                            ? _numberValidator = true
                                            : _numberValidator = false;
                                        passwordController.text.isEmpty
                                            ? _passWordValidator = true
                                            : _passWordValidator = false;
                                        if (!_numberValidator &&
                                            !_passWordValidator) {
                                          setState(() {
                                            _inProcess = true;
                                          });
                                          // print('Tapped Login');
                                          bool loginStatus = await context
                                              .read(userProvider)
                                              .login(numberController.text,
                                                  passwordController.text);
                                          if (loginStatus) {
                                            setState(() {
                                              _inProcess = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg: "Login Successful",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            Navigator.pushNamed(
                                                context, Dashboard.id);
                                          } else {
                                            setState(() {
                                              _inProcess = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg: "Login Failed",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        } else {
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color(0xFF00BABA),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0xFF000000)
                                                      .withOpacity(0.1),
                                                  offset:
                                                      Offset.fromDirection(1),
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
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                alignment: Alignment.center,
                                child: Text(
                                  'Login with social account',
                                  style: TextStyle(
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 14,
                                      color: Colors.black54),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.1),
                                              offset: Offset.fromDirection(1),
                                              blurRadius: 10,
                                              spreadRadius: -10)
                                        ]),
                                    child: SvgPicture.asset(
                                      'assets/icons/social/facebook.svg',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.1),
                                              offset: Offset.fromDirection(1),
                                              blurRadius: 10,
                                              spreadRadius: -10)
                                        ]),
                                    child: SvgPicture.asset(
                                      'assets/icons/social/google.svg',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.1),
                                              offset: Offset.fromDirection(1),
                                              blurRadius: 10,
                                              spreadRadius: -10)
                                        ]),
                                    child: SvgPicture.asset(
                                      'assets/icons/social/twitter.svg',
                                      height: 60,
                                      width: 60,
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  // print('Tapped Sign Up');
                                  Navigator.pushNamed(context, SignUpScreen.id);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  alignment: Alignment.center,
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Don\'t Have an account? ',
                                      style:
                                          TextStyle(color: Color(0xFF00BABA)),
                                      children: [
                                        TextSpan(
                                          text: 'Create Now',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          (_inProcess)
              ? Container(
                  color: Color(0xFF00BABA),
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: SpinKitCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                )
              : Center()
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    numberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
