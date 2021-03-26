import 'package:flutter/material.dart';
import 'package:meditec/model/call.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/resources/call_methods.dart';
import 'package:meditec/view/screen/callscreens/call_screen.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({User from, User to, context}) async {
    Call call = Call(
      callerId: from.userId.toString(),
      callerName: from.name,
      //callerPic: from.profilePhoto,
      receiverId: to.userId.toString(),
      receiverName: to.name,
      //receiverPic: to.profilePhoto,
      channelId: from.name +
          to.name +
          DateTime.now().year.toString() +
          DateTime.now().month.toString() +
          DateTime.now().day.toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}
