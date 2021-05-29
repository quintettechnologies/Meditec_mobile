import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/call.dart';
import 'package:meditec/utils/notification_helper.dart';
import 'package:meditec/view/screen/24x7doctor_screen.dart';
import 'package:meditec/view/screen/appointents_list_screen.dart';
import 'package:meditec/view/screen/appointment_reports_list_screen.dart';
import 'package:meditec/view/screen/appointment_samples_list_screen.dart';
import 'package:meditec/view/screen/callscreens/call_screen.dart';
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

import 'constants.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true);

Future _firebaseMessagingBackgroundHandler(Map<String, dynamic> message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up : $message');
  if (message['data'] != null) {
    NotificationHelper.showNotification(
      title: message['data']['title'],
      body: message['data']['body'],
    );
  } else {
    NotificationHelper.showNotification(
      title: message['notification']['title'],
      body: message['notification']['body'],
    );
  }
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
  @override
  void initState() {
    // TODO: implement initState
    initializeFCM();
    super.initState();
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.pushNamed(context, Dashboard.id);
  }

  initializeFCM() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            // sound: RawResourceAndroidNotificationSound('arrive'),
            showWhen: true);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        await flutterLocalNotificationsPlugin.show(
          1,
          message['notification']['title'],
          message['notification']['body'],
          platformChannelSpecifics,
        );
        // _showItemDialog(message);
      },
      onBackgroundMessage: _firebaseMessagingBackgroundHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        await flutterLocalNotificationsPlugin.show(
          1,
          message['notification']['title'],
          message['notification']['body'],
          platformChannelSpecifics,
        );
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
        await flutterLocalNotificationsPlugin.show(
          1,
          message['notification']['title'],
          message['notification']['body'],
          platformChannelSpecifics,
        );
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
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
