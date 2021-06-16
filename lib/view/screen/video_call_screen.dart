// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:jitsi_meet/feature_flag/feature_flag.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';
// import 'package:jitsi_meet/jitsi_meeting_listener.dart';
// import 'package:jitsi_meet/room_name_constraint.dart';
// import 'package:jitsi_meet/room_name_constraint_type.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:meditec/model/appointment.dart';
// import 'package:meditec/model/user.dart';
// import 'package:meditec/providers/user_provider.dart';
// import 'package:meditec/view/widget/customAppBar.dart';
//
// class VideoCall extends StatefulWidget {
//   final Appointment appointment;
//
//   const VideoCall({Key key, @required this.appointment}) : super(key: key);
//
//   static const String id = 'video_call';
//   @override
//   _VideoCallState createState() => _VideoCallState();
// }
//
// class _VideoCallState extends State<VideoCall> {
//   final serverText = TextEditingController();
//   final roomText = TextEditingController(text: "plugintestroom");
//   final subjectText = TextEditingController();
//   final nameText = TextEditingController(text: "Plugin Test User");
//   final emailText = TextEditingController(text: "fake@email.com");
//   var isAudioOnly = false;
//   var isAudioMuted = false;
//   var isVideoMuted = false;
//
//   @override
//   void initState() {
//     super.initState();
//     JitsiMeet.addListener(JitsiMeetingListener(
//         onConferenceWillJoin: _onConferenceWillJoin,
//         onConferenceJoined: _onConferenceJoined,
//         onConferenceTerminated: _onConferenceTerminated,
//         onPictureInPictureWillEnter: _onPictureInPictureWillEnter,
//         onPictureInPictureTerminated: _onPictureInPictureTerminated,
//         onError: _onError));
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     JitsiMeet.removeAllListeners();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final UserProvider userProv = context.read(userProvider);
//     roomText.text =
//         'E-consultancy_Room-${widget.appointment.id.toString() + "_" + widget.appointment.user.name.replaceAll(" ", "_").replaceAll(".", "")}';
//     subjectText.text =
//         "Cicil_E-consultancy-${widget.appointment.id.toString() + "_" + widget.appointment.user.name.replaceAll(" ", "_").replaceAll(".", "")}";
//     nameText.text = userProv.currentUser().name;
//     emailText.text = userProv.currentUser().email;
//     return MaterialApp(
//       home: Scaffold(
//         appBar: MyCustomAppBar(),
//         body: Container(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16.0,
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: 24.0,
//                 ),
//                 // TextField(
//                 //   controller: serverText,
//                 //   decoration: InputDecoration(
//                 //       border: OutlineInputBorder(),
//                 //       labelText: "Server URL",
//                 //       hintText: "Hint: Leave empty for meet.jitsi.si"),
//                 // ),
//                 SizedBox(
//                   height: 16.0,
//                 ),
//                 TextField(
//                   controller: roomText,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Room",
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16.0,
//                 ),
//                 TextField(
//                   controller: subjectText,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Subject",
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16.0,
//                 ),
//                 TextField(
//                   controller: nameText,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Display Name",
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16.0,
//                 ),
//                 TextField(
//                   controller: emailText,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Email",
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16.0,
//                 ),
//                 // SizedBox(
//                 //   height: 16.0,
//                 // ),
//                 // CheckboxListTile(
//                 //   title: Text("Audio Only"),
//                 //   value: isAudioOnly,
//                 //   onChanged: _onAudioOnlyChanged,
//                 // ),
//                 // SizedBox(
//                 //   height: 16.0,
//                 // ),
//                 // CheckboxListTile(
//                 //   title: Text("Audio Muted"),
//                 //   value: isAudioMuted,
//                 //   onChanged: _onAudioMutedChanged,
//                 // ),
//                 // SizedBox(
//                 //   height: 16.0,
//                 // ),
//                 // CheckboxListTile(
//                 //   title: Text("Video Muted"),
//                 //   value: isVideoMuted,
//                 //   onChanged: _onVideoMutedChanged,
//                 // ),
//                 Divider(
//                   height: 48.0,
//                   thickness: 2.0,
//                 ),
//                 SizedBox(
//                   height: 64.0,
//                   width: double.maxFinite,
//                   child: RaisedButton(
//                     onPressed: () {
//                       _joinMeeting();
//                     },
//                     child: Text(
//                       "Join Call",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     color: Colors.blue,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 48.0,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _onAudioOnlyChanged(bool value) {
//     setState(() {
//       isAudioOnly = value;
//     });
//   }
//
//   _onAudioMutedChanged(bool value) {
//     setState(() {
//       isAudioMuted = value;
//     });
//   }
//
//   _onVideoMutedChanged(bool value) {
//     setState(() {
//       isVideoMuted = value;
//     });
//   }
//
//   _joinMeeting() async {
//     String serverUrl =
//         serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;
//
//     try {
//       // Enable or disable any feature flag here
//       // If feature flag are not provided, default values will be used
//       // Full list of feature flags (and defaults) available in the README
//       FeatureFlag featureFlag = FeatureFlag();
//       featureFlag.welcomePageEnabled = false;
//       // Here is an example, disabling features for each platform
//       if (Platform.isAndroid) {
//         // Disable ConnectionService usage on Android to avoid issues (see README)
//         featureFlag.callIntegrationEnabled = false;
//       } else if (Platform.isIOS) {
//         // Disable PIP on iOS as it looks weird
//         featureFlag.pipEnabled = false;
//       }
//
//       //uncomment to modify video resolution
//       //featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;
//
//       // Define meetings options here
//       var options = JitsiMeetingOptions()
//         ..room = roomText.text
//         ..serverURL = serverUrl
//         ..subject = subjectText.text
//         ..userDisplayName = nameText.text
//         ..userEmail = emailText.text
//         ..audioOnly = isAudioOnly
//         ..audioMuted = isAudioMuted
//         ..videoMuted = isVideoMuted
//         ..featureFlag = featureFlag;
//
//       // debugPrint("JitsiMeetingOptions: $options");
//       await JitsiMeet.joinMeeting(
//         options,
//         listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
//           // debugPrint("${options.room} will join with message: $message");
//         }, onConferenceJoined: ({message}) {
//           // debugPrint("${options.room} joined with message: $message");
//         }, onConferenceTerminated: ({message}) {
//           // debugPrint("${options.room} terminated with message: $message");
//         }, onPictureInPictureWillEnter: ({message}) {
//           // debugPrint("${options.room} entered PIP mode with message: $message");
//         }, onPictureInPictureTerminated: ({message}) {
//           // debugPrint("${options.room} exited PIP mode with message: $message");
//         }),
//         // by default, plugin default constraints are used
//         //roomNameConstraints: new Map(), // to disable all constraints
//         //roomNameConstraints: customContraints, // to use your own constraint(s)
//       );
//     } catch (error) {
//       // debugPrint("error: $error");
//     }
//   }
//
//   static final Map<RoomNameConstraintType, RoomNameConstraint>
//       customContraints = {
//     RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
//       return value.trim().length <= 50;
//     }, "Maximum room name length should be 30."),
//     RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
//       return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
//               .hasMatch(value) ==
//           false;
//     }, "Currencies characters aren't allowed in room names."),
//   };
//
//   void _onConferenceWillJoin({message}) {
//     // debugPrint("_onConferenceWillJoin broadcasted with message: $message");
//   }
//
//   void _onConferenceJoined({message}) {
//     // debugPrint("_onConferenceJoined broadcasted with message: $message");
//   }
//
//   void _onConferenceTerminated({message}) {
//     // debugPrint("_onConferenceTerminated broadcasted with message: $message");
//   }
//
//   void _onPictureInPictureWillEnter({message}) {
//     // debugPrint(
//     //      "_onPictureInPictureWillEnter broadcasted with message: $message");
//   }
//
//   void _onPictureInPictureTerminated({message}) {
//     // debugPrint(
//     //      "_onPictureInPictureTerminated broadcasted with message: $message");
//   }
//
//   _onError(error) {
//     // debugPrint("_onError broadcasted: $error");
//   }
// }
