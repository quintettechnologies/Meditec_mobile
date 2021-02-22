import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditec/model/index.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/login_screen.dart';
import 'package:meditec/view/widget/textAndField.dart';

import 'dashboard_screen.dart';

class SignUpScreen extends HookWidget {
  static const String id = 'signup_screen';
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final mobileNumberController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/home.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
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
                    width: space * 0.7,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Create Account',
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: space * 0.0,
                        // ),
                        TextInputField(
                            text: "Name", controller: nameController),
                        TextInputField(
                            text: "Email", controller: emailController),
                        TextInputField(
                            text: "Phone", controller: mobileNumberController),
                        TextInputField(
                            text: "Password", controller: passwordController),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            User user = new User();
                            user.name = nameController.text;
                            user.email = emailController.text;
                            user.mobileNumber = mobileNumberController.text;
                            user.password = passwordController.text;
                            bool signUp =
                                await context.read(userProvider).signUp(user);

                            if (signUp) {
                              Navigator.pushNamed(context, Dashboard.id);
                            }
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
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Hero(
                          tag: 'signup_buton',
                          child: GestureDetector(
                            onTap: () {
                              print('Tapped Login');
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key key,
    @required this.text,
    @required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value.isEmpty) {
                return '$text is Empty';
              }
              return null;
            },
            style: TextStyle(
              fontSize: 16,
              height: 0.8,
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
    );
  }
}

// Container(
// padding: EdgeInsets.symmetric(vertical: 10),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text(
// 'Last Name',
// style: TextStyle(fontSize: 18, color: Colors.white),
// ),
// ],
// ),
// ),
// Container(
// child: TextField(
// onChanged: (value){
// lastName = value;
// },
// decoration: InputDecoration(
// filled: true,
// fillColor: Colors.white,
// hintText: 'Smith',
// hintStyle: TextStyle(fontSize: 16),
// border: OutlineInputBorder()),
// ),
// ),
// Container(
// padding: EdgeInsets.symmetric(vertical: 10),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text(
// 'Email',
// style: TextStyle(fontSize: 18, color: Colors.white),
// ),
// ],
// ),
// ),
// Container(
// child: TextField(
// decoration: InputDecoration(
// filled: true,
// fillColor: Colors.white,
// hintText: 'example@email.com',
// hintStyle: TextStyle(fontSize: 16),
// border: OutlineInputBorder()),
// ),
// ),
// Container(
// padding: EdgeInsets.symmetric(vertical: 10),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text(
// 'Phone',
// style: TextStyle(fontSize: 18, color: Colors.white),
// ),
// ],
// ),
// ),
// Container(
// child: TextField(
// decoration: InputDecoration(
// filled: true,
// fillColor: Colors.white,
// hintText: '0000000000',
// hintStyle: TextStyle(fontSize: 16),
// border: OutlineInputBorder()),
// ),
// ),
// Container(
// padding: EdgeInsets.symmetric(vertical: 10),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text(
// 'Password',
// style: TextStyle(fontSize: 18, color: Colors.white),
// ),
// ],
// ),
// ),
// Container(
// child: TextField(
// obscureText: true,
// decoration: InputDecoration(
// filled: true,
// fillColor: Colors.white,
// hintText: 'Enter Password',
// hintStyle: TextStyle(fontSize: 16),
// border: OutlineInputBorder()),
// ),
// ),
