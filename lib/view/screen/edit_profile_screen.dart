import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/upload_profile_image_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';

class EditProfileScreen extends HookWidget {
  static const String id = 'edit_profile';

  @override
  Widget build(BuildContext context) {
    //final userRepo = useProvider(userProvider);
    final name = useTextEditingController();
    final email = useTextEditingController();
    final mobileNumber = useTextEditingController();
    final double space = MediaQuery.of(context).size.width;
    // name.text = '${userRepo.currentUser().name}';
    // email.text = '${userRepo.currentUser().email}';
    // mobileNumber.text = '${userRepo.currentUser().mobileNumber}';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(),
      drawer: MyCustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Space(space: space),
              Consumer(builder: (context, watch, child) {
                //User user = context.read(userProvider).currentUser();
                return SizedBox(
                  height: space * 0.25,
                  width: space * 0.25,
                  child: Stack(
                    fit: StackFit.expand,
                    overflow: Overflow.visible,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        // child: Image(
                        //   image: user.name == null
                        //       ? AssetImage('assets/images/profiles/user.png')
                        //       : Image.memory(
                        //               base64.decode(user.userAvatar['image']))
                        //           .image,
                        //   fit: BoxFit.fill,
                        //   height: space * 0.25,
                        //   width: space * 0.25,
                        // ),
                        child: Image(
                          height: space * 0.25,
                          width: space * 0.25,
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/profiles/user.png'),
                        ),
                      ),
                      Positioned(
                        right: -10,
                        bottom: -10,
                        child: SizedBox(
                          height: space * 0.1,
                          width: space * 0.1,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.white),
                            ),
                            color: Color(0xFFF5F6F9),
                            onPressed: () {
                              Navigator.popAndPushNamed(
                                  context, UploadProfileImageScreen.id);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) => MyImagePicker()));
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
              Space(space: space),
              Space(space: space),
              TextEditingField(
                text: 'First Name',
                space: space,
                controller: name,
              ),
              Space(space: space),
              TextEditingField(
                text: 'Email',
                space: space,
                controller: email,
              ),
              Space(space: space),
              TextEditingField(
                text: 'Phone Number',
                space: space,
                controller: mobileNumber,
              ),
              Space(space: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer(builder: (context, watch, build) {
                    return InkWell(
                      onTap: () {
                        // User user = User();
                        // user.name = name.text;
                        // user.email = email.text;
                        // user.mobileNumber = mobileNumber.text;
                        // context.read(userProvider).editUser(user);
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
      height: space * 0.05,
    );
  }
}

class TextEditingField extends StatelessWidget {
  TextEditingField({
    @required this.text,
    @required this.space,
    @required this.controller,
  });

  final double space;
  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: space * 0.1,
          width: space * 0.5,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
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
