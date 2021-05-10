import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/addressBooks.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/callscreens/pickup/pickup_layout.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';

class EditProfileScreen extends StatefulWidget {
  static const String id = 'new_user';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController;
  FocusNode nameFocus;
  TextEditingController emailController;
  FocusNode emailFocus;
  // TextEditingController mobileNumberController;
  // FocusNode mobileNumberFocus;
  TextEditingController weightController;
  FocusNode weightFocus;
  TextEditingController ageController;
  FocusNode ageFocus;
  TextEditingController street1Controller;
  FocusNode street1Focus;
  TextEditingController street2Controller;
  FocusNode street2Focus;
  TextEditingController street3Controller;
  FocusNode street3Focus;
  TextEditingController cityController;
  FocusNode cityFocus;
  TextEditingController countryController;
  FocusNode countryFocus;
  TextEditingController zipController;
  FocusNode zipFocus;
  String bloodGroup;
  String gender;
  int bloodValue;
  int genderValue;

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController();
    nameFocus = FocusNode();
    emailController = TextEditingController();
    emailFocus = FocusNode();
    // mobileNumberController = TextEditingController();
    // mobileNumberFocus = FocusNode();
    weightController = TextEditingController();
    weightFocus = FocusNode();
    ageController = TextEditingController();
    ageFocus = FocusNode();
    street1Controller = TextEditingController();
    street1Focus = FocusNode();
    street2Controller = TextEditingController();
    street2Focus = FocusNode();
    street3Controller = TextEditingController();
    street3Focus = FocusNode();
    cityController = TextEditingController();
    cityFocus = FocusNode();
    countryController = TextEditingController();
    countryFocus = FocusNode();
    zipController = TextEditingController();
    zipFocus = FocusNode();
    super.initState();
    loadUserDetails();
  }

  loadUserDetails() {
    final userRepo = context.read(userProvider);
    nameController.text = userRepo.currentUser().name ?? "";
    emailController.text = userRepo.currentUser().email ?? "";
    // mobileNumberController.text = userRepo.currentUser().mobileNumber ?? "";
    weightController.text = userRepo.currentUser().weight.toString() ?? "";
    ageController.text = userRepo.currentUser().age.toString() ?? "";
    if (userRepo.currentUser().addressBooks != null) {
      street1Controller.text =
          userRepo.currentUser().addressBooks.street1 ?? "";
      street2Controller.text =
          userRepo.currentUser().addressBooks.street2 ?? "";
      street3Controller.text =
          userRepo.currentUser().addressBooks.street3 ?? "";
      cityController.text = userRepo.currentUser().addressBooks.city ?? "";
      countryController.text =
          userRepo.currentUser().addressBooks.country ?? "";
      zipController.text = userRepo.currentUser().addressBooks.zip ?? "";
    }
    bloodGroup = userRepo.currentUser().bloodGroup ?? "";
    gender = userRepo.currentUser().gender ?? "";
    setGenderValue();
    setBloodValue();
  }

  setGenderValue() {
    if (gender == "Male") {
      genderValue = 1;
    } else if (gender == "Female") {
      genderValue = 2;
    } else if (gender == "Transgender") {
      genderValue = 3;
    }
  }

  setBloodValue() {
    if (bloodGroup == "O-") {
      bloodValue = 1;
    } else if (bloodGroup == "O+") {
      bloodValue = 2;
    } else if (bloodGroup == "A-") {
      bloodValue = 3;
    } else if (bloodGroup == "A+") {
      bloodValue = 4;
    } else if (bloodGroup == "B-") {
      bloodValue = 5;
    } else if (bloodGroup == "B+") {
      bloodValue = 6;
    } else if (bloodGroup == "AB-") {
      bloodValue = 7;
    } else if (bloodGroup == "AB+") {
      bloodValue = 8;
    }
  }

  setGender() {
    if (genderValue == 1) {
      gender = "Male";
    } else if (genderValue == 2) {
      gender = "Female";
    } else if (genderValue == 3) {
      gender = "Transgender";
    }
  }

  setBloodGroup() {
    if (bloodValue == 1) {
      bloodGroup = "O-";
    } else if (bloodValue == 2) {
      bloodGroup = "O+";
    } else if (bloodValue == 3) {
      bloodGroup = "A-";
    } else if (bloodValue == 4) {
      bloodGroup = "A+";
    } else if (bloodValue == 5) {
      bloodGroup = "B-";
    } else if (bloodValue == 6) {
      bloodGroup = "B+";
    } else if (bloodValue == 7) {
      bloodGroup = "AB-";
    } else if (bloodValue == 8) {
      bloodGroup = "AB+";
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRepo = context.read(userProvider);
    final double space = MediaQuery.of(context).size.width;
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
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 18,
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
                // Space(space: space),
                // TextEditingField(
                //     text: "Phone",
                //     controller: mobileNumberController,
                //     focusNode: mobileNumberFocus,
                //     space: space),
                Space(space: space),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Blood Group",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: space * 0.1,
                      width: space * 0.5,
                      child: DropdownButton(
                        key: Key("blood"),
                        value: bloodValue,
                        hint: Text("Select blood group"),
                        items: [
                          DropdownMenuItem<int>(
                            child: Text('O-'),
                            value: 1,
                          ),
                          DropdownMenuItem<int>(
                            child: Text('O+'),
                            value: 2,
                          ),
                          DropdownMenuItem<int>(
                            child: Text('A-'),
                            value: 3,
                          ),
                          DropdownMenuItem<int>(
                            child: Text('A+'),
                            value: 4,
                          ),
                          DropdownMenuItem<int>(
                            child: Text('B-'),
                            value: 5,
                          ),
                          DropdownMenuItem<int>(
                            child: Text('B+'),
                            value: 6,
                          ),
                          DropdownMenuItem<int>(
                            child: Text('AB-'),
                            value: 7,
                          ),
                          DropdownMenuItem<int>(
                            child: Text('AB+'),
                            value: 8,
                          ),
                        ],
                        onChanged: (int value) {
                          setState(() {
                            bloodValue = value;
                            setBloodGroup();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Space(space: space),
                TextEditingField(
                  text: "Age",
                  space: space,
                  controller: ageController,
                  focusNode: ageFocus,
                ),
                Space(space: space),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Gender",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: space * 0.1,
                      width: space * 0.5,
                      child: DropdownButton(
                        key: Key("gender"),
                        value: genderValue,
                        hint: Text("Select gender"),
                        items: [
                          DropdownMenuItem<int>(
                            child: Text('Male'),
                            value: 1,
                          ),
                          DropdownMenuItem<int>(
                            child: Text('Female'),
                            value: 2,
                          ),
                          DropdownMenuItem<int>(
                            child: Text('Transgender'),
                            value: 3,
                          ),
                        ],
                        onChanged: (int value) {
                          setState(() {
                            genderValue = value;
                            setGender();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Space(space: space),
                TextEditingField(
                  text: "Weight",
                  space: space,
                  controller: weightController,
                  focusNode: weightFocus,
                ),
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
                          // Degree degree = Degree();
                          // Speciality speciality = Speciality();
                          user.name = nameController.text.trim();
                          user.email = emailController.text.trim();
                          // user.mobileNumber =
                          //     mobileNumberController.text.trim();
                          user.bloodGroup = bloodGroup;
                          user.weight =
                              double.parse(weightController.text.trim());
                          user.gender = gender;
                          user.age = int.parse(ageController.text.trim());
                          addressBook.street1 = street1Controller.text.trim();
                          addressBook.street2 = street2Controller.text.trim();
                          addressBook.street3 = street3Controller.text.trim();
                          addressBook.city = cityController.text.trim();
                          addressBook.country = countryController.text.trim();
                          addressBook.zip = zipController.text.trim();
                          user.addressBooks = addressBook;
                          bool status =
                              await context.read(userProvider).editUser(user);
                          if (status == true) {
                            Fluttertoast.showToast(
                                msg: "Successfully updated your profile!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Something went wrong! please try again.",
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
                            'Update',
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    nameFocus.dispose();
    emailController.dispose();
    emailFocus.dispose();
    // mobileNumberController.dispose();
    // mobileNumberFocus.dispose();
    weightController.dispose();
    weightFocus.dispose();
    ageController.dispose();
    ageFocus.dispose();
    street1Controller.dispose();
    street1Focus.dispose();
    street2Controller.dispose();
    street2Focus.dispose();
    street3Controller.dispose();
    street3Focus.dispose();
    cityController.dispose();
    cityFocus.dispose();
    countryController.dispose();
    countryFocus.dispose();
    zipController.dispose();
    zipFocus.dispose();
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
          style: TextStyle(fontSize: space * 0.04),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tight(Size(space * 0.5, space * 0.16)),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            textAlignVertical: TextAlignVertical.center,
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
