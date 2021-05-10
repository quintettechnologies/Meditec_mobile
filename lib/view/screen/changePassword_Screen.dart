import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';

import 'callscreens/pickup/pickup_layout.dart';

class ChangePasswordScreen extends HookWidget {
  static const String id = 'change_password';
  @override
  Widget build(BuildContext context) {
    final userRepo = useProvider(userProvider);
    final double space = MediaQuery.of(context).size.width;
    final TextEditingController passwordController = useTextEditingController();
    final FocusNode passwordFocus = useFocusNode();
    final TextEditingController newPasswordController =
        useTextEditingController();
    final FocusNode newPasswordFocus = useFocusNode();
    final TextEditingController confirmPasswordController =
        useTextEditingController();
    final FocusNode confirmPasswordFocus = useFocusNode();
    return PickupLayout(
      scaffold: Scaffold(
        appBar: MyCustomAppBar(),
        drawer: MyCustomDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              children: [
                Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Space(space: space),
                TextEditingField(
                  text: "Current Password",
                  space: space,
                  controller: passwordController,
                  focusNode: passwordFocus,
                ),
                Space(space: space),
                TextEditingField(
                  text: "New Password",
                  space: space,
                  controller: newPasswordController,
                  focusNode: newPasswordFocus,
                ),
                Space(space: space),
                TextEditingField(
                  text: "Confirm Password",
                  space: space,
                  controller: confirmPasswordController,
                  focusNode: confirmPasswordFocus,
                ),
                Space(space: space),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer(builder: (context, watch, build) {
                      return InkWell(
                        onTap: () async {
                          if (newPasswordController.text ==
                              confirmPasswordController.text) {
                            bool status = await userRepo.changePassword(
                                previousPassword: passwordController.text,
                                newPassword: newPasswordController.text);
                            if (status == true) {
                              Fluttertoast.showToast(
                                  msg: "Successfully changed your password!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Something went wrong! please try again.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please confirm your new password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xFF00BABA)),
                          padding: EdgeInsets.symmetric(
                              vertical: space * 0.02, horizontal: space * 0.05),
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      );
                    })
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: MyCustomFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MyCustomNavBar(),
      ),
    );
  }
}

class Space extends StatelessWidget {
  const Space({
    Key key,
    @required this.space,
  }) : super(key: key);

  final double space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space * 0.02,
    );
  }
}

class TextEditingField extends StatelessWidget {
  TextEditingField(
      {@required this.text,
      @required this.controller,
      @required this.space,
      @required this.focusNode});

  final double space;
  final TextEditingController controller;
  final String text;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: space * 0.04),
        ),
        SizedBox(
          height: space * 0.02,
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tight(Size(space * 0.8, space * 0.16)),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            textAlignVertical: TextAlignVertical.center,
            obscureText: true,
            decoration: InputDecoration(
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
