import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/view/screen/24x7doctor_screen.dart';
import 'package:meditec/view/screen/appointents_list_screen.dart';
import 'package:meditec/view/screen/appointment_reports_list_screen.dart';
import 'package:meditec/view/screen/appointment_samples_list_screen.dart';
import 'package:meditec/view/screen/category_doctor_screen.dart';
import 'package:meditec/view/screen/doctor_screen.dart';
import 'package:meditec/view/screen/edit_profile_screen.dart';
import 'package:meditec/view/screen/home_screen.dart';
import 'package:meditec/view/screen/login_screen.dart';
import 'package:meditec/view/screen/prescriptions_list_screen.dart';
import 'package:meditec/view/screen/profile_screen.dart';
import 'package:meditec/view/screen/signup_screen.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/screen/upload_profile_image_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Source Sans Pro',
        scaffoldBackgroundColor: kBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        DoctorScreen.id: (context) => DoctorScreen(),
        CategoryDoctorScreen.id: (context) => CategoryDoctorScreen(),
        Dashboard.id: (context) => Dashboard(),
        EditProfileScreen.id: (context) => EditProfileScreen(),
        UploadProfileImageScreen.id: (context) => UploadProfileImageScreen(),
        AppointmentsScreen.id: (context) => AppointmentsScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        PrescriptionListScreen.id: (context) => PrescriptionListScreen(),
        AppointmentReportListScreen.id: (context) =>
            AppointmentReportListScreen(),
        AppointmentSampleListScreen.id: (context) =>
            AppointmentSampleListScreen(),
        EmergencyDoctorScreen.id: (context) => EmergencyDoctorScreen()
      },
    );
  }
}
