import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditec/resources/firebase_api.dart';

class NewMessageWidget extends StatefulWidget {
  final String toID;
  final String toName;
  final String myID;
  final String myName;

  const NewMessageWidget({
    @required this.myID,
    @required this.myName,
    @required this.toID,
    @required this.toName,
    Key key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();

    await FirebaseApi.uploadMessage(
        patientID: widget.myID,
        patientName: widget.myName,
        message: message,
        doctorID: widget.toID,
        doctorName: widget.toName);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  //labelText: 'Type your message',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: message.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF00BABA),
                ),
                child: Icon(Icons.send_rounded, color: Colors.white),
              ),
            ),
          ],
        ),
      );
}
