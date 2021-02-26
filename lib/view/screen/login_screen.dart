import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/screen/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookWidget {
  static const String id = 'login_screen';
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    final numberController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/signin-background.svg',
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Container(
                  width: space * 0.7,
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 60,
                      // ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Hero(
                              tag: 'logo',
                              child: SvgPicture.asset(
                                'assets/images/meditec_logo.svg',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(vertical: 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Login to your account',
                      //         style: TextStyle(
                      //             fontFamily: 'Source Sans Pro',
                      //             fontSize: 24,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.white),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Number',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              controller: numberController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Number is Empty';
                                }
                                return null;
                              },
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password is Empty';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                height: 0.8,
                                color: Colors.black,
                              ),
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Password',
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
                      // TextAndField(
                      //   text: 'Password',
                      //   variable: password,
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Hero(
                        tag: 'login_button',
                        child: Consumer(
                          builder: (context, watch, child) {
                            return GestureDetector(
                              onTap: () async {
                                print('Tapped Login');
                                bool loginStatus = await context
                                    .read(userProvider)
                                    .login(numberController.text,
                                        passwordController.text);
                                if (loginStatus) {
                                  Navigator.pushNamed(context, Dashboard.id);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xFF2474FE),
                                    border:
                                        Border.all(color: Colors.blueAccent)),
                                margin: EdgeInsets.only(top: 10),
                                width: 300,
                                // height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
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
                              color: Colors.white),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/icons/social/facebook.svg',
                              height: 60,
                              width: 60,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/icons/social/google.svg',
                              height: 60,
                              width: 60,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                          print('Tapped Sign Up');
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: 'Don\'t Have an account? ',
                              children: [
                                TextSpan(
                                  text: 'Create Now',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
