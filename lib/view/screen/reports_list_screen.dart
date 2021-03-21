import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
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

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//=======================

  @override
  void initState() {
    // TODO: implement initState
    getReports();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
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

  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.high, importance: Importance.max);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess
            ? 'File has been downloaded successfully!'
            : 'There was an error while downloading the file.',
        platform,
        payload: json);
  }

  _save(PrescriptionReport report) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };
    setState(() {
      loading = true;
    });
    Uint8List data = base64Decode(report.image);
    String name = report.fileTye;

    var file = await writeFile(data, name);
    if (file != null) {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(
          msg: "Successfully saved to Downloads folder",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      result['isSuccess'] = true;
      result['filePath'] = file.path;
      await _showNotification(result);
    } else {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(
          msg: "Something went wrong! Failed to save the file.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      result['error'] = "Failed to save the file";
      await _showNotification(result);
    }
  }

  Future<File> writeFile(Uint8List data, String name) async {
    // storage permission ask
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    // the downloads folder path
    Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
    String tempPath = tempDir.path;
    var filePath = tempPath + '/$name';
    //

    // the data
    var bytes = ByteData.view(data.buffer);
    final buffer = bytes.buffer;
    // save the data in the path
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

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
                                                      : () {
                                                          _save(report);
                                                        },
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
                                      Padding(
                                        padding: EdgeInsets.all(space * 0.02),
                                        child: TextButton(
                                          onPressed: () {
                                            _save(report);
                                          },
                                          child: Container(
                                            height: space * 0.1,
                                            width: space * 0.1,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.blueAccent),
                                            child: Icon(
                                              Icons.save,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: space * 0.02,
                                      ),
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
