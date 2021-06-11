import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditec/model/call.dart';
import 'package:meditec/model/review.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:progress_dialog/progress_dialog.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key key, @required this.call}) : super(key: key);

  final Call call;

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  ProgressDialog pr;
  double rating = 0;
  TextEditingController reviewController;
  FocusNode reviewFocus;

  @override
  void initState() {
    // TODO: implement initState
    reviewController = TextEditingController();
    reviewFocus = FocusNode();

    super.initState();
    initialize();
  }

  initialize() {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.rtl,
      isDismissible: true,
    );
    pr.style(
      message: 'Saving your feedback',
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    reviewController.dispose();
    reviewFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    final double vSpace = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(),
      drawer: MyCustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: vSpace * 0.01,
              ),
              Container(
                width: space,
                height: vSpace * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF000000).withOpacity(0.1),
                        offset: Offset.fromDirection(1),
                        blurRadius: 10,
                        spreadRadius: 1)
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Please give your feedback",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    RatingBar(
                      itemSize: space * 0.1,
                      wrapAlignment: WrapAlignment.end,
                      initialRating: 5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        half: Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: Icon(
                          Icons.star_border,
                          color: Color(0xFF3C4858),
                        ),
                      ),
                      itemPadding: EdgeInsets.symmetric(horizontal: 0),
                      onRatingUpdate: (rating) {
                        this.rating = rating;
                        print(this.rating);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: reviewController,
                        focusNode: reviewFocus,
                        maxLines: 4,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: space * .12,
                            width: space * 0.36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: space * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await pr.show();
                            User user = User();
                            User doctor = User();
                            Review review = Review();
                            user.userId = int.parse(widget.call.receiverId);
                            doctor.userId = int.parse(widget.call.callerId);
                            review.user = user;
                            review.doctor = doctor;
                            review.rating = this.rating;
                            review.feedback = reviewController.text;
                            bool submit = await context
                                .read(userProvider)
                                .submitReview(review);
                            if (submit) {
                              await pr.hide();
                              Fluttertoast.showToast(
                                  msg:
                                      "You feedback has been saved successfully.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            } else {
                              await pr.hide();
                              Fluttertoast.showToast(
                                  msg: "Something went wrong please try again.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: Container(
                            height: space * .12,
                            width: space * 0.36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFF00BABA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontSize: space * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: vSpace * 0.2,
              ),
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
