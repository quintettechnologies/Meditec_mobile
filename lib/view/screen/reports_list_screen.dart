import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditec/model/appointment.dart';
import 'package:meditec/model/prescriptionReport.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/report_detail_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants.dart';
import '../constants.dart';

class ReportsListScreen extends StatefulWidget {
  final Appointment appointment;

  const ReportsListScreen({Key key, @required this.appointment})
      : super(key: key);
  @override
  _ReportsListScreenState createState() => _ReportsListScreenState();
}

class _ReportsListScreenState extends State<ReportsListScreen> {
  List<PrescriptionReport> reports = [];
  bool loading = false;
  double progress = 0;

//=======================

  @override
  void initState() {
    // TODO: implement initState
    getReports();
    super.initState();
  }

  getReports() async {
    setState(() {
      loading = true;
    });
    reports = await context.read(userProvider).getPreviousReports(
          widget.appointment.id,
        );
    setState(() {
      loading = false;
    });
  }

  deleteReport(PrescriptionReport report) async {
    setState(() {
      loading = true;
    });
    bool delete = await context.read(userProvider).deletePreviousReport(report);
    if (delete) {
      getReports();
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
        loading = false;
      });
    }
  }

  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }
  //
  // Future<String> getFilePath() async {
  //   Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  //   String newPath = "";
  //   print(appDocumentsDirectory);
  //   List<String> paths = appDocumentsDirectory.path.split("/");
  //   for (int x = 1; x < paths.length; x++) {
  //     String folder = paths[x];
  //     if (folder != "Android") {
  //       newPath += "/" + folder;
  //     } else {
  //       break;
  //     }
  //   }
  //   newPath = newPath + "/Meditec";
  //   appDocumentsDirectory = Directory(newPath); // 2
  //   String filePath = '$appDocumentsDirectory/demoTextFile.txt'; // 3
  //
  //   return filePath;
  // }
  //
  // void saveFile() async {
  //   File file = File(await getFilePath()); // 1
  //   file.writeAsString(
  //       "This is my demo text that will be saved to : demoTextFile.txt");
  //   print(file.path); // 2
  // }
  //
  // writeToFile(PrescriptionReport report) async {
  //   Directory directory;
  //   try {
  //     if (Platform.isAndroid) {
  //       if (await _requestPermission(Permission.storage)) {
  //         directory = await getExternalStorageDirectory();
  //         String newPath = "";
  //         print(directory);
  //         List<String> paths = directory.path.split("/");
  //         for (int x = 1; x < paths.length; x++) {
  //           String folder = paths[x];
  //           if (folder != "Android") {
  //             newPath += "/" + folder;
  //           } else {
  //             break;
  //           }
  //         }
  //         newPath = newPath + "/Meditec";
  //         directory = Directory(newPath);
  //       } else {
  //         return false;
  //       }
  //     }
  //     File saveFile = await File(directory.path + "/${report.fileTye}");
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //     if (await directory.exists()) {
  //       await saveFile.writeAsBytes(base64.decode(report.image));
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  //   // Directory tempDir = await getTemporaryDirectory();
  //   // String tempPath = tempDir.path;
  //   // var filePath = tempPath +
  //   //     '/${report.fileTye}'; // file_01.tmp is dump file, can be anything
  //   // print(filePath);
  //   // return new File(filePath).writeAsBytes(base64.decode(report.image));
  // }
  //
  // savePDF(PrescriptionReport report) async {
  //   setState(() {
  //     loading = true;
  //   });
  //   bool save = await writeToFile(report);
  //   if (save) {
  //     setState(() {
  //       loading = false;
  //     });
  //   } else {
  //     setState(() {
  //       loading = false;
  //     });
  //     Fluttertoast.showToast(
  //         msg: "Save file failed!",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(),
      drawer: MyCustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Stack(
            children: [
              Container(
                width: space * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Reports',
                      style: TextStyle(
                          fontSize: space * 0.05, color: kPrimaryTextColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        for (PrescriptionReport report in reports)
                          Padding(
                            padding: EdgeInsets.all(space * 0.01),
                            child: Container(
                              width: space * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  width: space * 0.9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      (report.image != null)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: GestureDetector(
                                                  onTap: (!report.fileTye
                                                          .endsWith(".pdf"))
                                                      ? () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ReportDetailScreen(
                                                                            report:
                                                                                report,
                                                                          )));
                                                        }
                                                      : () {},
                                                  child: (!report.fileTye
                                                          .endsWith(".pdf"))
                                                      ? Container(
                                                          height: space * 0.17,
                                                          width: space * 0.17,
                                                          child: Image(
                                                            image: Image.memory(
                                                                    base64.decode(
                                                                        report
                                                                            .image))
                                                                .image,
                                                          ),
                                                        )
                                                      : Container(
                                                          height: space * 0.17,
                                                          width: space * 0.17,
                                                          color: Colors.green,
                                                          child: Icon(
                                                            Icons
                                                                .picture_as_pdf,
                                                            color: Colors.white,
                                                            size: space * 0.17,
                                                          )),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: space * 0.17,
                                                    width: space * 0.17,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        width: space * 0.02,
                                      ),
                                      Text(report.fileTye),
                                      Padding(
                                        padding: EdgeInsets.all(space * 0.02),
                                        child: TextButton(
                                          onPressed: () {
                                            deleteReport(report);
                                          },
                                          child: Container(
                                            height: space * 0.1,
                                            width: space * 0.1,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.redAccent),
                                            child: Icon(
                                              Icons.delete_forever,
                                              color: Colors.white,
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
                        (reports.isEmpty)
                            ? Text(
                                'No previous documents to show',
                                style: TextStyle(
                                    fontSize: space * 0.04,
                                    color: kPrimaryTextColor),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
              loading ? Center(child: CircularProgressIndicator()) : Container()
            ],
          ),
        ),
      ),
      // body: Center(
      //   child: Container(
      //     child: FlatButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, DoctorScreen.id);
      //         },
      //         child: Text("Doctors")),
      //   ),
      // ),
      floatingActionButton: MyCustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
