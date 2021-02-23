import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/addressBooks.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/screen/upload_profile_image_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';

class EditProfileScreen extends HookWidget {
  static const String id = 'edit_profile';
  @override
  Widget build(BuildContext context) {
    final userRepo = useProvider(userProvider);
    final AddressBooks addressBooks = userRepo.currentUser().addressBooks;
    final nameController = useTextEditingController
        .fromValue(TextEditingValue(text: userRepo.currentUser().name));
    final nameFocus = useFocusNode();
    final emailController = useTextEditingController
        .fromValue(TextEditingValue(text: userRepo.currentUser().email));
    final emailFocus = useFocusNode();
    final mobileNumberController = useTextEditingController
        .fromValue(TextEditingValue(text: userRepo.currentUser().mobileNumber));
    final mobileNumberFocus = useFocusNode();
    final street1Controller = useTextEditingController
        .fromValue(TextEditingValue(text: addressBooks.street1 ?? ""));
    final street1Focus = useFocusNode();
    final street2Controller = useTextEditingController
        .fromValue(TextEditingValue(text: addressBooks.street2 ?? ""));
    final street2Focus = useFocusNode();
    final street3Controller = useTextEditingController
        .fromValue(TextEditingValue(text: addressBooks.street3 ?? ""));
    final street3Focus = useFocusNode();
    final cityController = useTextEditingController
        .fromValue(TextEditingValue(text: addressBooks.city ?? ""));
    final cityFocus = useFocusNode();
    final countryController = useTextEditingController
        .fromValue(TextEditingValue(text: addressBooks.country ?? ""));
    final countryFocus = useFocusNode();
    final zipController = useTextEditingController
        .fromValue(TextEditingValue(text: addressBooks.zip ?? ""));
    final zipFocus = useFocusNode();

    final double space = MediaQuery.of(context).size.width;
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
              SizedBox(
                height: space * 0.25,
                width: space * 0.25,
                child: Stack(
                  fit: StackFit.expand,
                  overflow: Overflow.visible,
                  children: [
                    (userRepo.currentUser().userAvatar != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image(
                              image: Image.memory(base64.decode(
                                      userRepo.currentUser().userAvatar.image))
                                  .image,
                              fit: BoxFit.cover,
                              height: 60,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image(
                              image:
                                  AssetImage('assets/images/profiles/user.png'),
                              fit: BoxFit.cover,
                              height: 60,
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
              ),
              Space(space: space),
              TextEditingField(
                text: 'Name',
                controller: nameController,
                focusNode: nameFocus,
                space: space,
              ),
              Space(space: space),
              TextEditingField(
                text: 'Email',
                controller: emailController,
                focusNode: emailFocus,
                space: space,
              ),
              Space(space: space),
              TextEditingField(
                  text: "Phone",
                  controller: mobileNumberController,
                  focusNode: mobileNumberFocus,
                  space: space),
              Space(space: space),
              TextEditingField(
                  text: "Street 1",
                  controller: street1Controller,
                  focusNode: street1Focus,
                  space: space),
              Space(space: space),
              TextEditingField(
                  text: "Street 2",
                  controller: street2Controller,
                  focusNode: street2Focus,
                  space: space),
              Space(space: space),
              TextEditingField(
                  text: "Street 3",
                  controller: street3Controller,
                  focusNode: street3Focus,
                  space: space),
              Space(space: space),
              TextEditingField(
                  text: "City",
                  controller: cityController,
                  focusNode: cityFocus,
                  space: space),
              Space(space: space),
              TextEditingField(
                  text: "Country",
                  controller: countryController,
                  focusNode: countryFocus,
                  space: space),
              Space(space: space),
              TextEditingField(
                  text: "Zip",
                  controller: zipController,
                  focusNode: zipFocus,
                  space: space),
              Space(space: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer(builder: (context, watch, build) {
                    return InkWell(
                      onTap: () async {
                        User user = User();
                        AddressBooks addressBook = AddressBooks();
                        user.name = nameController.text.trim();
                        user.email = emailController.text.trim();
                        user.mobileNumber = mobileNumberController.text.trim();
                        addressBook.street1 = street1Controller.text.trim();
                        addressBook.street2 = street2Controller.text.trim();
                        addressBook.street3 = street3Controller.text.trim();
                        addressBook.city = cityController.text.trim();
                        addressBook.country = countryController.text.trim();
                        addressBook.zip = zipController.text.trim();

                        user.addressBooks = addressBook;

                        // print("*************************************");
                        // print(user.toJson());
                        // print("*************************************");
                        // print(user.addressBooks.toJson());
                        // print("*************************************");
                        bool status =
                            await context.read(userProvider).editUser(user);
                        if (status == true) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, Dashboard.id, (route) => false);
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
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
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
