import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditec/model/index.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/edit_profile_screen.dart';
import 'package:meditec/view/screen/login_screen.dart';
import 'package:meditec/view/screen/profile_screen.dart';
import 'package:meditec/view/widget/textAndField.dart';

import 'dashboard_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController;
  FocusNode nameFocus;
  TextEditingController emailController;
  FocusNode emailFocus;
  TextEditingController mobileNumberController;
  FocusNode mobileNumberFocus;
  TextEditingController passwordController;
  FocusNode passwordFocus;
  bool _inProcess = false;

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController();
    emailController = TextEditingController();
    mobileNumberController = TextEditingController();
    passwordController = TextEditingController();
    nameFocus = FocusNode();
    emailFocus = FocusNode();
    mobileNumberFocus = FocusNode();
    passwordFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    passwordController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    mobileNumberFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF00BABA),
      body: Stack(
        children: [
          // SvgPicture.asset(
          //   'assets/images/signin-background.svg',
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   fit: BoxFit.cover,
          // ),
          SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Container(
                  width: space * 0.75,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Hero(
                              tag: 'logo',
                              child: SvgPicture.asset(
                                'assets/images/meditec_logo.svg',
                                height: space * 0.25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Create Account',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: space * 0.06,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Sign up to continue',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: space * 0.04,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: space * 0.0,
                      // ),
                      TextInputField(
                        text: "Name",
                        controller: nameController,
                        focus: nameFocus,
                      ),
                      TextInputField(
                        text: "Email",
                        controller: emailController,
                        focus: emailFocus,
                      ),
                      TextInputField(
                        text: "Mobile Number",
                        controller: mobileNumberController,
                        focus: mobileNumberFocus,
                      ),
                      TextInputField(
                        text: "Password",
                        controller: passwordController,
                        focus: passwordFocus,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            _inProcess = true;
                          });
                          User user = new User();
                          user.name = nameController.text;
                          user.email = emailController.text;
                          user.mobileNumber = mobileNumberController.text;
                          user.password = passwordController.text;
                          bool signUp =
                              await context.read(userProvider).signUp(user);
                          if (signUp) {
                            setState(() {
                              _inProcess = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Successfully Signed Up",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.pushNamed(context, Dashboard.id);
                            Navigator.pushNamed(context, ProfileScreen.id);
                            Navigator.pushNamed(context, EditProfileScreen.id);
                          } else {
                            setState(() {
                              _inProcess = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Signup Failed",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(top: 10),
                          width: 300,
                          // height: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00BABA)),
                            ),
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'signup_buton',
                        child: GestureDetector(
                          onTap: () {
                            // print('Tapped Login');
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: 'Already a user? ',
                                children: [
                                  TextSpan(
                                    text: 'Sign in',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
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
          (_inProcess)
              ? Container(
                  color: Colors.blue,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                )
              : Center()
        ],
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key key,
    @required this.text,
    @required this.controller,
    @required this.focus,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focus;
  final String text;

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: space * 0.043,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tight(Size(space * 0.75, space * 0.14)),
          child: TextFormField(
            focusNode: focus,
            controller: controller,
            validator: (value) {
              if (value.isEmpty) {
                return '$text is Empty';
              }
              return null;
            },
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              fontSize: space * 0.04,
              color: Colors.black,
            ),
            obscureText: (text == "Password") ? true : false,
            keyboardType: (text == "Email")
                ? TextInputType.emailAddress
                : (text == "Phone")
                    ? TextInputType.number
                    : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter $text',
              hintStyle: TextStyle(fontSize: space * 0.04),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
