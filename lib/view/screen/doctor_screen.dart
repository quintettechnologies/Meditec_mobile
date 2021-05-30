import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/category_doctor_screen.dart';
import 'package:meditec/view/screen/doctor_profile_screen.dart';
import 'package:meditec/view/widget/catagoryButton.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:meditec/model/category.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:meditec/constants.dart';
import '../../debouncer.dart';
import 'callscreens/pickup/pickup_layout.dart';
import 'chat_page.dart';

class DoctorScreen extends StatefulWidget {
  static const String id = 'doctor_screen';
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  ProgressDialog pr;
  final debouncer = Debouncer(milliseconds: 500);
  bool showEmptyMessage = false;
  String message = "Please type something to search";
  TextEditingController searchController;
  FocusNode searchFocus;
  List<User> result = [];
  bool _inProcess = false;
  bool expanded = false;
  List<Category> categories = [];
  List<User> doctors = [];
  List<User> emergencyDoctors = [];
  @override
  void initState() {
    // TODO: implement initState
    searchController = TextEditingController();
    searchFocus = FocusNode();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        searchFocus.unfocus();
      }
    });
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  initialize() async {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.rtl,
      isDismissible: false,
    );
    pr.style(
      message: 'Searching Doctors',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: SpinKitCircle(
        color: Color(0xFF00BABA),
        size: 50.0,
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 19.0,
      ),
    );
    categories = context.read(userProvider).categories;
    doctors = context.read(userProvider).doctors;
    emergencyDoctors = context.read(userProvider).emergencyDoctors;
    setState(() {});
    if (categories.isEmpty) {
      fetchCategories();
    }
    if (emergencyDoctors.isEmpty) {
      fetchEmergencyDoctors();
    }
  }

  fetchCategories() async {
    await context.read(userProvider).getCategories().then((value) {
      categories = context.read(userProvider).categories;
      setState(() {});
    });
  }

  fetchEmergencyDoctors() async {
    await context.read(userProvider).getEmergencyDoctorList().then((value) {
      emergencyDoctors = context.read(userProvider).emergencyDoctors;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;

    return PickupLayout(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyCustomAppBar(
          enableSearch: true,
          searchController: searchController,
          searchFocus: searchFocus,
          onChangedCallback: (query) async {
            debouncer.run(() async {
              if (query == "") {
                setState(() {
                  result.clear();
                  message = "Please type something to search";
                  showEmptyMessage = true;
                });
              } else {
                setState(() {
                  _inProcess = true;
                });
                result = await context.read(userProvider).globalSearch(query);
                if (result.isEmpty) {
                  message = "No match found";
                  showEmptyMessage = true;
                } else {
                  showEmptyMessage = false;
                }
                setState(() {
                  _inProcess = false;
                });
              }
            });
          },
        ),
        drawer: MyCustomDrawer(),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: space * 0.07),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                                fontSize: space * 0.05,
                                color: kPrimaryTextColor),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  expanded = !expanded;
                                });
                              },
                              child: !expanded
                                  ? Row(
                                      children: [
                                        Icon(Icons.expand_more),
                                        Text("See All")
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Icon(Icons.expand_less),
                                        Text("Close")
                                      ],
                                    ))
                        ],
                      ),
                      // FittedBox(
                      //   child: Row(
                      //     children: [
                      //       CategoryButton(
                      //         category: 'Heart',
                      //         color: Color(0xFFE3FFFF),
                      //       ),
                      //       SizedBox(width: space * 0.05),
                      //       CategoryButton(
                      //         category: 'Dental',
                      //         color: Color(0xFFE3E8FF),
                      //       ),
                      //       SizedBox(width: space * 0.05),
                      //       CategoryButton(
                      //         category: 'Brain',
                      //         color: Color(0xFFFFE3F1),
                      //       ),
                      //       SizedBox(width: space * 0.05),
                      //       CategoryButton(
                      //         category: 'Bone',
                      //         color: Color(0xFFFFF3E3),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      !expanded
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (Category category in categories)
                                    (category.name != "24/7")
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: InkWell(
                                              onTap: () async {
                                                pr.update(
                                                    message:
                                                        "Searching ${category.name}");
                                                await pr.show();

                                                bool list = await context
                                                    .read(userProvider)
                                                    .getCategoryDoctorList(
                                                        category.id);
                                                if (list) {
                                                  context
                                                          .read(userProvider)
                                                          .selectedCategory =
                                                      category;
                                                  await pr.hide();
                                                  Navigator.pushNamed(context,
                                                      CategoryDoctorScreen.id);
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Sorry, no doctor found!",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                  await pr.hide();
                                                }
                                              },
                                              child: Container(
                                                // padding: EdgeInsets.all(10),
                                                height: space * 0.25,
                                                width: space * 0.25,
                                                decoration: kButtonDecoration,
                                                child: Column(
                                                  children: [
                                                    ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: Material(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: Colors.white,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Container(
                                                                height:
                                                                    space * 0.1,
                                                                width:
                                                                    space * 0.1,
                                                                // child: Icon(
                                                                //   Icons.account_circle,
                                                                //   size: space * 0.1,
                                                                //   color: Color(0xFF00BABA),
                                                                // )
                                                                // child: SvgPicture
                                                                //     .asset(
                                                                //   "assets/icons/doctor_page/${category.name}.svg",
                                                                // ),
                                                                child: (category
                                                                            .icon !=
                                                                        null)
                                                                    ? Image(
                                                                        image: Image.memory(base64.decode(category.icon))
                                                                            .image,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      )
                                                                    : Container(),
                                                              ),
                                                            ),
                                                          ),
                                                        ) ??
                                                        Container(),
                                                    Text(
                                                      category.name,
                                                      style: kButtonTextStyle
                                                          .copyWith(
                                                              fontSize: space *
                                                                  0.036),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                ],
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                // crossAxisCount: 2,
                                // crossAxisSpacing: space * 0.01,
                                // childAspectRatio: 2.5 / 1
                              ),
                              shrinkWrap: true,
                              itemCount: categories.length,
                              itemBuilder: (BuildContext ctx, index) {
                                if (categories[index].name != "24/7") {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () async {
                                        pr.update(
                                            message:
                                                "Searching ${categories[index].name}");
                                        await pr.show();
                                        bool list = await context
                                            .read(userProvider)
                                            .getCategoryDoctorList(
                                                categories[index].id);
                                        if (list) {
                                          await pr.hide();
                                          context
                                                  .read(userProvider)
                                                  .selectedCategory =
                                              categories[index];
                                          Navigator.pushNamed(
                                              context, CategoryDoctorScreen.id);
                                        } else {
                                          await pr.hide();
                                          Fluttertoast.showToast(
                                              msg: "Sorry, no doctor found!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      },
                                      child: Container(
                                        // padding: EdgeInsets.all(10),
                                        height: space * 0.25,
                                        width: space * 0.25,
                                        decoration: kButtonDecoration,
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Container(
                                                        height: space * 0.1,
                                                        width: space * 0.1,
                                                        // child: Icon(
                                                        //   Icons.account_circle,
                                                        //   size: space * 0.1,
                                                        //   color: Color(0xFF00BABA),
                                                        // )
                                                        child:
                                                            (categories[index]
                                                                        .icon !=
                                                                    null)
                                                                ? Image(
                                                                    image: Image.memory(
                                                                            base64.decode(categories[index].icon))
                                                                        .image,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  )
                                                                : Container(),
                                                      ),
                                                    ),
                                                  ),
                                                ) ??
                                                Container(),
                                            Text(
                                              categories[index].name,
                                              style: kButtonTextStyle.copyWith(
                                                  fontSize: space * 0.036),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                      DefaultTabController(
                        length: 2, // length of tabs
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: TabBar(
                                indicator: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFF495767),
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                tabs: [
                                  Container(
                                    child: Text(
                                      'Top Specialists',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    height: space * 0.1,
                                    alignment: Alignment.center,
                                  ),
                                  Container(
                                    child: Text(
                                      '24/7 Doctor',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    height: space * 0.1,
                                    alignment: Alignment.center,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: space * 1, //height of TabBarView
                              // decoration: BoxDecoration(
                              //     border: Border(
                              //         top: BorderSide(
                              //             color: Colors.grey, width: 0.5))),
                              child: TabBarView(
                                children: <Widget>[
                                  Container(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          for (User doctor in doctors)
                                            (doctor.categories.isNotEmpty)
                                                ? (doctor.categories[0].name !=
                                                        "24/7")
                                                    ? FlatButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DoctorProfileScreen(
                                                                      doctor:
                                                                          doctor),
                                                            ),
                                                          );
                                                        },
                                                        padding: EdgeInsets.all(
                                                            space * 0.015),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color(
                                                                          0xFF000000)
                                                                      .withOpacity(
                                                                          0.1),
                                                                  offset: Offset
                                                                      .fromDirection(
                                                                          1),
                                                                  blurRadius:
                                                                      10,
                                                                  spreadRadius:
                                                                      1)
                                                            ],
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              (doctor.userAvatar !=
                                                                      null)
                                                                  ? Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              space * 0.17,
                                                                          width:
                                                                              space * 0.17,
                                                                          child:
                                                                              Image(
                                                                            image:
                                                                                Image.memory(base64.decode(doctor.userAvatar.image)).image,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Container(
                                                                        height: space *
                                                                            0.17,
                                                                        width: space *
                                                                            0.17,
                                                                      ),
                                                                    ),
                                                              SizedBox(
                                                                width: space *
                                                                    0.02,
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      doctor
                                                                          .name,
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      // (doctor.categories
                                                                      //         .isNotEmpty)
                                                                      //     ? doctor
                                                                      //         .categories[
                                                                      //             0]
                                                                      //         .name
                                                                      //     : "",
                                                                      doctor
                                                                          .speciality
                                                                          .speciality,
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    Text(
                                                                      (doctor.degree !=
                                                                              null)
                                                                          ? doctor
                                                                              .degree
                                                                              .degreeName
                                                                          : "",
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),

                                                                    Text(
                                                                      doctor.hospitalName ??
                                                                          "",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    Text(
                                                                      "${"Fee " + doctor.doctorFee.toString() ?? ""}",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    // Text(
                                                                    //     doctor
                                                                    //         .chambers[0].adress,
                                                                    //     style: TextStyle(
                                                                    //         fontSize: 13,
                                                                    //         fontWeight:
                                                                    //             FontWeight
                                                                    //                 .w500)),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: space *
                                                                    0.02,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        "Available",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Color(0xFF00BABA))),
                                                                    SizedBox(
                                                                      height:
                                                                          space *
                                                                              0.05,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          space *
                                                                              0.05,
                                                                      //width: space * 0.15,
                                                                      child:
                                                                          RatingBar(
                                                                        itemSize:
                                                                            10,
                                                                        wrapAlignment:
                                                                            WrapAlignment.end,
                                                                        initialRating:
                                                                            5,
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        itemCount:
                                                                            5,
                                                                        ratingWidget:
                                                                            RatingWidget(
                                                                          full:
                                                                              Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Color(0xFF3C4858),
                                                                          ),
                                                                          half:
                                                                              Icon(
                                                                            Icons.star_half,
                                                                            color:
                                                                                Color(0xFF3C4858),
                                                                          ),
                                                                          empty:
                                                                              Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                Color(0xFF3C4858),
                                                                          ),
                                                                        ),
                                                                        itemPadding:
                                                                            EdgeInsets.symmetric(horizontal: 0),
                                                                        onRatingUpdate:
                                                                            (rating) {
                                                                          print(
                                                                              rating);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Container()
                                                : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          for (User doctor in emergencyDoctors)
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(space * 0.015),
                                              child: InkWell(
                                                onTap: () {
                                                  UrlLauncher.launch(
                                                      "tel://${doctor.mobileNumber}");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color(
                                                                  0xFF000000)
                                                              .withOpacity(0.1),
                                                          offset: Offset
                                                              .fromDirection(1),
                                                          blurRadius: 10,
                                                          spreadRadius: 1)
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      (doctor.userAvatar !=
                                                              null)
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      space *
                                                                          0.17,
                                                                  width: space *
                                                                      0.17,
                                                                  child: Image(
                                                                    image: Image.memory(base64.decode(doctor
                                                                            .userAvatar
                                                                            .image))
                                                                        .image,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height: space *
                                                                    0.17,
                                                                width: space *
                                                                    0.17,
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        width: space * 0.02,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              doctor.name,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              (doctor.categories
                                                                      .isNotEmpty)
                                                                  ? doctor
                                                                      .categories[
                                                                          0]
                                                                      .name
                                                                  : "",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              (doctor.degree !=
                                                                      null)
                                                                  ? doctor
                                                                      .degree
                                                                      .degreeName
                                                                  : "",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              doctor.hospitalName ??
                                                                  "",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),

                                                            // Text(doctors[index].hospital,
                                                            //     style: TextStyle(
                                                            //         fontSize: 13,
                                                            //         fontWeight: FontWeight.w500)),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: space * 0.02,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ChatPage(user: doctor)));
                                                                },
                                                                child:
                                                                    Container(
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons
                                                                          .chat_bubble_rounded),
                                                                      SizedBox(
                                                                        width: space *
                                                                            0.01,
                                                                      ),
                                                                      Text(
                                                                          "Chat")
                                                                    ],
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   child: Consumer(
                                  //     builder: (context, watch, child) {
                                  //       List<Doctor> doctors = watch(doctorsProvider);
                                  //       return ListView.builder(
                                  //         itemCount: doctors.length,
                                  //         itemBuilder: (BuildContext ctxt, int index) =>
                                  //             FlatButton(
                                  //           onPressed: () {
                                  //             Navigator.pushNamed(
                                  //                 context, DoctorProfileScreen.id);
                                  //           },
                                  //           padding: EdgeInsets.all(space * 0.015),
                                  //           child: Container(
                                  //             decoration: BoxDecoration(
                                  //               color: Colors.white,
                                  //               borderRadius: BorderRadius.circular(10),
                                  //               boxShadow: [
                                  //                 BoxShadow(
                                  //                     color: Color(0xFF000000)
                                  //                         .withOpacity(0.1),
                                  //                     offset: Offset.fromDirection(1),
                                  //                     blurRadius: 10,
                                  //                     spreadRadius: 1)
                                  //               ],
                                  //             ),
                                  //             child: Row(
                                  //               children: [
                                  //                 Padding(
                                  //                   padding: const EdgeInsets.all(8.0),
                                  //                   child: ClipRRect(
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(10),
                                  //                     child: Container(
                                  //                       height: space * 0.17,
                                  //                       width: space * 0.17,
                                  //                       child: Image(
                                  //                         image: NetworkImage(
                                  //                             doctors[index].photoUrl),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   width: space * 0.02,
                                  //                 ),
                                  //                 Column(
                                  //                   crossAxisAlignment:
                                  //                       CrossAxisAlignment.start,
                                  //                   children: [
                                  //                     Text(
                                  //                       doctors[index].displayName,
                                  //                       style: TextStyle(
                                  //                           fontSize: 14,
                                  //                           fontWeight:
                                  //                               FontWeight.bold),
                                  //                     ),
                                  //                     Text(
                                  //                       doctors[index].degrees,
                                  //                       style: TextStyle(fontSize: 12),
                                  //                     ),
                                  //                     Text(
                                  //                       doctors[index].category,
                                  //                       style: TextStyle(fontSize: 12),
                                  //                     ),
                                  //                     Text(doctors[index].hospital,
                                  //                         style: TextStyle(
                                  //                             fontSize: 13,
                                  //                             fontWeight:
                                  //                                 FontWeight.w500)),
                                  //                   ],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   width: space * 0.02,
                                  //                 ),
                                  //                 Column(
                                  //                   crossAxisAlignment:
                                  //                       CrossAxisAlignment.end,
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment.spaceBetween,
                                  //                   children: [
                                  //                     Text(doctors[index].status,
                                  //                         style: TextStyle(
                                  //                             fontSize: 12,
                                  //                             fontWeight:
                                  //                                 FontWeight.bold,
                                  //                             color:
                                  //                                 Color(0xFF00BABA))),
                                  //                     SizedBox(
                                  //                       height: space * 0.05,
                                  //                     ),
                                  //                     Container(
                                  //                       height: space * 0.05,
                                  //                       //width: space * 0.15,
                                  //                       child: RatingBar(
                                  //                         itemSize: 10,
                                  //                         wrapAlignment:
                                  //                             WrapAlignment.end,
                                  //                         initialRating: (doctors[index]
                                  //                                     .rating ==
                                  //                                 null)
                                  //                             ? 5
                                  //                             : doctors[index].rating,
                                  //                         direction: Axis.horizontal,
                                  //                         allowHalfRating: true,
                                  //                         itemCount: 5,
                                  //                         ratingWidget: RatingWidget(
                                  //                           full: Icon(
                                  //                             Icons.star,
                                  //                             color: Color(0xFF3C4858),
                                  //                           ),
                                  //                           half: Icon(
                                  //                             Icons.star_half,
                                  //                             color: Color(0xFF3C4858),
                                  //                           ),
                                  //                           empty: Icon(
                                  //                             Icons.star_border,
                                  //                             color: Color(0xFF3C4858),
                                  //                           ),
                                  //                         ),
                                  //                         itemPadding:
                                  //                             EdgeInsets.symmetric(
                                  //                                 horizontal: 0),
                                  //                         onRatingUpdate: (rating) {
                                  //                           print(rating);
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              searchFocus.hasFocus
                  ? SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                Colors.white.withOpacity(0.5).withAlpha(1000)),
                        height: MediaQuery.of(context).size.height * 0.85,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              showEmptyMessage
                                  ? Container(
                                      child: Text(
                                        message,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    )
                                  : Container(),
                              for (User doctor in result)
                                FlatButton(
                                  onPressed: (doctor.roles.name.toUpperCase() ==
                                          "DOCTOR")
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorProfileScreen(
                                                      doctor: doctor),
                                            ),
                                          );
                                        }
                                      : null,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: space * 0.015,
                                      vertical: space * 0.01),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF000000)
                                                .withOpacity(0.1),
                                            offset: Offset.fromDirection(1),
                                            blurRadius: 10,
                                            spreadRadius: 1)
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        (doctor.userAvatar != null)
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    height: space * 0.17,
                                                    width: space * 0.17,
                                                    child: Image(
                                                      image: Image.memory(base64
                                                              .decode(doctor
                                                                  .userAvatar
                                                                  .image))
                                                          .image,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: space * 0.17,
                                                  width: space * 0.17,
                                                ),
                                              ),
                                        SizedBox(
                                          width: space * 0.02,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${doctor.name}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              (doctor.roles.name
                                                          .toUpperCase() ==
                                                      "DOCTOR")
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          (doctor.categories
                                                                  .isNotEmpty)
                                                              ? doctor
                                                                  .categories[0]
                                                                  .name
                                                              : "",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          (doctor.degree !=
                                                                  null)
                                                              ? doctor.degree
                                                                  .degreeName
                                                              : "",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          doctor.hospitalName ??
                                                              "",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: space * 0.02,
                                        ),
                                        (doctor.roles.name.toUpperCase() ==
                                                "DOCTOR")
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Available",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFF00BABA))),
                                                    SizedBox(
                                                      height: space * 0.05,
                                                    ),
                                                    Container(
                                                      height: space * 0.05,
                                                      //width: space * 0.15,
                                                      child: RatingBar(
                                                        itemSize: 10,
                                                        wrapAlignment:
                                                            WrapAlignment.end,
                                                        initialRating: 5,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        ratingWidget:
                                                            RatingWidget(
                                                          full: Icon(
                                                            Icons.star,
                                                            color: Color(
                                                                0xFF3C4858),
                                                          ),
                                                          half: Icon(
                                                            Icons.star_half,
                                                            color: Color(
                                                                0xFF3C4858),
                                                          ),
                                                          empty: Icon(
                                                            Icons.star_border,
                                                            color: Color(
                                                                0xFF3C4858),
                                                          ),
                                                        ),
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 0),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          // print(rating);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              (_inProcess)
                  ? Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      )),
                    )
                  : Center()
            ],
          ),
        ),
        floatingActionButton: MyCustomFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MyCustomNavBar(),
      ),
    );
  }
}
