import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meditec/model/prescriptionReport.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';

import 'callscreens/pickup/pickup_layout.dart';

class ReportDetailScreen extends StatefulWidget {
  final PrescriptionReport report;

  const ReportDetailScreen({Key key, @required this.report}) : super(key: key);
  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return PickupLayout(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyCustomAppBar(),
        drawer: MyCustomDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: space,
                  child: Image(
                    fit: BoxFit.fitWidth,
                    image:
                        Image.memory(base64.decode(widget.report.image)).image,
                  ),
                ),
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
