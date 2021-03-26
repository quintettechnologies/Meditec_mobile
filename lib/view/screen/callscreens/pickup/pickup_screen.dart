import 'package:flutter/material.dart';
import 'package:meditec/model/call.dart';
import 'package:meditec/resources/call_methods.dart';
import '../call_screen.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class PickupScreen extends StatefulWidget {
  final Call call;

  PickupScreen({
    @required this.call,
  });

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlutterRingtonePlayer.stop();
  }

  final CallMethods callMethods = CallMethods();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    FlutterRingtonePlayer.playRingtone(
        volume: 1, looping: true, asAlarm: false);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: height * 0.1),
            Text(
              (widget.call.videoCall)
                  ? "Incoming Video Call..."
                  : "Incoming Voice Call...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: height * 0.1),
            Text(
              widget.call.callerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: height * 0.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallScreen(call: widget.call),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.all(width * 0.03),
                    child: Icon(
                      Icons.call,
                      size: width * 0.15,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: width * 0.2),
                MaterialButton(
                  onPressed: () async {
                    await callMethods.endCall(call: widget.call);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.all(width * 0.03),
                    child: Icon(
                      Icons.call_end,
                      size: width * 0.15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
