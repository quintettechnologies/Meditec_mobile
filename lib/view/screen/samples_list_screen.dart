import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditec/model/appointment.dart';
import 'package:meditec/model/index.dart';
import 'package:meditec/model/prescriptionReport.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/report_detail_screen.dart';
import 'package:meditec/view/screen/sample_preview_screen.dart';
import 'package:meditec/view/screen/upload_sample_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants.dart';
import 'callscreens/pickup/pickup_layout.dart';

class SampleListScreen extends StatefulWidget {
  final Appointment appointment;

  const SampleListScreen({Key key, @required this.appointment})
      : super(key: key);
  @override
  _SampleListScreenState createState() => _SampleListScreenState();
}

class _SampleListScreenState extends State<SampleListScreen> {
  List<SamplePicture> samples = [];
  bool loading = false;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    // TODO: implement initState
    getSamples();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
    super.initState();
  }

  getSamples() async {
    setState(() {
      loading = true;
    });
    samples = await context.read(userProvider).getPreviousSamples(
          widget.appointment.id,
        );
    setState(() {
      loading = false;
    });
  }

  deleteSample(SamplePicture sample) async {
    setState(() {
      loading = true;
    });
    bool delete = await context.read(userProvider).deletePreviousSample(sample);
    if (delete) {
      getSamples();
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
            ? 'File has been downloaded successfully! Tap to open the file.'
            : 'There was an error while downloading the file.',
        platform,
        payload: json);
  }

  _save(SamplePicture sample) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };
    setState(() {
      loading = true;
    });
    Uint8List data = base64Decode(sample.image);
    String name = sample.fileType;

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
    String tempDir = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    String tempPath = tempDir;
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
    return PickupLayout(
      scaffold: Scaffold(
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
                        'Samples',
                        style: TextStyle(
                            fontSize: space * 0.05, color: kPrimaryTextColor),
                      ),
                      SizedBox(
                        height: space * 0.1,
                      ),
                      Column(
                        children: [
                          for (SamplePicture sample in samples)
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
                                        (sample.image != null)
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SamplePreviewScreen(
                                                                    sample:
                                                                        sample,
                                                                  )));
                                                    },
                                                    child: Container(
                                                      height: space * 0.17,
                                                      width: space * 0.17,
                                                      child: Image(
                                                        image: Image.memory(
                                                                base64.decode(
                                                                    sample
                                                                        .image))
                                                            .image,
                                                      ),
                                                    ),
                                                    // child: Container(
                                                    //     height: space * 0.17,
                                                    //     width: space * 0.17,
                                                    //     color: Colors.green,
                                                    //     child: Icon(
                                                    //       Icons.picture_as_pdf,
                                                    //       color: Colors.white,
                                                    //       size: space * 0.17,
                                                    //     )),
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
                                              _save(sample);
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
                                        Padding(
                                          padding: EdgeInsets.all(space * 0.02),
                                          child: TextButton(
                                            onPressed: () {
                                              deleteSample(sample);
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
                          (samples.isEmpty)
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      onPressed: () async {
                        bool upload = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploadSampleScreen(
                              appointment: widget.appointment,
                            ),
                          ),
                        );

                        if (upload) {
                          await getSamples();
                        }
                      },
                      child: Container(
                        width: space * 0.21,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.upload_file,
                              size: space * 0.07,
                              color: Color(0xFF00BABA),
                            ),
                            SizedBox(
                              width: space * 0.02,
                            ),
                            Text('Upload')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                loading
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: space,
                        color: Colors.white,
                        child: Center(
                          child: SpinKitCircle(
                            color: Color(0xFF00BABA),
                            size: 50.0,
                          ),
                        ),
                      )
                    : Container()
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
      ),
    );
  }
}
