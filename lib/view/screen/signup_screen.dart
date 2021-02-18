import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditec/view/screen/login_screen.dart';
import 'package:meditec/view/widget/textAndField.dart';

String firstName;
String lastName;
String email;
String phoneNumber;
String password;

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
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
                      // Container(
                      //   padding: EdgeInsets.symmetric(vertical: 20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Create Account',
                      //         style: TextStyle(
                      //             fontFamily: 'Source Sans Pro',
                      //             fontSize: 24,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.white),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: space * 0.01,
                      ),
                      TextAndField(
                        text: 'First Name',
                        variable: firstName,
                      ),
                      TextAndField(
                        text: 'Last Name',
                        variable: lastName,
                      ),
                      TextAndField(
                        text: 'Email',
                        variable: email,
                      ),
                      TextAndField(
                        text: 'Phone',
                        variable: phoneNumber,
                      ),
                      TextAndField(
                        text: 'Password',
                        variable: password,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Tapped SignUp');
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
        ],
      ),
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
