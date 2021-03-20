import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meditec/model/index.dart';
import 'package:meditec/model/prescriptionReport.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';

class SamplePreviewScreen extends StatefulWidget {
  final SamplePicture sample;

  const SamplePreviewScreen({Key key, @required this.sample}) : super(key: key);
  @override
  _SamplePreviewScreenState createState() => _SamplePreviewScreenState();
}

class _SamplePreviewScreenState extends State<SamplePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  image: Image.memory(base64.decode(widget.sample.image)).image,
                ),
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
