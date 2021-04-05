import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditec/model/appointment.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'dart:io';
import 'package:meditec/model/user.dart';

import '../constants.dart';
import 'callscreens/pickup/pickup_layout.dart';

class UploadPreviousReportScreen extends StatefulWidget {
  static const String id = 'upload_previous_report';

  final Appointment appointment;

  const UploadPreviousReportScreen({Key key, @required this.appointment})
      : super(key: key);

  @override
  _UploadPreviousReportScreenState createState() =>
      _UploadPreviousReportScreenState();
}

class _UploadPreviousReportScreenState
    extends State<UploadPreviousReportScreen> {
  File _report;
  bool _inProcess = false;

  bool _isImage() {
    if (_report != null) {
      if (_report.path.endsWith(".pdf")) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  _getPDF() async {
    this.setState(() {
      _inProcess = true;
    });
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);
    if (result != null) {
      File file = File(result.files.single.path);

      this.setState(() {
        _report = file;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  _getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          //aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          //compressQuality: 100,
          //maxWidth: 700,
          //maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Color(0xFF00BABA),
            toolbarTitle: "Meditec",
            statusBarColor: Color(0xFF00BABA),
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _report = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

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
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Upload previous document',
                      style: TextStyle(
                          fontSize: space * 0.05, color: kPrimaryTextColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _report != null
                        ? _isImage()
                            ? Image(
                                image: FileImage(_report),
                              )
                            : Container(
                                height: space * 0.5,
                                width: space * 0.5,
                                color: Colors.green,
                                child: Icon(
                                  Icons.picture_as_pdf,
                                  size: space * 0.5,
                                  color: Colors.white,
                                ),
                              )
                        : Container(
                            height: space * 0.5,
                            width: space * 0.5,
                            color: Colors.grey,
                            child: Icon(
                              Icons.upload_file,
                              size: space * 0.5,
                            ),
                          ),
                    SizedBox(
                      height: space * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            // _getImage(ImageSource.camera);
                            _getPDF();
                          },
                          child: Container(
                            width: space * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.picture_as_pdf,
                                  color: Color(0xFF00BABA),
                                ),
                                Text('PDF')
                              ],
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _getImage(ImageSource.camera);
                          },
                          child: Container(
                            width: space * 0.18,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Color(0xFF00BABA),
                                ),
                                Text('Camera')
                              ],
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _getImage(ImageSource.gallery);
                          },
                          child: Container(
                            width: space * 0.18,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Color(0xFF00BABA),
                                ),
                                Text('Gallery')
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: space * 0.1,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        setState(() {
                          _inProcess = true;
                        });
                        bool upload = await context
                            .read(userProvider)
                            .uploadReports(_report, widget.appointment.id);
                        if (upload) {
                          Fluttertoast.showToast(
                              msg: "Upload successful!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          setState(() {
                            _inProcess = false;
                          });
                          Navigator.pop(context, true);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Something went wrong! please try again.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          setState(() {
                            _inProcess = false;
                          });
                        }
                      },
                      child: Container(
                        width: space * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.save,
                              color: Color(0xFF00BABA),
                            ),
                            SizedBox(
                              width: space * 0.02,
                            ),
                            Text('Save')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                (_inProcess)
                    ? Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.95,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )
                    : Center()
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
