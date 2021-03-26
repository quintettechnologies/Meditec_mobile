import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/call.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/resources/call_methods.dart';
import 'package:meditec/view/screen/callscreens/pickup/pickup_screen.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();

  PickupLayout({
    @required this.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    return (context.read(userProvider).currentUser() != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(
                uid:
                    context.read(userProvider).currentUser().userId.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data() != null) {
                Call call = Call.fromMap(snapshot.data.data());

                if (call.hasDialled != null) {
                  return PickupScreen(call: call);
                }
              }
              return scaffold;
            },
          )
        : scaffold;
  }
}
