import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/24x7doctor_screen.dart';
import 'package:meditec/view/screen/appointents_list_screen.dart';
import 'package:meditec/view/screen/appointment_reports_list_screen.dart';
import 'package:meditec/view/screen/appointment_samples_list_screen.dart';
import 'package:meditec/view/screen/category_doctor_screen.dart';
import 'package:meditec/view/screen/changePassword_Screen.dart';
import 'package:meditec/view/screen/doctor_screen.dart';
import 'package:meditec/view/screen/edit_profile_screen.dart';
import 'package:meditec/view/screen/home_screen.dart';
import 'package:meditec/view/screen/login_screen.dart';
import 'package:meditec/view/screen/notificationScreen.dart';
import 'package:meditec/view/screen/prescriptions_list_screen.dart';
import 'package:meditec/view/screen/profile_screen.dart';
import 'package:meditec/view/screen/signup_screen.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/screen/start_screen.dart';
import 'package:meditec/view/screen/upload_profile_image_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future _firebaseMessagingBackgroundHandler(Map<String, dynamic> message) async {
  print('A bg message just showed up : $message');
  if (message['data'] != null) {
    await showNotification(
      title: message['data']['title'],
      body: message['data']['body'],
    );
  }
}

Future showNotification({String title, String body}) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id', 'Incoming Calls', 'channel_description',
      icon: 'ic_launcher',
      importance: Importance.max,
      priority: Priority.max,
      ongoing: true,
      playSound: true,
      visibility: NotificationVisibility.public,
      enableVibration: true,
      enableLights: true,
      fullScreenIntent: true,
      ledColor: Color(0xFF00BABA),
      ledOnMs: 100,
      ledOffMs: 100,
      showWhen: true);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();

  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    initializeFCM();
    super.initState();
    getBatteryOptimizationPermission();
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  initializeFCM() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            showWhen: true);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        setNewNotification();
        if (message['data'] == null) {
          await flutterLocalNotificationsPlugin.show(
            1,
            message['notification']['title'],
            message['notification']['body'],
            platformChannelSpecifics,
          );
        }
      },
      onBackgroundMessage:
          Platform.isAndroid ? _firebaseMessagingBackgroundHandler : null,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        setNewNotification();
        if (message['data'] == null) {
          await flutterLocalNotificationsPlugin.show(
            1,
            message['notification']['title'],
            message['notification']['body'],
            platformChannelSpecifics,
          );
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setNewNotification();
        if (message['data'] == null) {
          await flutterLocalNotificationsPlugin.show(
            1,
            message['notification']['title'],
            message['notification']['body'],
            platformChannelSpecifics,
          );
        }
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      // print("Settings registered: $settings");
    });
  }

  getBatteryOptimizationPermission() async {
    var status = await Permission.ignoreBatteryOptimizations.status;
    // print(status.isGranted);
    if (!status.isGranted) {
      Permission.ignoreBatteryOptimizations.request();
    }
  }

  setNewNotification() async {
    // prefs = await SharedPreferences.getInstance();
    // prefs.setBool("newNotification", true);
    // print("new shared notification: ${prefs.getBool("newNotification")}");
    context.read(userProvider).setNewNotification(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Source Sans Pro',
        scaffoldBackgroundColor: kBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: StartScreen.id,
      routes: {
        StartScreen.id: (context) => StartScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        DoctorScreen.id: (context) => DoctorScreen(),
        NotificationScreen.id: (context) => NotificationScreen(),
        CategoryDoctorScreen.id: (context) => CategoryDoctorScreen(),
        Dashboard.id: (context) => Dashboard(),
        EditProfileScreen.id: (context) => EditProfileScreen(),
        ChangePasswordScreen.id: (context) => ChangePasswordScreen(),
        UploadProfileImageScreen.id: (context) => UploadProfileImageScreen(),
        AppointmentsScreen.id: (context) => AppointmentsScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        PrescriptionListScreen.id: (context) => PrescriptionListScreen(),
        AppointmentReportListScreen.id: (context) =>
            AppointmentReportListScreen(),
        AppointmentSampleListScreen.id: (context) =>
            AppointmentSampleListScreen(),
        EmergencyDoctorScreen.id: (context) => EmergencyDoctorScreen(),
      },
    );
  }
}
