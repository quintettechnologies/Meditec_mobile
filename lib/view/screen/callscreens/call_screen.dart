import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/call.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/resources/call_methods.dart';

class CallScreen extends StatefulWidget {
  final Call call;

  const CallScreen({Key key, @required this.call}) : super(key: key);
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "Meditec_E-Consult");
  final subjectText = TextEditingController(text: "Meditec_E-Consult");
  final nameText = TextEditingController(text: "");
  final emailText = TextEditingController(text: "");
  var isAudioOnly = false;
  var isAudioMuted = false;
  var isVideoMuted = false;

  StreamSubscription callStreamSubscription;
  CallMethods callMethods = CallMethods();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addPostFrameCallback();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceTerminated: _onConferenceTerminated, onError: _onError));
    startCall();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    callStreamSubscription.cancel();
    JitsiMeet.removeAllListeners();
  }

  addPostFrameCallback() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callStreamSubscription = callMethods
          .callStream(
              uid: context.read(userProvider).currentUser().userId.toString())
          .listen((DocumentSnapshot ds) async {
        // defining the logic
        // print(ds.data());
        switch (ds.data()) {
          case null:
            // snapshot is null which means that call is hanged and documents are deleted
            Navigator.pop(context);
            await JitsiMeet.closeMeeting();
            break;

          default:
            break;
        }
      });
    });
  }

  startCall() {
    roomText.text =
        widget.call.channelId.replaceAll(" ", "_").replaceAll(".", "");
    nameText.text = context.read(userProvider).currentUser().name;
    emailText.text = context.read(userProvider).currentUser().email;
    isAudioOnly = !widget.call.videoCall;
    isVideoMuted = !widget.call.videoCall;
    _joinMeeting();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      key: Key("call"),
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${widget.call.receiverName} has ended the call"),
              MaterialButton(
                onPressed: () async {
                  await callMethods.endCall(call: widget.call);
                  Navigator.pop(context);
                },
                color: Colors.red,
                child: Text(
                  "Back",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String serverUrl =
        serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;
    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.pipEnabled = false;
      featureFlag.toolboxAlwaysVisible = true;
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlag.callIntegrationEnabled = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlag.pipEnabled = false;
      }

      //uncomment to modify video resolution
      //featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;

      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlag = featureFlag;

      // debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          // debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          // debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          // debugPrint("${options.room} terminated with message: $message");
        }, onPictureInPictureWillEnter: ({message}) {
          // debugPrint("${options.room} entered PIP mode with message: $message");
        }, onPictureInPictureTerminated: ({message}) {
          // debugPrint("${options.room} exited PIP mode with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      // debugPrint("error: $error");
    }
  }

  Future<void> _onConferenceTerminated({message}) async {
    await callMethods.endCall(call: widget.call);
    // debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    // debugPrint("_onError broadcasted: $error");
  }
}
